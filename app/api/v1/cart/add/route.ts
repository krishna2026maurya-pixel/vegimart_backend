import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Cart from '@/lib/models/Cart';
import Product from '@/lib/models/Product';
import { authMiddleware } from '@/lib/auth';

/**
 * POST /api/v1/cart/add
 * Body: { product_id: string, qty?: number }
 *
 * - qty defaults to 1 (increment by 1)
 * - If product already in cart, increments qty by `qty`
 * - Returns updated cart summary with cart_count per product
 */
async function addToCart(request: NextRequest, userId: string) {
  try {
    await connectDB();

    const body = await request.json().catch(() => ({}));
    const { product_id, qty = 1 } = body;

    if (!product_id) {
      return NextResponse.json({ success: false, error: 'product_id is required.' }, { status: 400 });
    }

    const qtyNum = Math.max(1, Number(qty));

    // Validate product exists
    const product = await Product.findById(product_id).lean() as any;
    if (!product) {
      return NextResponse.json({ success: false, error: 'Product not found.' }, { status: 404 });
    }
    if (product.is_active === '0') {
      return NextResponse.json({ success: false, error: 'Product is not available.' }, { status: 400 });
    }

    const price = product.selling_price || product.mrp || 0;

    // Find or create cart
    let cart = await Cart.findOne({ user_id: userId });
    if (!cart) {
      cart = new Cart({ user_id: userId, items: [] });
    }

    // Increment qty if already in cart, else add new item
    const existingIndex = cart.items.findIndex(
      (item: any) => item.product_id.toString() === product_id
    );

    if (existingIndex > -1) {
      cart.items[existingIndex].qty += qtyNum;
      cart.items[existingIndex].price = price; // always sync to latest price
    } else {
      cart.items.push({ product_id, qty: qtyNum, price });
    }

    await cart.save();

    // ─── Build cart summary ─────────────────────────────────────────────────
    const cartSummary = buildCartSummary(cart.items, product_id);

    return NextResponse.json({
      success: true,
      message: 'Product added to cart.',
      data: cartSummary,
    });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

// Shared helper: compute cart totals + per-product cart_count
function buildCartSummary(items: any[], changedProductId?: string) {
  let total_amount = 0;
  let total_mrp = 0;

  const cartQtyMap: Record<string, number> = {};
  const cartProductList = items.map((item: any) => {
    const pid = item.product_id?.toString();
    const qty = item.qty || 1;
    const price = item.price || 0;

    total_amount += price * qty;
    total_mrp += price * qty; // we use selling_price as mrp fallback
    cartQtyMap[pid] = qty;

    return {
      product_id: pid,
      qty_in_cart: qty,
      unit_price: price,
      subtotal: parseFloat((price * qty).toFixed(2)),
    };
  });

  return {
    cart_count: items.length,                              // number of distinct products in cart
    total_items_qty: items.reduce((s: number, i: any) => s + (i.qty || 1), 0), // total qty across all products
    total_cart_amount: parseFloat(total_amount.toFixed(2)),
    cart_products: cartProductList,
    // For the changed product, expose its new cart_count directly
    ...(changedProductId && {
      updated_product: {
        product_id: changedProductId,
        cart_count: cartQtyMap[changedProductId] || 0,
        is_in_cart: (cartQtyMap[changedProductId] || 0) > 0,
      },
    }),
  };
}

export { buildCartSummary };
export const POST = authMiddleware(addToCart);
