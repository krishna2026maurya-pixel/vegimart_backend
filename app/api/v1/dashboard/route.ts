import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Order from '@/lib/models/Order';
import Address from '@/lib/models/Address';
import User from '@/lib/models/User';
import { authMiddleware } from '@/lib/auth';

async function getUserDashboard(request: NextRequest, userId: string) {
  try {
    await connectDB();
    
    // Fetch profile, total orders count, recent orders, address count
    const [user, ordersCount, recentOrders, addressCount] = await Promise.all([
      User.findById(userId).select('wallet_balance name email mobile_no'),
      Order.countDocuments({ user_id: userId }),
      Order.find({ user_id: userId }).sort({ createdAt: -1 }).limit(5).populate('items').lean(),
      Address.countDocuments({ user_id: userId })
    ]);
    
    if (!user) {
      return NextResponse.json({ error: 'User not found.' }, { status: 404 });
    }
    
    return NextResponse.json({
      data: {
        user: {
          name: user.name,
          email: user.email,
          mobile_no: user.mobile_no,
          wallet_balance: user.wallet_balance || 0
        },
        stats: {
          total_orders: ordersCount,
          total_addresses: addressCount
        },
        recent_orders: recentOrders
      }
    });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const GET = authMiddleware(getUserDashboard);
export const POST = authMiddleware(getUserDashboard); // Allow POST as fallback
export const PATCH = authMiddleware(getUserDashboard); // Allow PATCH as fallback
