import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Subcategory from '@/lib/models/Subcategory';

export async function GET(request: NextRequest) {
  try {
    await connectDB();
    const url = new URL(request.url);
    const paths = url.pathname.split('/');
    const categoryId = paths[paths.length - 2]; // e.g., /api/v1/categories/[id]/subcategories -> [id] is second to last
    
    const subcategories = await Subcategory.find({ cat_id: categoryId, is_active: '1' });
    return NextResponse.json({ data: subcategories });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
