import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Cart from '@/lib/models/Cart';
import Product from '@/lib/models/Product';
import { authMiddleware } from '@/lib/auth';

async function addToCart(request: NextRequest, userId: string) {
  try {
    await connectDB();
    const body = await request.json();
    const { product_id, qty } = body;
    
    if (!product_id || !qty) {
      return NextResponse.json({ error: 'Product ID and quantity are required.' }, { status: 400 });
    }
    
    const product = await Product.findById(product_id);
    if (!product) {
      return NextResponse.json({ error: 'Product not found.' }, { status: 404 });
    }
    
    const price = product.selling_price || product.mrp || 0;
    
    let cart = await Cart.findOne({ user_id: userId });
    if (!cart) {
      cart = new Cart({ user_id: userId, items: [] });
    }
    
    // Check if item already exists in cart
    const existingIndex = cart.items.findIndex((item: any) => item.product_id.toString() === product_id);
    if (existingIndex > -1) {
      cart.items[existingIndex].qty += Number(qty);
      cart.items[existingIndex].price = price; // update to latest price
    } else {
      cart.items.push({ product_id, qty: Number(qty), price });
    }
    
    await cart.save();
    return NextResponse.json({ message: 'Product added to cart successfully.', data: cart });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const POST = authMiddleware(addToCart);
