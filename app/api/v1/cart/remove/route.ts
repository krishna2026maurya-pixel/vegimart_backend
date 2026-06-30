import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Cart from '@/lib/models/Cart';
import { authMiddleware } from '@/lib/auth';

/**
 * POST/DELETE /api/v1/cart/remove
 * Body: { product_id: string, action?: 'decrement' | 'remove_all' }
 *
 * action = 'decrement' (default): reduces qty by 1, removes item if qty reaches 0
 * action = 'remove_all'         : removes the product completely from cart
 *
 * Returns updated cart summary with cart_count for the changed product
 */
async function removeFromCart(request: NextRequest, userId: string) {
  try {
    await connectDB();

    // Support both JSON body and URL param
    let product_id: string | null = null;
    let action = 'decrement';

    if (request.method === 'DELETE' || request.method === 'GET') {
      // Support /cart/remove/[productId] style via URL
      const url = new URL(request.url);
      const segments = url.pathname.split('/').filter(Boolean);
      product_id = segments[segments.length - 1] || null;
      action = url.searchParams.get('action') || 'decrement';
    } else {
      const body = await request.json().catch(() => ({}));
      product_id = body.product_id || null;
      action = body.action || 'decrement';
    }

    if (!product_id || product_id === 'remove') {
      return NextResponse.json({ success: false, error: 'product_id is required.' }, { status: 400 });
    }

    const cart = await Cart.findOne({ user_id: userId });
    if (!cart) {
      return NextResponse.json({ success: false, error: 'Cart is empty.' }, { status: 404 });
    }

    const itemIndex = cart.items.findIndex(
      (item: any) => item.product_id.toString() === product_id
    );

    if (itemIndex === -1) {
      return NextResponse.json({ success: false, error: 'Product not in cart.' }, { status: 404 });
    }

    let new_cart_count = 0;

    if (action === 'remove_all') {
      // Remove completely
      cart.items.splice(itemIndex, 1);
      new_cart_count = 0;
    } else {
      // Decrement by 1
      cart.items[itemIndex].qty -= 1;
      if (cart.items[itemIndex].qty <= 0) {
        cart.items.splice(itemIndex, 1);
        new_cart_count = 0;
      } else {
        new_cart_count = cart.items[itemIndex].qty;
      }
    }

    await cart.save();

    // Build cart summary
    let total_amount = 0;
    const cartProductList = cart.items.map((item: any) => {
      const qty = item.qty || 1;
      const price = item.price || 0;
      total_amount += price * qty;
      return {
        product_id: item.product_id?.toString(),
        qty_in_cart: qty,
        unit_price: price,
        subtotal: parseFloat((price * qty).toFixed(2)),
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

export const POST = authMiddleware(removeFromCart);
export const DELETE = authMiddleware(removeFromCart);
export const GET = authMiddleware(removeFromCart); // fallback
