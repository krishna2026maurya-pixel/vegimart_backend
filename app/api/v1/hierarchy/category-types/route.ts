import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import CategoryType from '@/lib/models/CategoryType';
import Category from '@/lib/models/Category';

export async function GET(request: NextRequest) {
  try {
    await connectDB();

    // 1. Get all active category types
    const categoryTypes = await CategoryType.find({ is_active: '1' })
      .sort({ sort_order: 1 })
      .lean();

    // 2. Get all active categories
    const categories = await Category.find({ is_active: '1' })
      .sort({ sort_order: 1 })
      .lean();

    // 3. Group categories by category type
    const result = categoryTypes.map((type: any) => ({
      ...type,
      categories: categories.filter((cat: any) => cat.cat_type_id === type._id.toString())
    }));

    return NextResponse.json({
      success: true,
      data: result
    });
  } catch (e: any) {
    console.error('Hierarchy CategoryTypes Error:', e);
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}
