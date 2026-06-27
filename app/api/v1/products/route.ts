import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Product from '@/lib/models/Product';

export async function GET(request: NextRequest) {
  try {
    await connectDB();
    const { searchParams } = new URL(request.url);
    const page = parseInt(searchParams.get('page') || '1');
    const limit = parseInt(searchParams.get('limit') || '10');
    const search = searchParams.get('search') || '';
    const categoryId = searchParams.get('category_id');
    const subcategoryId = searchParams.get('subcategory_id');
    
    const query: any = {};
    if (search) {
      query.product_name = { $regex: search, $options: 'i' };
    }
    if (categoryId) {
      query.category = categoryId;
    }
    if (subcategoryId) {
      query.subcategory = subcategoryId;
    }
    
    const [data, total] = await Promise.all([
      Product.find(query).skip((page - 1) * limit).limit(limit).lean(),
      Product.countDocuments(query),
    ]);
    
    return NextResponse.json({
      data,
      meta: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit)
      }
    });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
