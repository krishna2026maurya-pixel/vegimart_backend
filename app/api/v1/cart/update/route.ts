import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Cart from '@/lib/models/Cart';
import { authMiddleware } from '@/lib/auth';

/**
 * POST/PATCH /api/v1/cart/update
 * Body: { product_id: string, qty: number }
 *
 * Sets the qty of a product in cart to exact value.
 * If qty <= 0, removes the product from cart.
 * Returns updated cart summary with cart_count for the changed product.
 */
async function updateCartQty(request: NextRequest, userId: string) {
  try {
    await connectDB();

    const body = await request.json().catch(() => ({}));
    const { product_id, qty } = body;

    if (!product_id || qty === undefined) {
      return NextResponse.json({ success: false, error: 'product_id and qty are required.' }, { status: 400 });
    }

    const cart = await Cart.findOne({ user_id: userId });
    if (!cart) {
      return NextResponse.json({ success: false, error: 'Cart not found.' }, { status: 404 });
    }

    const itemIndex = cart.items.findIndex(
      (item: any) => item.product_id.toString() === product_id
    );

    let new_cart_count = 0;

    if (itemIndex > -1) {
      if (Number(qty) <= 0) {
        cart.items.splice(itemIndex, 1);
        new_cart_count = 0;
      } else {
        cart.items[itemIndex].qty = Number(qty);
        new_cart_count = Number(qty);
      }
      await cart.save();
    } else {
      return NextResponse.json({ success: false, error: 'Product not in cart.' }, { status: 404 });
    }

    // Build summary
    let total_amount = 0;
    const cartProductList = cart.items.map((item: any) => {
      const q = item.qty || 1;
      const p = item.price || 0;
      total_amount += p * q;
      return {
        product_id: item.product_id?.toString(),
        qty_in_cart: q,
        unit_price: p,
        subtotal: parseFloat((p * q).toFixed(2)),
      };
    });

    return NextResponse.json({
      success: true,
      message: new_cart_count === 0 ? 'Product removed from cart.' : 'Cart updated.',
      data: {
        cart_count: cart.items.length,
        total_items_qty: cart.items.reduce((s: number, i: any) => s + (i.qty || 1), 0),
        total_cart_amount: parseFloat(total_amount.toFixed(2)),
        cart_products: cartProductList,
        updated_product: {
          product_id,
          cart_count: new_cart_count,
          is_in_cart: new_cart_count > 0,
        },
      },
    });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

export const PATCH = authMiddleware(updateCartQty);
export const POST = authMiddleware(updateCartQty);
