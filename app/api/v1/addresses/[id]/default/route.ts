import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Address from '@/lib/models/Address';
import { authMiddleware } from '@/lib/auth';
import mongoose from 'mongoose';

async function setDefaultAddress(request: NextRequest, userId: string, params: any) {
  try {
    await connectDB();
    const { id } = params;

    if (!id || !mongoose.Types.ObjectId.isValid(id)) {
      return NextResponse.json({ success: false, error: 'Invalid address ID format.' }, { status: 400 });
    }
    
    const address = await Address.findOne({ _id: id, user_id: userId });
    if (!address) {
      return NextResponse.json({ success: false, error: 'Address not found or unauthorized.' }, { status: 404 });
    }
    
    // Set all user addresses default to false, then current to true
    await Address.updateMany({ user_id: userId }, { $set: { is_default: false } });
    address.is_default = true;
    await address.save();
    
    return NextResponse.json({ success: true, message: 'Default address updated successfully.', data: address });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

export const PATCH = authMiddleware(setDefaultAddress);
export const GET = authMiddleware(setDefaultAddress); // Allow GET as fallback
