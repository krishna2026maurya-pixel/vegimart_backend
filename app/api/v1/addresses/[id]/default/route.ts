import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Address from '@/lib/models/Address';
import { authMiddleware } from '@/lib/auth';

async function setDefaultAddress(request: NextRequest, userId: string) {
  try {
    await connectDB();
    // Parse ID from URL
    const url = new URL(request.url);
    const paths = url.pathname.split('/');
    const id = paths[paths.length - 2]; // e.g. /api/v1/addresses/[id]/default -> id is second to last
    
    const address = await Address.findOne({ _id: id, user_id: userId });
    if (!address) {
      return NextResponse.json({ error: 'Address not found or unauthorized.' }, { status: 404 });
    }
    
    // Set all user addresses default to false, then current to true
    await Address.updateMany({ user_id: userId }, { $set: { is_default: false } });
    address.is_default = true;
    await address.save();
    
    return NextResponse.json({ message: 'Default address updated successfully.', data: address });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const PATCH = authMiddleware(setDefaultAddress);
export const GET = authMiddleware(setDefaultAddress); // Allow GET as fallback
