import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import User from '@/lib/models/User';
import { signToken } from '@/lib/auth';

export async function POST(request: NextRequest) {
  try {
    await connectDB();
    const body = await request.json();
    const { mobile_no, otp, name } = body;
    
    if (!mobile_no || !otp) {
      return NextResponse.json({ error: 'Mobile number and OTP are required.' }, { status: 400 });
    }
    
    // Demo validation: accept '1234'
    // In production, verify OTP from database/cache
    if (otp !== '1234') {
      return NextResponse.json({ error: 'Invalid OTP. Please try again.' }, { status: 400 });
    }
    
    // Check if user exists
    let user = await User.findOne({ mobile_no });
    let isNewUser = false;
    
    if (!user) {
      // NEW USER → Auto Register
      isNewUser = true;
      user = await User.create({
        mobile_no,
        name: name || '',
        email: '',
        is_active: '1',
        wallet_balance: 0
      });
    }
    
    // Check if user is active
    if (user.is_active === '0') {
      return NextResponse.json({ error: 'Your account is suspended. Please contact support.' }, { status: 403 });
    }
    
    // Generate JWT token
    const token = signToken({ id: user._id, mobile_no: user.mobile_no });
    
    return NextResponse.json({
      message: isNewUser ? 'Registration successful. Welcome to VegiMart!' : 'Login successful. Welcome back!',
      is_new_user: isNewUser,
      token,
      user: {
        id: user._id,
        name: user.name,
        mobile_no: user.mobile_no,
        email: user.email,
        profile_image: user.profile_image || '',
        wallet_balance: user.wallet_balance || 0
      }
    });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
