import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Category from '@/lib/models/Category';
import Subcategory from '@/lib/models/Subcategory';
import Product from '@/lib/models/Product';
import mongoose from 'mongoose';

async function getExploreData(categoryId?: string | null, subcategoryId?: string | null) {
  await connectDB();

  let subcategoryQuery: any = { is_active: '1' };
  let productQuery: any = { is_active: '1' };

  // 1. Handle Category Filtering
  if (categoryId && mongoose.Types.ObjectId.isValid(categoryId)) {
    subcategoryQuery.cat_id = categoryId;
    productQuery.category = categoryId;
  }

  // 2. Handle Subcategory Filtering
  if (subcategoryId && mongoose.Types.ObjectId.isValid(subcategoryId)) {
    productQuery.subcategory = subcategoryId;
  }

  // 3. Fetch Data
  const [subcategories, products] = await Promise.all([
    Subcategory.find(subcategoryQuery).sort({ createdAt: -1 }).lean(),
    Product.find(productQuery).sort({ createdAt: -1 }).lean()
  ]);

  // 4. Fetch Category Details if categoryId was provided
  let category = null;
  if (categoryId && mongoose.Types.ObjectId.isValid(categoryId)) {
    category = await Category.findById(categoryId).lean();
  }

  return {
    category,
    subcategories,
    products
  };
}

// Support GET for browser testing / simple links
export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);
    const categoryId = searchParams.get('category_id');
    const subcategoryId = searchParams.get('subcategory_id');

    const data = await getExploreData(categoryId, subcategoryId);
    return NextResponse.json({ success: true, data });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

// Support POST to receive IDs in the body as requested
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { category_id, subcategory_id } = body;

    const data = await getExploreData(category_id, subcategory_id);
    return NextResponse.json({ success: true, data });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}
