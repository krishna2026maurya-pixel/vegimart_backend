import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Wishlist from '@/lib/models/Wishlist';
import { authMiddleware } from '@/lib/auth';

async function removeFromWishlist(request: NextRequest, userId: string) {
  try {
    await connectDB();
    const url = new URL(request.url);
    const productId = url.pathname.split('/').slice(-1)[0];
    
    const result = await Wishlist.findOneAndDelete({ user_id: userId, product_id: productId });
    if (!result) {
      return NextResponse.json({ error: 'Product not found in your wishlist.' }, { status: 404 });
    }
    
    return NextResponse.json({ message: 'Removed from wishlist successfully.' });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const DELETE = authMiddleware(removeFromWishlist);
export const GET = authMiddleware(removeFromWishlist); // Allow GET as fallback
export const POST = authMiddleware(removeFromWishlist); // Allow POST as fallback
