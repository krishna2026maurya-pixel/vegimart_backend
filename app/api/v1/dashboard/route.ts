import { NextRequest, NextResponse } from 'next/server';
import { connectDB } from '@/lib/mongodb';
import mongoose from 'mongoose';
import Order from '@/lib/models/Order';
import OrderItem from '@/lib/models/OrderItem';
import Cart from '@/lib/models/Cart';
import Wishlist from '@/lib/models/Wishlist';
import Category from '@/lib/models/Category';
import CategoryType from '@/lib/models/CategoryType';
import Product from '@/lib/models/Product';
import Banner from '@/lib/models/Banner';
import User from '@/lib/models/User';
import { authMiddleware } from '@/lib/auth';

// Order status labels
const ORDER_STATUS_LABELS: Record<number, string> = {
  0: 'Pending',
  1: 'Confirmed',
  2: 'Processing',
  3: 'Out for Delivery',
  4: 'Delivered',
  5: 'Cancelled',
};

// Active order statuses (not delivered/cancelled)
const ACTIVE_ORDER_STATUSES = [0, 1, 2, 3];

async function getDashboard(request: NextRequest, userId: string) {
  try {
    await connectDB();

    const userObjectId = new mongoose.Types.ObjectId(userId);

    // ─── Run all queries in parallel ───────────────────────────────────────
    const [
      user,
      categories,
      categoryTypes,
      allProducts,
      banners,
      cart,
      wishlistItems,
      activeOrders,
      recentOrders,
    ] = await Promise.all([
      // 1. User profile
      User.findById(userObjectId).select('name email mobile_no wallet_balance profile_image referral_code').lean(),

      // 2. All active categories
      Category.find({ is_active: '1' }).sort({ sort_order: 1 }).lean(),

      // 3. All active category types
      CategoryType.find({ is_active: '1' }).sort({ sort_order: 1 }).lean(),

      // 4. All active products
      Product.find({ is_active: '1' }).lean(),

      // 5. Active banners
      Banner.find({ is_active: '1' }).sort({ sort_order: 1 }).lean(),

      // 6. User cart
      Cart.findOne({ user_id: userObjectId }).populate({
        path: 'items.product_id',
        select: 'product_name product_image selling_price mrp quantity is_active'
      }).lean(),

      // 7. User wishlist product IDs
      Wishlist.find({ user_id: userObjectId }).select('product_id').lean(),

      // 8. Active orders (pending/confirmed/processing/out-for-delivery)
      Order.find({ user_id: userObjectId, status: { $in: ACTIVE_ORDER_STATUSES } })
        .sort({ createdAt: -1 })
        .populate({
          path: 'items',
          model: 'OrderItem',
          select: 'product_name qty price image product_id'
        })
        .lean(),

      // 9. Recent orders (all, for history)
      Order.find({ user_id: userObjectId })
        .sort({ createdAt: -1 })
        .limit(5)
        .populate({
          path: 'items',
          model: 'OrderItem',
          select: 'product_name qty price image product_id'
        })
        .lean(),
    ]);

    if (!user) {
      return NextResponse.json({ error: 'User not found.' }, { status: 404 });
    }

    // ─── Build wishlist set for O(1) lookup ────────────────────────────────
    const wishlistProductIds = new Set(
      wishlistItems.map((w: any) => w.product_id.toString())
    );

    // ─── Build cart map for O(1) lookup ────────────────────────────────────
    const cartItems: any[] = (cart as any)?.items || [];
    const cartProductIds = new Set(
      cartItems.map((item: any) => {
        const pid = item.product_id?._id || item.product_id;
        return pid?.toString();
      })
    );

    // ─── Cart summary ───────────────────────────────────────────────────────
    let cartTotalAmount = 0;
    let cartTotalMrp = 0;

    const cartProducts = cartItems.map((item: any) => {
      const product = item.product_id as any;
      const qty = item.qty || 1;
      const price = item.price || product?.selling_price || 0;
      const mrp = product?.mrp || price;

      cartTotalAmount += price * qty;
      cartTotalMrp += mrp * qty;

      return {
        cart_item_id: item._id,
        product_id: product?._id,
        product_name: product?.product_name || 'Unknown',
        product_image: product?.product_image || null,
        selling_price: product?.selling_price || price,
        mrp: mrp,
        quantity_unit: product?.quantity || '',
        qty_in_cart: qty,
        subtotal: parseFloat((price * qty).toFixed(2)),
        is_active: product?.is_active || '1',
      };
    });

    const totalSavingAmount = parseFloat((cartTotalMrp - cartTotalAmount).toFixed(2));

    // ─── Enrich products with wishlist + cart info ─────────────────────────
    const enrichProduct = (p: any) => ({
      _id: p._id,
      product_name: p.product_name,
      product_image: p.product_image || null,
      selling_price: p.selling_price,
      mrp: p.mrp,
      gst: p.gst || 0,
      quantity: p.quantity,
      brand: p.brand || null,
      category: p.category || null,
      stock_status: p.stock_status,
      description: p.description || p.product_description || null,
      is_active: p.is_active,
      is_wishlist: wishlistProductIds.has(p._id.toString()),
      is_in_cart: cartProductIds.has(p._id.toString()),
    });

    // ─── Bestsellers: products with highest selling_price discount margin ──
    // Ranked by: (mrp - selling_price) / mrp desc, as "popular/deal"
    const bestsellers = [...allProducts]
      .filter(p => p.mrp && p.selling_price && p.mrp > p.selling_price)
      .sort((a, b) => {
        const discountA = ((a.mrp - a.selling_price) / a.mrp) * 100;
        const discountB = ((b.mrp - b.selling_price) / b.mrp) * 100;
        return discountB - discountA;
      })
      .slice(0, 10)
      .map(enrichProduct);

    // ─── Trending Near You: recently added products (newest first) ─────────
    const trendingNearYou = [...allProducts]
      .sort((a: any, b: any) => {
        const dateA = a.createdAt ? new Date(a.createdAt).getTime() : 0;
        const dateB = b.createdAt ? new Date(b.createdAt).getTime() : 0;
        return dateB - dateA;
      })
      .slice(0, 10)
      .map(enrichProduct);

    // ─── Products grouped by Category ──────────────────────────────────────
    // Build a map of category name -> products
    const productsByCategoryMap: Record<string, any[]> = {};
    for (const p of allProducts) {
      const catKey = p.category || 'Uncategorized';
      if (!productsByCategoryMap[catKey]) {
        productsByCategoryMap[catKey] = [];
      }
      productsByCategoryMap[catKey].push(enrichProduct(p));
    }

    // Map categories from DB and attach products to them
    const categoriesWithProducts = categories.map((cat: any) => {
      const products = productsByCategoryMap[cat.name] || [];
      return {
        _id: cat._id,
        name: cat.name,
        image: cat.image || null,
        sort_order: cat.sort_order,
        product_count: products.length,
        products,
      };
    });

    // Also add any categories found in products but not in DB categories
    for (const [catName, prods] of Object.entries(productsByCategoryMap)) {
      const alreadyIncluded = categories.some((c: any) => c.name === catName);
      if (!alreadyIncluded && catName !== 'Uncategorized') {
        categoriesWithProducts.push({
          _id: null,
          name: catName,
          image: null,
          sort_order: 999,
          product_count: prods.length,
          products: prods,
        });
      }
    }

    // ─── Category Types with their categories ─────────────────────────────
    const categoryTypesData = categoryTypes.map((ct: any) => ({
      _id: ct._id,
      name: ct.name,
      image: ct.image || null,
      slug: ct.slug || null,
      sort_order: ct.sort_order,
    }));

    // ─── Active orders with enriched status ────────────────────────────────
    const activeOrdersData = activeOrders.map((order: any) => ({
      _id: order._id,
      order_number: order.order_number,
      status: order.status,
      status_label: ORDER_STATUS_LABELS[order.status] || 'Unknown',
      total_amount: order.total_amount,
      payment_method: order.payment_method,
      payment_status: order.payment_status,
      items_count: order.items?.length || 0,
      items: (order.items || []).map((item: any) => ({
        product_id: item.product_id,
        product_name: item.product_name,
        qty: item.qty,
        price: item.price,
        image: item.image || null,
      })),
      created_at: order.createdAt,
      updated_at: order.updatedAt,
    }));

    // ─── Recent orders ──────────────────────────────────────────────────────
    const recentOrdersData = recentOrders.map((order: any) => ({
      _id: order._id,
      order_number: order.order_number,
      status: order.status,
      status_label: ORDER_STATUS_LABELS[order.status] || 'Unknown',
      total_amount: order.total_amount,
      payment_method: order.payment_method,
      payment_status: order.payment_status,
      items_count: order.items?.length || 0,
      items: (order.items || []).map((item: any) => ({
        product_id: item.product_id,
        product_name: item.product_name,
        qty: item.qty,
        price: item.price,
        image: item.image || null,
      })),
      created_at: order.createdAt,
      updated_at: order.updatedAt,
    }));

    // ─── Build final response ───────────────────────────────────────────────
    return NextResponse.json({
      success: true,
      data: {
        // User info
        user: {
          _id: (user as any)._id,
          name: (user as any).name,
          email: (user as any).email,
          mobile_no: (user as any).mobile_no,
          wallet_balance: (user as any).wallet_balance || 0,
          profile_image: (user as any).profile_image || null,
          referral_code: (user as any).referral_code || null,
        },

        // Banners
        banners,

        // Category Types (top-level type groupings)
        category_types: categoryTypesData,

        // Categories with products
        categories: categoriesWithProducts,

        // Bestseller products
        bestsellers,

        // Trending near you
        trending_near_you: trendingNearYou,

        // Cart summary
        cart: {
          cart_count: cartProducts.length,
          total_cart_amount: parseFloat(cartTotalAmount.toFixed(2)),
          total_mrp_amount: parseFloat(cartTotalMrp.toFixed(2)),
          total_saving_amount: totalSavingAmount > 0 ? totalSavingAmount : 0,
          products: cartProducts,
        },

        // Wishlist summary
        wishlist: {
          wishlist_count: wishlistProductIds.size,
          product_ids: Array.from(wishlistProductIds),
        },

        // Active orders
        active_orders: {
          count: activeOrdersData.length,
          orders: activeOrdersData,
        },

        // Recent order history
        recent_orders: recentOrdersData,
      },
    });
  } catch (e: any) {
    console.error('[Dashboard API Error]', e);
    return NextResponse.json({ success: false, error: e.message }, { status: 500 });
  }
}

export const GET = authMiddleware(getDashboard);
export const POST = authMiddleware(getDashboard);
