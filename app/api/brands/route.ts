import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import mongoose from 'mongoose';

const BrandSchema = new mongoose.Schema({ name: String, logo: String, is_active: String }, { timestamps: true });
const Brand = mongoose.models.Brand || mongoose.model('Brand', BrandSchema);

export async function GET(request: NextRequest) {
  try {
    await connectDB();
    const { searchParams } = new URL(request.url);
    const search = searchParams.get('search') || '';
    const query = search ? { name: { $regex: search, $options: 'i' } } : {};
    const data = await Brand.find(query).sort({ createdAt: -1 }).lean();
    return NextResponse.json({ data, meta: { total: data.length } });
  } catch (e: any) { return NextResponse.json({ error: e.message }, { status: 500 }); }
}

export async function POST(request: NextRequest) {
  try {
    await connectDB();
    const body = await request.json();
    const item = await Brand.create(body);
    return NextResponse.json({ data: item }, { status: 201 });
  } catch (e: any) { return NextResponse.json({ error: e.message }, { status: 500 }); }
}
