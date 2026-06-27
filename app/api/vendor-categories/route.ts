import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import VendorCategory from '@/lib/models/VendorCategory';

export async function GET(request: NextRequest) {
  try {
    await connectDB();
    const { searchParams } = new URL(request.url);
    const page = parseInt(searchParams.get('page') || '1');
    const limit = parseInt(searchParams.get('limit') || '20');
    const search = searchParams.get('search') || '';
    const query = search ? { category_name: { $regex: search, $options: 'i' } } : {};
    const [data, total] = await Promise.all([
      VendorCategory.find(query).sort({ createdAt: -1 }).skip((page-1)*limit).limit(limit).lean(),
      VendorCategory.countDocuments(query),
    ]);
    return NextResponse.json({ data, meta: { total, page, limit, totalPages: Math.ceil(total/limit) } });
  } catch (e: any) { return NextResponse.json({ error: e.message }, { status: 500 }); }
}

export async function POST(request: NextRequest) {
  try {
    await connectDB();
    const body = await request.json();
    const item = await VendorCategory.create(body);
    return NextResponse.json({ data: item }, { status: 201 });
  } catch (e: any) { return NextResponse.json({ error: e.message }, { status: 500 }); }
}
