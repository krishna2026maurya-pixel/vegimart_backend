import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Cart from '@/lib/models/Cart';
import Product from '@/lib/models/Product';
import { authMiddleware } from '@/lib/auth';

async function getCart(request: NextRequest, userId: string) {
  try {
    await connectDB();
    
    // Find cart and populate product details
    let cart = await Cart.findOne({ user_id: userId }).populate('items.product_id');
    
    if (!cart) {
      cart = await Cart.create({ user_id: userId, items: [] });
    }
    
    return NextResponse.json({ data: cart });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const GET = authMiddleware(getCart);
export const POST = authMiddleware(getCart); // Allow POST as fallback
