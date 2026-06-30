import { NextRequest, NextResponse } from 'next/server';
import { v2 as cloudinary } from 'cloudinary';

export async function POST(request: NextRequest) {
  try {
    // Try to get keys from all possible variants (sometimes Vercel prefixes them)
    const cloudName = process.env.CLOUDINARY_CLOUD_NAME || process.env.NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME;
    const apiKey = process.env.CLOUDINARY_API_KEY || process.env.NEXT_PUBLIC_CLOUDINARY_API_KEY;
    const apiSecret = process.env.CLOUDINARY_API_SECRET || process.env.NEXT_PUBLIC_CLOUDINARY_API_SECRET;

    // Detailed debug check
    const missing = [];
    if (!cloudName) missing.push('CLOUD_NAME');
    if (!apiKey) missing.push('API_KEY');
    if (!apiSecret) missing.push('API_SECRET');

    if (missing.length > 0) {
      return NextResponse.json({
        success: false,
        error: `Cloudinary config incomplete. Missing: ${missing.join(', ')}. Please check Vercel Dashboard for typos or spaces in Key names.`
      }, { status: 500 });
    }

    // Configure Cloudinary
    cloudinary.config({
      cloud_name: cloudName.trim(),
      api_key: apiKey.trim(),
      api_secret: apiSecret.trim(),
    });

    const formData = await request.formData();
    const files = formData.getAll('file') as File[];
    
    if (!files || files.length === 0) {
      return NextResponse.json({ success: false, error: 'No files uploaded' }, { status: 400 });
    }

    const uploadedFiles = [];

    for (const file of files) {
      const allowedTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
      if (!allowedTypes.includes(file.type)) continue;

      const bytes = await file.arrayBuffer();
      const buffer = Buffer.from(bytes);

      const uploadResult = await new Promise((resolve, reject) => {
        cloudinary.uploader.upload_stream(
          { folder: 'vegimart_products' },
          (error, result) => {
            if (error) reject(error);
            else resolve(result);
          }
        ).end(buffer);
      }) as any;

      uploadedFiles.push({
        url: uploadResult.secure_url,
        filename: uploadResult.public_id,
        originalName: file.name
      });
    }

    return NextResponse.json({
      success: true,
      data: uploadedFiles.length === 1 ? uploadedFiles[0] : uploadedFiles,
      urls: uploadedFiles.map(f => f.url)
    });
  } catch (error: any) {
    return NextResponse.json({ success: false, error: error.message }, { status: 500 });
  }
}
