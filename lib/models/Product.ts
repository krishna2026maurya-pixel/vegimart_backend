import mongoose, { Schema, model, models } from 'mongoose';

const ProductSchema = new Schema({
  product_name: { type: String, required: true },
  vendor_id: { type: Schema.Types.ObjectId, ref: 'Vendor' },
  vendor_shop_name: String,
  cat_type_id: String,
  category: String,
  subcategory: String,
  low_category: String,
  brand: String,
  product_label: String,
  mrp: Number,
  selling_price: Number,
  gst: Number,
  total_amt: Number,
  quantity: String,
  volume: String,
  stock_status: Number,
  product_description: String,
  images: [String],
  product_image: String,
  product_images: String,
  is_active: String,
  description: String,
  add_info_title: String,
  add_info_desc: String,
}, { timestamps: true });

export default models.Product || model('Product', ProductSchema);
