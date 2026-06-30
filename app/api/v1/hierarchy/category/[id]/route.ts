import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Category from '@/lib/models/Category';
import Subcategory from '@/lib/models/Subcategory';
import Product from '@/lib/models/Product';
import mongoose from 'mongoose';

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    await connectDB();
    const { id } = await params;
    const { searchParams } = new URL(request.url);
    const subcategoryId = searchParams.get('subcategory_id');

    if (!id) {
      return NextResponse.json({ success: false, error: 'Category ID is required' }, { status: 400 });
    }

    // 1. Get Category Details
    const category = await Category.findById(id).lean();
    if (!category) {
      return NextResponse.json({ success: false, error: 'Category not found' }, { status: 404 });
    }

    // 2. Get Subcategories for this category
    // Note: The Subcategory model uses 'cat_id' to reference Category
    const subcategories = await Subcategory.find({
      cat_id: id,
      is_active: '1'
    }).lean();

    // 3. Get Products for this category
    // Note: Product model uses 'category' string/id
    const productQuery: any = {
      category: id,
      is_active: '1'
    };

    // If subcategoryId is provided, filter by it
    if (subcategoryId && mongoose.Types.ObjectId.isValid(subcategoryId)) {
      productQuery.subcategory = subcategoryId;
    }

    const products = await Product.find(productQuery)
      .sort({ createdAt: -1 })
      .lean();

    return NextResponse.json({
      success: true,
      data: {
        category,
        subcategories,
        products
      }
    });
  } catch (e: any) {
    console.error('Hierarchy Category Detail Error:', e);
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}
