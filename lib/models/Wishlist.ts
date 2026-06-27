import mongoose, { Schema, model, models } from 'mongoose';

const WishlistSchema = new Schema({
  user_id: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  product_id: { type: Schema.Types.ObjectId, ref: 'Product', required: true }
}, { timestamps: true });

// Ensure unique combination of user and product in wishlist
WishlistSchema.index({ user_id: 1, product_id: 1 }, { unique: true });

export default models.Wishlist || model('Wishlist', WishlistSchema);
