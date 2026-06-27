import mongoose, { Schema, model, models } from 'mongoose';

const CouponSchema = new Schema({
  code: { type: String, required: true, unique: true },
  discount_type: { type: String, enum: ['percent', 'flat'], default: 'percent' },
  discount_value: { type: Number, required: true },
  min_order: { type: Number, default: 0 },
  max_uses: Number,
  used_count: { type: Number, default: 0 },
  is_active: { type: String, default: '1' },
  expires_at: String
}, { timestamps: true });

export default models.Coupon || model('Coupon', CouponSchema);
