import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Cart from '@/lib/models/Cart';
import { authMiddleware } from '@/lib/auth';

async function removeCartItem(request: NextRequest, userId: string) {
  try {
    await connectDB();
    const url = new URL(request.url);
    const productId = url.pathname.split('/').slice(-1)[0];
    
    let cart = await Cart.findOne({ user_id: userId });
    if (!cart) {
      return NextResponse.json({ error: 'Cart not found.' }, { status: 404 });
    }
    
    cart.items = cart.items.filter((item: any) => item.product_id.toString() !== productId);
    await cart.save();
    
    return NextResponse.json({ message: 'Product removed from cart successfully.', data: cart });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const DELETE = authMiddleware(removeCartItem);
export const GET = authMiddleware(removeCartItem); // Allow GET as fallback for testing
