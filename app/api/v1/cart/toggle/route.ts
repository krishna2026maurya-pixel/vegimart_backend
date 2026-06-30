import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Cart from '@/lib/models/Cart';
import Product from '@/lib/models/Product';
import { authMiddleware } from '@/lib/auth';

/**
 * POST /api/v1/cart/toggle
 *
 * Body: { product_id: string, status: "add" | "remove" }
 *
 * "add"    → +1 every time called
 * "remove" → -1 every time called (auto-removes when reaches 0)
 *
 * Bas itna — baaki sab backend handle karta hai.
 */
async function handleCart(request: NextRequest, userId: string) {
  try {
    await connectDB();

    const body = await request.json().catch(() => ({}));
    const { product_id, status } = body;

    if (!product_id) {
      return NextResponse.json({ success: false, error: 'product_id is required.' }, { status: 400 });
    }
    if (status !== 'add' && status !== 'remove') {
      return NextResponse.json({ success: false, error: 'status must be "add" or "remove".' }, { status: 400 });
    }

    // Load or create cart
    let cart = await Cart.findOne({ user_id: userId });
    if (!cart) {
      cart = new Cart({ user_id: userId, items: [] });
    }

    const idx: number = cart.items.findIndex(
      (item: any) => item.product_id.toString() === product_id
    );

    let new_cart_count = 0;

    if (status === 'add') {
      // Validate product exists (only on first add)
      if (idx === -1) {
        const product: any = await Product.findById(product_id).select('selling_price mrp is_active').lean();
        if (!product) {
          return NextResponse.json({ success: false, error: 'Product not found.' }, { status: 404 });
        }
        const price = product.selling_price || product.mrp || 0;
        cart.items.push({ product_id, qty: 1, price });
        new_cart_count = 1;
      } else {
        cart.items[idx].qty += 1;
        new_cart_count = cart.items[idx].qty;
      }
    } else {
      // remove
      if (idx === -1) {
        return NextResponse.json({ success: false, error: 'Product is not in cart.' }, { status: 404 });
      }
      cart.items[idx].qty -= 1;
      if (cart.items[idx].qty <= 0) {
        cart.items.splice(idx, 1);
        new_cart_count = 0;
      } else {
        new_cart_count = cart.items[idx].qty;
      }
    }

    await cart.save();

    // Cart totals
    let total = 0;
    let total_qty = 0;
    cart.items.forEach((item: any) => {
      total += (item.price || 0) * (item.qty || 1);
      total_qty += item.qty || 1;
    });

    return NextResponse.json({
      success: true,
      data: {
        updated_product: {
          product_id,
          cart_count: new_cart_count,    // qty of this product in cart
          is_in_cart: new_cart_count > 0,
        },
        cart_summary: {
          cart_count: cart.items.length, // distinct products
          total_items_qty: total_qty,    // total qty across all
          total_cart_amount: parseFloat(total.toFixed(2)),
        },
      },
    });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

export const POST = authMiddleware(handleCart);
export const PUT = authMiddleware(handleCart);
