import mongoose, { Schema, model, models } from 'mongoose';

const OrderItemSchema = new Schema({
  order_id: { type: Schema.Types.ObjectId, ref: 'Order', required: true },
  product_id: { type: Schema.Types.ObjectId, ref: 'Product', required: true },
  product_name: { type: String, required: true },
  qty: { type: Number, required: true },
  price: { type: Number, required: true },
  image: String
}, { timestamps: true });

export default models.OrderItem || model('OrderItem', OrderItemSchema);
