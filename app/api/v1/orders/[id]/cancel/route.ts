import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Order from '@/lib/models/Order';
import { authMiddleware } from '@/lib/auth';

async function cancelOrder(request: NextRequest, userId: string) {
  try {
    await connectDB();
    const url = new URL(request.url);
    const paths = url.pathname.split('/');
    const id = paths[paths.length - 2]; // e.g. /api/v1/orders/[id]/cancel -> id is second to last
    
    const order = await Order.findOne({ _id: id, user_id: userId });
    if (!order) {
      return NextResponse.json({ error: 'Order not found.' }, { status: 404 });
    }
    
    if (order.status > 1) {
      return NextResponse.json({ error: 'Order cannot be cancelled as it is already dispatched or delivered.' }, { status: 400 });
    }
    
    order.status = 4; // Cancelled
    await order.save();
    
    return NextResponse.json({ message: 'Order cancelled successfully.', data: order });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const PATCH = authMiddleware(cancelOrder);
export const POST = authMiddleware(cancelOrder); // Allow POST as fallback
export const GET = authMiddleware(cancelOrder); // Allow GET as fallback
