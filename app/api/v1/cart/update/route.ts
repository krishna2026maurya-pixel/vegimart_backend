import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Cart from '@/lib/models/Cart';
import { authMiddleware } from '@/lib/auth';

async function updateCartQty(request: NextRequest, userId: string) {
  try {
    await connectDB();
    const body = await request.json();
    const { product_id, qty } = body;
    
    if (!product_id || qty === undefined) {
      return NextResponse.json({ error: 'Product ID and quantity are required.' }, { status: 400 });
    }
    
    let cart = await Cart.findOne({ user_id: userId });
    if (!cart) {
      return NextResponse.json({ error: 'Cart not found.' }, { status: 404 });
    }
    
    const itemIndex = cart.items.findIndex((item: any) => item.product_id.toString() === product_id);
    if (itemIndex > -1) {
      if (Number(qty) <= 0) {
        cart.items.splice(itemIndex, 1);
      } else {
        cart.items[itemIndex].qty = Number(qty);
      }
      await cart.save();
      return NextResponse.json({ message: 'Cart updated successfully.', data: cart });
    } else {
      return NextResponse.json({ error: 'Item not found in cart.' }, { status: 404 });
    }
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const PATCH = authMiddleware(updateCartQty);
export const POST = authMiddleware(updateCartQty); // Allow POST as fallback
