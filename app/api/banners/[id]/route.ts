import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Banner from '@/lib/models/Banner';

export async function DELETE(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    await connectDB();
    const { id } = await params;

    await Banner.findByIdAndDelete(id);

    return NextResponse.json({ success: true, message: 'Banner deleted successfully' });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    await connectDB();
    const { id } = await params;

    const banner = await Banner.findById(id).lean();
    if (!banner) return NextResponse.json({ success: false, error: 'Banner not found' }, { status: 404 });

    return NextResponse.json({ success: true, data: banner });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

export async function PATCH(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    await connectDB();
    const { id } = await params;
    const body = await request.json();

    const banner = await Banner.findByIdAndUpdate(id, body, { new: true });

    return NextResponse.json({ success: true, message: 'Banner updated successfully', data: banner });
  } catch (e: any) {
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}
