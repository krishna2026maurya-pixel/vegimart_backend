import mongoose, { Schema, model, models } from 'mongoose';

const AddressSchema = new Schema({
  user_id: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  label: { type: String, default: 'Home' }, // Home, Work, Other
  name: { type: String, required: true },
  mobile: { type: String, required: true },
  address_line: { type: String, required: true },
  city: { type: String, required: true },
  state: { type: String, required: true },
  pincode: { type: String, required: true },
  is_default: { type: Schema.Types.Mixed, default: false } // Boolean or String depending on API schema
}, { timestamps: true });

export default models.Address || model('Address', AddressSchema);
