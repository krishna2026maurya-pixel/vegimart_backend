import mongoose, { Schema, model, models } from 'mongoose';

const SubcategorySchema = new Schema({
  category_name: { type: String, required: true },
  cat_id: { type: String },
  description: String,
  image: String,
  is_active: { type: String, default: '1' },
}, { timestamps: true });

export default models.Subcategory || model('Subcategory', SubcategorySchema);
