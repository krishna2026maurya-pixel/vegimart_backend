// seed.mjs - MongoDB Atlas Sample Data Seeder
// Run: node seed.mjs

import mongoose from 'mongoose';
import { readFileSync } from 'fs';

// Load .env.local manually
const envContent = readFileSync('.env.local', 'utf8');
const envVars = Object.fromEntries(
  envContent.split('\n')
    .filter(line => line.includes('=') && !line.startsWith('#'))
    .map(line => { const [k, ...v] = line.split('='); return [k.trim(), v.join('=').trim()]; })
);
const MONGODB_URI = envVars.MONGODB_URI;

console.log('🔗 Connecting to MongoDB Atlas...');
await mongoose.connect(MONGODB_URI);
console.log('✅ Connected!\n');

const db = mongoose.connection.db;

// ─────────────────────────────────────────────────────────────────────────────
// HELPERS
// ─────────────────────────────────────────────────────────────────────────────
const rand = (arr) => arr[Math.floor(Math.random() * arr.length)];
const randInt = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;
const randFloat = (min, max) => parseFloat((Math.random() * (max - min) + min).toFixed(2));
const cities = ['Mumbai', 'Delhi', 'Pune', 'Bangalore', 'Hyderabad', 'Chennai', 'Jaipur', 'Lucknow', 'Ahmedabad', 'Surat'];
const indianNames = ['Rahul Kumar', 'Amit Sharma', 'Priya Singh', 'Suresh Das', 'Neha Gupta', 'Vijay Patel', 'Anita Rao', 'Rajesh Verma', 'Sunita Joshi', 'Manoj Tiwari', 'Kavita Mehta', 'Deepak Nair', 'Pooja Yadav', 'Sanjay Bose', 'Rekha Iyer'];
const shopNames = ['Fresh Farm Mart', 'Green Grocers', 'Nature\'s Basket', 'Veggie World', 'Organic Corner', 'Daily Fresh', 'Farm to Fork', 'Pure Veggies', 'Harvest Hub', 'Field Fresh'];
const vehicleTypes = ['Bike', 'Scooter', 'Cycle', 'Van'];
const today = new Date();
const daysAgo = (n) => new Date(today - n * 86400000);

// ─────────────────────────────────────────────────────────────────────────────
// DROP existing collections
// ─────────────────────────────────────────────────────────────────────────────
const colls = ['vendors','products','orders','deliveryboys','users','categories','brands','coupons','banners'];
for (const c of colls) {
  try { await db.collection(c).drop(); } catch {}
}
console.log('🗑️  Old data cleared\n');

// ─────────────────────────────────────────────────────────────────────────────
// 1. VENDORS (20)
// ─────────────────────────────────────────────────────────────────────────────
const vendors = Array.from({ length: 20 }, (_, i) => ({
  full_name: indianNames[i % indianNames.length],
  email: `vendor${i + 1}@vegimart.com`,
  mobile_number: `98${randInt(10000000, 99999999)}`,
  shop_name: shopNames[i % shopNames.length] + (i >= shopNames.length ? ` ${Math.floor(i/shopNames.length)+1}` : ''),
  city: rand(cities),
  address: `${randInt(1, 999)} Main Road, ${rand(cities)}`,
  is_verified: rand(['1', '1', '1', '0']),
  is_bestseller: rand(['1', '0', '0']),
  wallet_balance: randFloat(0, 5000),
  is_active: '1',
  shop_image: null,
  created_at: daysAgo(randInt(10, 365)).toISOString(),
}));
const insertedVendors = await db.collection('vendors').insertMany(vendors);
console.log(`✅ ${vendors.length} Vendors inserted`);

// ─────────────────────────────────────────────────────────────────────────────
// 2. CATEGORIES (8)
// ─────────────────────────────────────────────────────────────────────────────
const categoryNames = ['Vegetables', 'Fruits', 'Dairy & Eggs', 'Herbs & Spices', 'Organic', 'Exotic Vegetables', 'Leafy Greens', 'Root Vegetables'];
const categoryImageMap = {
  'Vegetables': 'https://images.unsplash.com/photo-1566385101042-1a0aa0c1268c?w=400&auto=format&fit=crop&q=80',
  'Fruits': 'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?w=400&auto=format&fit=crop&q=80',
  'Dairy & Eggs': 'https://images.unsplash.com/photo-1596797038530-2c107229654b?w=400&auto=format&fit=crop&q=80',
  'Herbs & Spices': 'https://images.unsplash.com/photo-1596003906949-67221c37965c?w=400&auto=format&fit=crop&q=80',
  'Organic': 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&auto=format&fit=crop&q=80',
  'Exotic Vegetables': 'https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?w=400&auto=format&fit=crop&q=80',
  'Leafy Greens': 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400&auto=format&fit=crop&q=80',
  'Root Vegetables': 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=400&auto=format&fit=crop&q=80'
};
const categories = categoryNames.map((name, i) => ({
  name,
  slug: name.toLowerCase().replace(/\s+&\s+/g, '-').replace(/\s+/g, '-'),
  image: categoryImageMap[name] || null,
  is_active: '1',
  sort_order: i + 1,
  created_at: daysAgo(randInt(30, 300)).toISOString(),
}));
const insertedCats = await db.collection('categories').insertMany(categories);
console.log(`✅ ${categories.length} Categories inserted`);

// ─────────────────────────────────────────────────────────────────────────────
// 3. BRANDS (6)
// ─────────────────────────────────────────────────────────────────────────────
const brandNames = ['Farm Fresh', 'Organic India', 'Nature\'s Best', 'Green Leaf', 'Pure Harvest', 'Golden Fields'];
const brandLogoMap = {
  'Farm Fresh': 'https://images.unsplash.com/photo-1500937386664-56d1dfef3854?w=200&auto=format&fit=crop&q=80',
  'Organic India': 'https://images.unsplash.com/photo-1542601906990-b4d3fb778b09?w=200&auto=format&fit=crop&q=80',
  'Nature\'s Best': 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=200&auto=format&fit=crop&q=80',
  'Green Leaf': 'https://images.unsplash.com/photo-1530595467537-0b5996c41f2d?w=200&auto=format&fit=crop&q=80',
  'Pure Harvest': 'https://images.unsplash.com/photo-1592417817098-8f3d6eb19675?w=200&auto=format&fit=crop&q=80',
  'Golden Fields': 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=200&auto=format&fit=crop&q=80'
};
const brands = brandNames.map((name, i) => ({
  name,
  logo: brandLogoMap[name] || null,
  is_active: '1',
  created_at: daysAgo(randInt(30, 300)).toISOString(),
}));
await db.collection('brands').insertMany(brands);
console.log(`✅ ${brands.length} Brands inserted`);

// ─────────────────────────────────────────────────────────────────────────────
// 4. PRODUCTS (30)
// ─────────────────────────────────────────────────────────────────────────────
const productList = [
  { name: 'Fresh Tomatoes', unit: '1 kg', mrp: 60, sp: 50 },
  { name: 'Organic Potatoes', unit: '1 kg', mrp: 40, sp: 35 },
  { name: 'Green Apples', unit: '1 kg', mrp: 200, sp: 180 },
  { name: 'Spinach (Palak)', unit: '500g', mrp: 30, sp: 25 },
  { name: 'Onions', unit: '1 kg', mrp: 35, sp: 28 },
  { name: 'Carrots', unit: '500g', mrp: 45, sp: 38 },
  { name: 'Cucumber', unit: '1 kg', mrp: 30, sp: 24 },
  { name: 'Broccoli', unit: '500g', mrp: 80, sp: 70 },
  { name: 'Bell Peppers', unit: '250g', mrp: 60, sp: 50 },
  { name: 'Cauliflower', unit: '1 pc', mrp: 40, sp: 32 },
  { name: 'Cabbage', unit: '1 kg', mrp: 25, sp: 20 },
  { name: 'Garlic', unit: '250g', mrp: 60, sp: 50 },
  { name: 'Ginger', unit: '250g', mrp: 50, sp: 42 },
  { name: 'Bananas', unit: '1 dozen', mrp: 60, sp: 48 },
  { name: 'Mangoes (Alphonso)', unit: '1 kg', mrp: 350, sp: 300 },
  { name: 'Watermelon', unit: '1 pc', mrp: 120, sp: 95 },
  { name: 'Grapes (Green)', unit: '500g', mrp: 90, sp: 78 },
  { name: 'Orange', unit: '1 kg', mrp: 80, sp: 65 },
  { name: 'Paneer', unit: '200g', mrp: 95, sp: 85 },
  { name: 'Coriander Leaves', unit: '100g', mrp: 15, sp: 12 },
  { name: 'Mint Leaves', unit: '100g', mrp: 12, sp: 10 },
  { name: 'Lemon', unit: '6 pcs', mrp: 30, sp: 25 },
  { name: 'Pumpkin', unit: '1 kg', mrp: 35, sp: 28 },
  { name: 'Ladies Finger (Okra)', unit: '500g', mrp: 45, sp: 38 },
  { name: 'Bitter Gourd', unit: '500g', mrp: 50, sp: 42 },
  { name: 'Ridge Gourd', unit: '500g', mrp: 35, sp: 28 },
  { name: 'Bottle Gourd', unit: '1 pc', mrp: 30, sp: 24 },
  { name: 'Sweet Potato', unit: '1 kg', mrp: 55, sp: 45 },
  { name: 'Raw Banana', unit: '1 kg', mrp: 40, sp: 32 },
  { name: 'Drumstick (Moringa)', unit: '500g', mrp: 40, sp: 33 },
];

const vendorIds = Object.values(insertedVendors.insertedIds);
const productImageMap = {
  'Fresh Tomatoes': 'https://images.unsplash.com/photo-1595855759920-86582396756a?w=400&auto=format&fit=crop&q=80',
  'Organic Potatoes': 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=400&auto=format&fit=crop&q=80',
  'Green Apples': 'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?w=400&auto=format&fit=crop&q=80',
  'Spinach (Palak)': 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400&auto=format&fit=crop&q=80',
  'Onions': 'https://images.unsplash.com/photo-1618512457222-1d5757d54e42?w=400&auto=format&fit=crop&q=80',
  'Carrots': 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=400&auto=format&fit=crop&q=80',
  'Cucumber': 'https://images.unsplash.com/photo-1449300079324-964320ded19c?w=400&auto=format&fit=crop&q=80',
  'Broccoli': 'https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?w=400&auto=format&fit=crop&q=80',
  'Bell Peppers': 'https://images.unsplash.com/photo-1563565088-91349b17adbe?w=400&auto=format&fit=crop&q=80',
  'Cauliflower': 'https://images.unsplash.com/photo-1568584711075-3d021a7c3ce3?w=400&auto=format&fit=crop&q=80',
  'Cabbage': 'https://images.unsplash.com/photo-1581447100512-68b5c1013d22?w=400&auto=format&fit=crop&q=80',
  'Garlic': 'https://images.unsplash.com/photo-1540148426945-6cf22a6b2383?w=400&auto=format&fit=crop&q=80',
  'Ginger': 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?w=400&auto=format&fit=crop&q=80',
  'Bananas': 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400&auto=format&fit=crop&q=80',
  'Mangoes (Alphonso)': 'https://images.unsplash.com/photo-1553279768-865429fa0078?w=400&auto=format&fit=crop&q=80',
  'Watermelon': 'https://images.unsplash.com/photo-1589984662646-e7b2e4962f18?w=400&auto=format&fit=crop&q=80',
  'Grapes (Green)': 'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=400&auto=format&fit=crop&q=80',
  'Orange': 'https://images.unsplash.com/photo-1547514701-42782101795e?w=400&auto=format&fit=crop&q=80',
  'Paneer': 'https://images.unsplash.com/photo-1596797038530-2c107229654b?w=400&auto=format&fit=crop&q=80',
  'Coriander Leaves': 'https://images.unsplash.com/photo-1608797178974-15b35a61d121?w=400&auto=format&fit=crop&q=80',
  'Mint Leaves': 'https://images.unsplash.com/photo-1589088365851-d419b49bbbb7?w=400&auto=format&fit=crop&q=80',
  'Lemon': 'https://images.unsplash.com/photo-1590502593747-42a996133562?w=400&auto=format&fit=crop&q=80',
  'Pumpkin': 'https://images.unsplash.com/photo-1506806732259-39c2d0268443?w=400&auto=format&fit=crop&q=80',
  'Ladies Finger (Okra)': 'https://images.unsplash.com/photo-1627914562479-7a3b3469a536?w=400&auto=format&fit=crop&q=80',
  'Bitter Gourd': 'https://images.unsplash.com/photo-1627914562479-7a3b3469a536?w=400&auto=format&fit=crop&q=80',
  'Ridge Gourd': 'https://images.unsplash.com/photo-1627914562479-7a3b3469a536?w=400&auto=format&fit=crop&q=80',
  'Bottle Gourd': 'https://images.unsplash.com/photo-1627914562479-7a3b3469a536?w=400&auto=format&fit=crop&q=80',
  'Sweet Potato': 'https://images.unsplash.com/photo-1596003906949-67221c37965c?w=400&auto=format&fit=crop&q=80',
  'Raw Banana': 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=400&auto=format&fit=crop&q=80',
  'Drumstick (Moringa)': 'https://images.unsplash.com/photo-1608797178974-15b35a61d121?w=400&auto=format&fit=crop&q=80'
};

const products = productList.map((p, i) => ({
  product_name: p.name,
  vendor_id: rand(vendorIds),
  vendor_shop_name: rand(shopNames),
  brand: rand(brandNames),
  quantity: p.unit,
  mrp: p.mrp,
  selling_price: p.sp,
  gst: rand([0, 5, 12]),
  stock_status: randInt(0, 200),
  product_image: productImageMap[p.name] || null,
  is_active: rand(['1', '1', '1', '0']),
  description: `Fresh ${p.name} sourced directly from farms.`,
  created_at: daysAgo(randInt(1, 180)).toISOString(),
}));
const insertedProducts = await db.collection('products').insertMany(products);
console.log(`✅ ${products.length} Products inserted`);

// ─────────────────────────────────────────────────────────────────────────────
// 5. USERS (15)
// ─────────────────────────────────────────────────────────────────────────────
const users = Array.from({ length: 15 }, (_, i) => ({
  name: indianNames[i],
  mobile_number: `97${randInt(10000000, 99999999)}`,
  email: `user${i + 1}@gmail.com`,
  city: rand(cities),
  wallet_balance: randFloat(0, 500),
  is_active: '1',
  created_at: daysAgo(randInt(5, 200)).toISOString(),
}));
const insertedUsers = await db.collection('users').insertMany(users);
console.log(`✅ ${users.length} Users inserted`);

// ─────────────────────────────────────────────────────────────────────────────
// 6. DELIVERY BOYS (10)
// ─────────────────────────────────────────────────────────────────────────────
const deliveryBoys = Array.from({ length: 10 }, (_, i) => ({
  name: `Delivery ${indianNames[i]}`,
  mobile_number: `96${randInt(10000000, 99999999)}`,
  email: `delivery${i + 1}@vegimart.com`,
  vehicle_type: rand(vehicleTypes),
  vehicle_number: `MH${randInt(10,99)}-${String.fromCharCode(65+randInt(0,25))}${String.fromCharCode(65+randInt(0,25))}-${randInt(1000,9999)}`,
  is_verified: rand(['1','1','0']),
  is_active: rand(['1','1','0']),
  wallet_balance: randFloat(0, 2000),
  city: rand(cities),
  created_at: daysAgo(randInt(10, 200)).toISOString(),
}));
await db.collection('deliveryboys').insertMany(deliveryBoys);
console.log(`✅ ${deliveryBoys.length} Delivery Boys inserted`);

// ─────────────────────────────────────────────────────────────────────────────
// 7. ORDERS (40)
// ─────────────────────────────────────────────────────────────────────────────
const userIds = Object.values(insertedUsers.insertedIds);
const productIds = Object.values(insertedProducts.insertedIds);
const statusOptions = [0, 1, 2, 3, 4, 5];
const paymentMethods = ['COD', 'ONLINE'];
const paymentStatuses = ['pending', 'completed', 'failed'];

const orders = Array.from({ length: 40 }, (_, i) => {
  const method = rand(paymentMethods);
  const total = randFloat(100, 2000);
  const orderDate = daysAgo(randInt(0, 90));
  return {
    order_number: `ORD-${orderDate.getFullYear()}-${String(i + 1).padStart(4, '0')}`,
    user_id: rand(userIds),
    customer_mobile: `97${randInt(10000000, 99999999)}`,
    total_amount: total,
    payment_method: method,
    payment_status: method === 'COD' ? rand(['pending', 'completed']) : rand(paymentStatuses),
    status: rand(statusOptions),
    city: rand(cities),
    delivery_address: `${randInt(1, 999)} ${rand(['MG Road', 'Ring Road', 'Civil Lines', 'New Market'])}, ${rand(cities)}`,
    items: Array.from({ length: randInt(1, 4) }, () => ({
      product_id: rand(productIds),
      product_name: rand(productList).name,
      quantity: randInt(1, 3),
      price: randFloat(20, 300),
    })),
    created_at: orderDate.toISOString(),
  };
});
await db.collection('orders').insertMany(orders);
console.log(`✅ ${orders.length} Orders inserted`);

// ─────────────────────────────────────────────────────────────────────────────
// 8. COUPONS (5)
// ─────────────────────────────────────────────────────────────────────────────
const coupons = [
  { code: 'FRESH10', discount_type: 'percent', discount_value: 10, min_order: 200, max_uses: 100, used_count: randInt(10, 80), is_active: '1', expires_at: daysAgo(-30).toISOString() },
  { code: 'SAVE50', discount_type: 'flat', discount_value: 50, min_order: 500, max_uses: 50, used_count: randInt(5, 45), is_active: '1', expires_at: daysAgo(-15).toISOString() },
  { code: 'ORGANIC20', discount_type: 'percent', discount_value: 20, min_order: 300, max_uses: 30, used_count: randInt(0, 25), is_active: '1', expires_at: daysAgo(-60).toISOString() },
  { code: 'WELCOME100', discount_type: 'flat', discount_value: 100, min_order: 400, max_uses: 200, used_count: randInt(50, 180), is_active: '0', expires_at: daysAgo(5).toISOString() },
  { code: 'VEGI15', discount_type: 'percent', discount_value: 15, min_order: 250, max_uses: 75, used_count: randInt(0, 50), is_active: '1', expires_at: daysAgo(-45).toISOString() },
];
await db.collection('coupons').insertMany(coupons);
console.log(`✅ ${coupons.length} Coupons inserted`);

// ─────────────────────────────────────────────────────────────────────────────
// 9. BANNERS (4)
// ─────────────────────────────────────────────────────────────────────────────
const banners = [
  { title: 'Fresh Vegetables Sale', subtitle: 'Up to 30% off on all vegetables', image: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=800&auto=format&fit=crop&q=80', link: '/shop', is_active: '1', sort_order: 1 },
  { title: 'New Season Fruits', subtitle: 'Mangoes, Watermelons & more', image: 'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?w=800&auto=format&fit=crop&q=80', link: '/fruits', is_active: '1', sort_order: 2 },
  { title: 'Organic Range', subtitle: 'Chemical-free, farm fresh', image: 'https://images.unsplash.com/photo-1500937386664-56d1dfef3854?w=800&auto=format&fit=crop&q=80', link: '/organic', is_active: '1', sort_order: 3 },
  { title: 'Free Delivery', subtitle: 'On orders above ₹299', image: 'https://images.unsplash.com/photo-1596461404969-9ae70f2830c1?w=800&auto=format&fit=crop&q=80', link: '/shop', is_active: '0', sort_order: 4 },
];
await db.collection('banners').insertMany(banners);
console.log(`✅ ${banners.length} Banners inserted`);

// ─────────────────────────────────────────────────────────────────────────────
// SUMMARY
// ─────────────────────────────────────────────────────────────────────────────
console.log('\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
console.log('🎉 Seed complete! MongoDB Atlas में data import हो गया:');
console.log('   • 20 Vendors');
console.log('   • 30 Products');
console.log('   • 40 Orders');
console.log('   • 15 Users');
console.log('   • 10 Delivery Boys');
console.log('   • 8 Categories');
console.log('   • 6 Brands');
console.log('   • 5 Coupons');
console.log('   • 4 Banners');
console.log('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n');

await mongoose.disconnect();
