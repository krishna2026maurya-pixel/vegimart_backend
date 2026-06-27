import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Address from '@/lib/models/Address';
import { authMiddleware } from '@/lib/auth';

async function updateAddress(request: NextRequest, userId: string) {
  try {
    await connectDB();
    const url = new URL(request.url);
    const id = url.pathname.split('/').slice(-1)[0]; // simple parsing for [id]
    const body = await request.json();
    
    // Find address and make sure it belongs to current user
    const address = await Address.findOne({ _id: id, user_id: userId });
    if (!address) {
      return NextResponse.json({ error: 'Address not found or unauthorized.' }, { status: 404 });
    }
    
    if (body.is_default === true || body.is_default === '1') {
      await Address.updateMany({ user_id: userId }, { $set: { is_default: false } });
    }
    
    const updatedAddress = await Address.findByIdAndUpdate(
      id,
      { $set: body },
      { new: true }
    );
    
    return NextResponse.json({ message: 'Address updated successfully.', data: updatedAddress });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

async function deleteAddress(request: NextRequest, userId: string) {
  try {
    await connectDB();
    const url = new URL(request.url);
    const id = url.pathname.split('/').slice(-1)[0];
    
    const address = await Address.findOneAndDelete({ _id: id, user_id: userId });
    if (!address) {
      return NextResponse.json({ error: 'Address not found or unauthorized.' }, { status: 404 });
    }
    
    return NextResponse.json({ message: 'Address deleted successfully.' });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const PATCH = authMiddleware(updateAddress);
export const DELETE = authMiddleware(deleteAddress);
