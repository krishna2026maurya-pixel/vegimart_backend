import { NextRequest, NextResponse } from 'next/server';
import { v2 as cloudinary } from 'cloudinary';

export async function POST(request: NextRequest) {
  try {
    const cloudName = process.env.CLOUDINARY_CLOUD_NAME;
    const apiKey = process.env.CLOUDINARY_API_KEY;
    const apiSecret = process.env.CLOUDINARY_API_SECRET;

    // Detailed debug check (safe for production)
    const missing = [];
    if (!cloudName) missing.push('CLOUD_NAME');
    if (!apiKey) missing.push('API_KEY');
    if (!apiSecret) missing.push('API_SECRET');

    if (missing.length > 0) {
      console.error('Cloudinary Env Missing:', missing.join(', '));
      return NextResponse.json({
        success: false,
        error: `Cloudinary config incomplete. Missing: ${missing.join(', ')}. Please check Vercel Env Variables.`
      }, { status: 500 });
    }

    // Configure Cloudinary
    cloudinary.config({
      cloud_name: cloudName,
      api_key: apiKey,
      api_secret: apiSecret,
    });

    const formData = await request.formData();
    const files = formData.getAll('file') as File[];
    
    if (!files || files.length === 0) {
      return NextResponse.json({ success: false, error: 'No files uploaded' }, { status: 400 });
    }

    const uploadedFiles = [];

    for (const file of files) {
      const allowedTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
      if (!allowedTypes.includes(file.type)) {
        continue;
      }

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
    console.error('Upload Error:', error);
    return NextResponse.json({ success: false, error: error.message }, { status: 500 });
  }
}
