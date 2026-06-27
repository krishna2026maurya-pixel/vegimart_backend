import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Order from '@/lib/models/Order';
import OrderItem from '@/lib/models/OrderItem';
import { authMiddleware } from '@/lib/auth';

async function getOrderDetail(request: NextRequest, userId: string) {
  try {
    await connectDB();
    const url = new URL(request.url);
    const id = url.pathname.split('/').slice(-1)[0];
    
    const order = await Order.findOne({ _id: id, user_id: userId }).populate('items');
    if (!order) {
      return NextResponse.json({ error: 'Order not found.' }, { status: 404 });
    }
    
    return NextResponse.json({ data: order });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const GET = authMiddleware(getOrderDetail);
export const POST = authMiddleware(getOrderDetail); // Allow POST as fallback
