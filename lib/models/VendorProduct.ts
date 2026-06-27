import mongoose, { Schema, model, models } from 'mongoose';

const VendorProductSchema = new Schema({
  vendor_id: { type: Schema.Types.ObjectId, ref: 'Vendor' },
  product_name: { type: String, required: true },
  cat_type_id: Number,
  category: String,
  subcategory: String,
  low_category: String,
  brand: String,
  product_label: String,
  quantity: String,
  volume: String,
  mrp: Number,
  selling_price: Number,
  gst: Number,
  total_amt: Number,
  product_description: String,
  product_images: String,
  add_info_title: String,
  add_info_desc: String,
  stock_status: String,
  description: String,
}, { timestamps: true });

export default models.VendorProduct || model('VendorProduct', VendorProductSchema);
