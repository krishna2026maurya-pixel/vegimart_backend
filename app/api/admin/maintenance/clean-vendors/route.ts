import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import Vendor from '@/lib/models/Vendor';
import Product from '@/lib/models/Product';

/**
 * GET /api/admin/maintenance/clean-vendors
 *
 * Logic:
 * 1. Creates/Updates two primary vendors.
 * 2. Reassigns all products to these two vendors.
 * 3. Deletes all other vendors.
 */
export async function GET(request: NextRequest) {
  try {
    await connectDB();

    // 1. Define the two vendors to keep
    const vendorConfigs = [
      {
        shop_name: 'Fresh Farm Mart',
        full_name: 'Official Admin',
        email: 'admin@freshfarm.com',
        mobile_number: '9999999991',
        city: 'Mumbai',
        is_verified: '1',
      },
      {
        shop_name: 'Green Grocers',
        full_name: 'Green Admin',
        email: 'admin@greengrocers.com',
        mobile_number: '9999999992',
        city: 'Delhi',
        is_verified: '1',
      }
    ];

    const mainVendors = [];

    for (const config of vendorConfigs) {
      let vendor = await Vendor.findOne({ shop_name: config.shop_name });
      if (!vendor) {
        vendor = await Vendor.create(config);
      }
      mainVendors.push(vendor);
    }

    const mainVendorIds = mainVendors.map(v => v._id);

    // 2. Fetch all products
    const products = await Product.find({});

    // 3. Reassign products to these two (balanced distribution)
    let updatedCount = 0;
    for (let i = 0; i < products.length; i++) {
      const targetVendor = mainVendors[i % 2];
      await Product.findByIdAndUpdate(products[i]._id, {
        vendor_id: targetVendor._id,
        vendor_shop_name: targetVendor.shop_name
      });
      updatedCount++;
    }

    // 4. Delete all OTHER vendors
    const deleteResult = await Vendor.deleteMany({
      _id: { $nin: mainVendorIds }
    });

    return NextResponse.json({
      success: true,
      message: 'Cleanup completed successfully.',
      details: {
        vendors_kept: mainVendors.map(v => v.shop_name),
        products_reassigned: updatedCount,
        other_vendors_deleted: deleteResult.deletedCount
      }
    });
  } catch (error: any) {
    return NextResponse.json({ success: false, error: error.message }, { status: 500 });
  }
}
