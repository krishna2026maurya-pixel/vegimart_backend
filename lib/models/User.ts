import mongoose, { Schema, model, models } from 'mongoose';

const UserSchema = new Schema({
  name: String,
  email: String,
  mobile_no: { type: String, required: true },
  password: String,
  profile_image: String,
  is_active: { type: String, default: '1' },
  wallet_balance: { type: Number, default: 0 },
  fiberbase_token: String,
  referral_code: String,
}, { timestamps: true });

export default models.User || model('User', UserSchema);
