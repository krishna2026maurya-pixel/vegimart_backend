import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Wishlist from '@/lib/models/Wishlist';
import { authMiddleware } from '@/lib/auth';
import mongoose from 'mongoose';

async function removeFromWishlist(request: NextRequest, userId: string, params: any) {
  try {
    await connectDB();
    const productId = params?.productId;

    if (!productId || !mongoose.Types.ObjectId.isValid(productId)) {
      return NextResponse.json({ success: false, error: 'Invalid product ID format.' }, { status: 400 });
    }
    
    const result = await Wishlist.findOneAndDelete({ user_id: userId, product_id: productId });
    if (!result) {
      return NextResponse.json({ success: false, error: 'Product not found in your wishlist.' }, { status: 404 });
    }
    
    return NextResponse.json({ success: true, message: 'Removed from wishlist successfully.' });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

export const DELETE = authMiddleware(removeFromWishlist);
export const GET = authMiddleware(removeFromWishlist); // Allow GET as fallback
export const POST = authMiddleware(removeFromWishlist); // Allow POST as fallback
