import mongoose, { Schema, model, models } from 'mongoose';

const OrderSchema = new Schema({
  order_number: { type: String, required: true },
  user_id: { type: Schema.Types.ObjectId, ref: 'User' },
  delivery_boy_id: { type: Schema.Types.ObjectId, ref: 'DeliveryBoy', default: null },
  total_amount: Number,
  admin_commission: Number,
  delivery_charge: Number,
  payment_method: { type: String, enum: ['COD', 'ONLINE'], default: 'COD' },
  payment_status: { type: String, enum: ['pending', 'completed', 'failed'], default: 'pending' },
  status: { type: Number, default: 0 },
  items: [{ type: Schema.Types.ObjectId, ref: 'OrderItem' }],
}, { timestamps: true });

export default models.Order || model('Order', OrderSchema);
