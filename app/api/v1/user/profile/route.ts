import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import User from '@/lib/models/User';
import { authMiddleware } from '@/lib/auth';

async function getProfile(request: NextRequest, userId: string) {
  try {
    await connectDB();
    const user = await User.findById(userId).select('-password');
    if (!user) {
      return NextResponse.json({ error: 'User not found.' }, { status: 404 });
    }
    return NextResponse.json({ data: user });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

async function updateProfile(request: NextRequest, userId: string) {
  try {
    await connectDB();
    const body = await request.json();
    const { name, email, profile_image } = body;
    
    const user = await User.findByIdAndUpdate(
      userId,
      { $set: { name, email, profile_image } },
      { new: true }
    ).select('-password');
    
    if (!user) {
      return NextResponse.json({ error: 'User not found.' }, { status: 404 });
    }
    
    return NextResponse.json({ message: 'Profile updated.', data: user });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}

export const GET = authMiddleware(getProfile);
export const PATCH = authMiddleware(updateProfile);
