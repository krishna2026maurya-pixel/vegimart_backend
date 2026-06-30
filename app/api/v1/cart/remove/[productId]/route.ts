import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Cart from '@/lib/models/Cart';
import { authMiddleware } from '@/lib/auth';
import mongoose from 'mongoose';

async function removeCartItem(request: NextRequest, userId: string, params: any) {
  try {
    await connectDB();
    const productId = params?.productId;

    if (!productId || !mongoose.Types.ObjectId.isValid(productId)) {
      return NextResponse.json({
        success: false,
        error: 'Invalid product ID format.'
      }, { status: 400 });
    }
    
    let cart = await Cart.findOne({ user_id: userId });
    if (!cart) {
      return NextResponse.json({ success: false, error: 'Cart not found.' }, { status: 404 });
    }
    
    cart.items = cart.items.filter((item: any) => item.product_id.toString() !== productId);
    await cart.save();
    
    return NextResponse.json({
      success: true,
      message: 'Product removed from cart successfully.',
      data: cart
    });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

export const DELETE = authMiddleware(removeCartItem);
export const GET = authMiddleware(removeCartItem); // Allow GET as fallback for testing
