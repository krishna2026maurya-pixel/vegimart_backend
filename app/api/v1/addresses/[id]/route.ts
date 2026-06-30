import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Address from '@/lib/models/Address';
import { authMiddleware } from '@/lib/auth';
import mongoose from 'mongoose';

async function updateAddress(request: NextRequest, userId: string, params: any) {
  try {
    await connectDB();
    const { id } = params;

    if (!id || !mongoose.Types.ObjectId.isValid(id)) {
      return NextResponse.json({ success: false, error: 'Invalid address ID format.' }, { status: 400 });
    }

    const body = await request.json();
    
    // Find address and make sure it belongs to current user
    const address = await Address.findOne({ _id: id, user_id: userId });
    if (!address) {
      return NextResponse.json({ success: false, error: 'Address not found or unauthorized.' }, { status: 404 });
    }
    
    if (body.is_default === true || body.is_default === '1') {
      await Address.updateMany({ user_id: userId }, { $set: { is_default: false } });
    }
    
    const updatedAddress = await Address.findByIdAndUpdate(
      id,
      { $set: body },
      { new: true }
    );
    
    return NextResponse.json({ success: true, message: 'Address updated successfully.', data: updatedAddress });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

async function deleteAddress(request: NextRequest, userId: string, params: any) {
  try {
    await connectDB();
    const { id } = params;

    if (!id || !mongoose.Types.ObjectId.isValid(id)) {
      return NextResponse.json({ success: false, error: 'Invalid address ID format.' }, { status: 400 });
    }
    
    const address = await Address.findOneAndDelete({ _id: id, user_id: userId });
    if (!address) {
      return NextResponse.json({ success: false, error: 'Address not found or unauthorized.' }, { status: 404 });
    }
    
    return NextResponse.json({ success: true, message: 'Address deleted successfully.' });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

export const PATCH = authMiddleware(updateAddress);
export const DELETE = authMiddleware(deleteAddress);
