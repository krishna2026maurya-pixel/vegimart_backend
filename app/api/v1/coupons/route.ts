import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Coupon from '@/lib/models/Coupon';

export async function GET(request: NextRequest) {
  try {
    await connectDB();
    
    // Fetch active coupons
    const coupons = await Coupon.find({ is_active: '1' }).sort({ createdAt: -1 }).lean();
    return NextResponse.json({ data: coupons });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
