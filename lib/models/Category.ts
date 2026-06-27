import mongoose, { Schema, model, models } from 'mongoose';

const CategorySchema = new Schema({
  name: { type: String, required: true },
  image: String,
  cat_type_id: String,
  is_active: { type: String, default: '1' },
  sort_order: Number,
}, { timestamps: true });

export default models.Category || model('Category', CategorySchema);
