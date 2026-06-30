import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Order from '@/lib/models/Order';
import { authMiddleware } from '@/lib/auth';
import mongoose from 'mongoose';

async function cancelOrder(request: NextRequest, userId: string, params: any) {
  try {
    await connectDB();
    const { id } = params;

    if (!id || !mongoose.Types.ObjectId.isValid(id)) {
      return NextResponse.json({ success: false, error: 'Invalid order ID format.' }, { status: 400 });
    }
    
    const order = await Order.findOne({ _id: id, user_id: userId });
    if (!order) {
      return NextResponse.json({ success: false, error: 'Order not found.' }, { status: 404 });
    }
    
    if (order.status > 1) {
      return NextResponse.json({ success: false, error: 'Order cannot be cancelled as it is already dispatched or delivered.' }, { status: 400 });
    }
    
    order.status = 4; // Cancelled
    await order.save();
    
    return NextResponse.json({ success: true, message: 'Order cancelled successfully.', data: order });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

export const PATCH = authMiddleware(cancelOrder);
export const POST = authMiddleware(cancelOrder); // Allow POST as fallback
export const GET = authMiddleware(cancelOrder); // Allow GET as fallback
