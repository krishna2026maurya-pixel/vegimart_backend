import { NextRequest, NextResponse } from 'next/server';
import { writeFile, mkdir } from 'fs/promises';
import path from 'path';

export async function POST(request: NextRequest) {
  try {
    const formData = await request.formData();
    const files = formData.getAll('file') as File[];
    
    if (!files || files.length === 0) {
      return NextResponse.json({ success: false, error: 'No files uploaded' }, { status: 400 });
    }

    const uploadDir = path.join(process.cwd(), 'public', 'uploads');
    await mkdir(uploadDir, { recursive: true });

    const uploadedFiles = [];

    for (const file of files) {
      const allowedTypes = ['image/jpeg', 'image/png', 'image/webp', 'image/gif'];
      if (!allowedTypes.includes(file.type)) {
        continue; // Skip non-image files
      }

      const bytes = await file.arrayBuffer();
      const buffer = Buffer.from(bytes);

      const ext = file.name.split('.').pop();
      const filename = `${Date.now()}-${Math.random().toString(36).slice(2)}.${ext}`;

      await writeFile(path.join(uploadDir, filename), buffer);
      uploadedFiles.push({
        url: `/uploads/${filename}`,
        filename: filename,
        originalName: file.name
      });
    }

    if (uploadedFiles.length === 0) {
      return NextResponse.json({ success: false, error: 'No valid images were uploaded' }, { status: 400 });
    }

    // If only one file was uploaded, return it directly for backward compatibility
    // otherwise return the array of uploaded files
    return NextResponse.json({
      success: true,
      data: uploadedFiles.length === 1 ? uploadedFiles[0] : uploadedFiles,
      urls: uploadedFiles.map(f => f.url) // Convenient for the frontend
    });
  } catch (error: any) {
    return NextResponse.json({ success: false, error: error.message }, { status: 500 });
  }
}
