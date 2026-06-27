import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Cart from '@/lib/models/Cart';
import { authMiddleware } from '@/lib/auth';

async function clearCart(request: NextRequest, userId: string) {
  try {
    await connectDB();
    
    let cart = await Cart.findOne({ user_id: userId });
    if (cart) {
      cart.items = [];
      await cart.save();
    }
    
    return NextResponse.json({ message: 'Cart cleared successfully.', data: cart });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const DELETE = authMiddleware(clearCart);
export const POST = authMiddleware(clearCart); // Allow POST as fallback
export const GET = authMiddleware(clearCart); // Allow GET as fallback
