import mongoose, { Schema, model, models } from 'mongoose';

const BannerSchema = new Schema({
  title: String,
  image: String,
  link: String,
  is_active: { type: String, default: '1' },
  sort_order: Number,
}, { timestamps: true });

export default models.Banner || model('Banner', BannerSchema);
