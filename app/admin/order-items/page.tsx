"use client";
import React, { useState } from 'react';
import DataTable, { Column } from '../components/DataTable';

interface OrderItem { id: string; order_id: string; product_name: string; qty: number; price: number; }

export default function OrderItemsPage() {
  const [data, setData] = useState<OrderItem[]>([
    { id: '1', order_id: 'ORD-123', product_name: 'Fresh Tomatoes 1kg', qty: 2, price: 60 },
    { id: '2', order_id: 'ORD-123', product_name: 'Potatoes 2kg', qty: 1, price: 80 },
  ]);

  const columns: Column<OrderItem>[] = [
    { key: 'order_id', label: 'Order ID', render: (row) => <span className="font-mono font-semibold">{row.order_id}</span> },
    { key: 'product_name', label: 'Product' },
    { key: 'qty', label: 'Quantity' },
    { key: 'price', label: 'Unit Price', render: (row) => <span>₹{row.price}</span> },
    { key: 'total', label: 'Subtotal', render: (row) => <span className="font-semibold">₹{row.qty * row.price}</span> },
  ];

  return (
    <div className="space-y-6">
      <div><h1 className="text-2xl font-bold text-gray-900 dark:text-white">Order Items</h1><p className="text-sm text-gray-500 mt-1">Line items for all orders</p></div>
      <DataTable data={data} columns={columns} actions={[]} keyExtractor={(row) => row.id} />
    </div>
  );
}
