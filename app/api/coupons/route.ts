import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Coupon from '@/lib/models/Coupon';

export async function GET(request: NextRequest) {
  try {
    await connectDB();
    const data = await Coupon.find().sort({ createdAt: -1 }).lean();
    return NextResponse.json({ data, meta: { total: data.length } });
  } catch (e: any) { return NextResponse.json({ error: e.message }, { status: 500 }); }
}

export async function POST(request: NextRequest) {
  try {
    await connectDB();
    const body = await request.json();
    const item = await Coupon.create(body);
    return NextResponse.json({ data: item }, { status: 201 });
  } catch (e: any) { return NextResponse.json({ error: e.message }, { status: 500 }); }
}
