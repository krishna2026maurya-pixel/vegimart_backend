import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Cart from '@/lib/models/Cart';
import User from '@/lib/models/User';

export async function GET(request: NextRequest) {
  try {
    await connectDB();
    const { searchParams } = new URL(request.url);
    const page = parseInt(searchParams.get('page') || '1');
    const limit = parseInt(searchParams.get('limit') || '10');
    const search = searchParams.get('search') || '';

    // Fetch all non-empty carts
    // In a real scenario, you'd filter by updatedAt < 24 hours ago, etc.
    const query = { 'items.0': { $exists: true } };

    let data = await Cart.find(query)
      .populate('user_id', 'name mobile_no')
      .sort({ updatedAt: -1 })
      .lean();

    // Map to a cleaner format
    let result = data.map((cart: any) => ({
      _id: cart._id,
      user_name: cart.user_id?.name || 'Unknown User',
      user_mobile: cart.user_id?.mobile_no || 'N/A',
      items_count: cart.items.length,
      total_value: cart.items.reduce((acc: number, item: any) => acc + (item.price * item.qty), 0),
      updated_at: cart.updatedAt,
    }));

    // Apply search filter manually (since user_id fields are joined)
    if (search) {
      const s = search.toLowerCase();
      result = result.filter(item =>
        item.user_name.toLowerCase().includes(s) ||
        item.user_mobile.includes(s)
      );
    }

    const total = result.length;
    const paginatedData = result.slice((page - 1) * limit, page * limit);

    return NextResponse.json({
      success: true,
      data: paginatedData,
      meta: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit)
      }
    });
  } catch (e: any) {
    console.error('Abandoned Carts API Error:', e);
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}
