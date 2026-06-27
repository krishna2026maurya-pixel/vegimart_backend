import mongoose, { Schema, model, models } from 'mongoose';

const VendorCategorySchema = new Schema({
  category_name: { type: String, required: true },
  description: String,
  category_image: String,
  cat_type_id: Number,
}, { timestamps: true });

export default models.VendorCategory || model('VendorCategory', VendorCategorySchema);
