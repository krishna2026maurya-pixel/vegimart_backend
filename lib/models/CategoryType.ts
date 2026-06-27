import mongoose, { Schema, model, models } from 'mongoose';

const CategoryTypeSchema = new Schema({
  name: { type: String, required: true },
  image: String,
  slug: String,
  is_active: { type: String, default: '1' },
  sort_order: Number,
}, { timestamps: true });

export default models.CategoryType || model('CategoryType', CategoryTypeSchema);
