"use client";
import React, { useState } from 'react';
import DataTable, { Column } from '../components/DataTable';

interface AbandonedCart { id: string; user_name: string; user_mobile: string; items_count: number; total_value: number; updated_at: string; }

export default function AbandonedCartsPage() {
  const [data, setData] = useState<AbandonedCart[]>([
    { id: '1', user_name: 'Test User 1', user_mobile: '9876543210', items_count: 3, total_value: 450.50, updated_at: '2025-11-20' },
    { id: '2', user_name: 'Test User 2', user_mobile: '9876543211', items_count: 1, total_value: 120.00, updated_at: '2025-11-21' },
  ]);

  const columns: Column<AbandonedCart>[] = [
    { key: 'user_name', label: 'User Name', render: (row) => <span className="font-semibold">{row.user_name}</span> },
    { key: 'user_mobile', label: 'Mobile' },
    { key: 'items_count', label: 'Items in Cart' },
    { key: 'total_value', label: 'Total Value', render: (row) => <span>₹{row.total_value.toFixed(2)}</span> },
    { key: 'updated_at', label: 'Last Updated' },
  ];

  return (
    <div className="space-y-6">
      <div><h1 className="text-2xl font-bold text-gray-900 dark:text-white">Abandoned Carts</h1><p className="text-sm text-gray-500 mt-1">Users who left items in cart</p></div>
      <DataTable data={data} columns={columns} actions={[]} keyExtractor={(row) => row.id} />
    </div>
  );
}
