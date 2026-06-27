"use client";
import React, { useState } from 'react';
import DataTable, { Column } from '../components/DataTable';

interface Cart { id: string; user_name: string; product_name: string; qty: number; updated_at: string; }

export default function CartsPage() {
  const [data, setData] = useState<Cart[]>([
    { id: '1', user_name: 'Aman', product_name: 'Apples 1kg', qty: 2, updated_at: '2025-11-20' },
    { id: '2', user_name: 'Aman', product_name: 'Bananas 1doz', qty: 1, updated_at: '2025-11-20' },
  ]);

  const columns: Column<Cart>[] = [
    { key: 'user_name', label: 'User Name', render: (row) => <span className="font-semibold">{row.user_name}</span> },
    { key: 'product_name', label: 'Product in Cart' },
    { key: 'qty', label: 'Quantity' },
    { key: 'updated_at', label: 'Last Updated' },
  ];

  return (
    <div className="space-y-6">
      <div><h1 className="text-2xl font-bold text-gray-900 dark:text-white">Active Carts</h1><p className="text-sm text-gray-500 mt-1">Items currently in users' carts</p></div>
      <DataTable data={data} columns={columns} actions={[]} keyExtractor={(row) => row.id} />
    </div>
  );
}
