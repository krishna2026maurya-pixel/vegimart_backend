import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import User from '@/lib/models/User';
import { hashPassword, signToken } from '@/lib/auth';

export async function POST(request: NextRequest) {
  try {
    await connectDB();
    const body = await request.json();
    const { name, mobile_no, password, email } = body;
    
    if (!mobile_no || !password) {
      return NextResponse.json({ error: 'Mobile number and password are required.' }, { status: 400 });
    }
    
    // Check if user already exists
    const existingUser = await User.findOne({ mobile_no });
    if (existingUser) {
      return NextResponse.json({ error: 'User with this mobile number already exists.' }, { status: 400 });
    }
    
    const hashedPassword = hashPassword(password);
    const user = await User.create({
      name: name || '',
      mobile_no,
      password: hashedPassword,
      email: email || '',
      is_active: '1',
      wallet_balance: 0
    });
    
    const token = signToken({ id: user._id, mobile_no: user.mobile_no });
    
    return NextResponse.json({
      message: 'Registration successful.',
      token,
      user: {
        id: user._id,
        name: user.name,
        mobile_no: user.mobile_no,
        email: user.email,
        wallet_balance: user.wallet_balance
      }
    }, { status: 201 });
  } catch (e: any) {
    return NextResponse.json({ error: e.message }, { status: 500 });
  }
}
