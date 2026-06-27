"use client";
import React, { useState } from 'react';
import DataTable, { Column } from '../components/DataTable';

interface DeliveryCharge { id: string; min_distance: number; max_distance: number; charge: number; is_active: string; }

export default function DeliveryChargesPage() {
  const [data, setData] = useState<DeliveryCharge[]>([
    { id: '1', min_distance: 0, max_distance: 5, charge: 30, is_active: '1' },
    { id: '2', min_distance: 5, max_distance: 10, charge: 50, is_active: '1' },
    { id: '3', min_distance: 10, max_distance: 15, charge: 80, is_active: '1' },
  ]);

  const columns: Column<DeliveryCharge>[] = [
    { key: 'min_distance', label: 'Min Distance (km)' },
    { key: 'max_distance', label: 'Max Distance (km)' },
    { key: 'charge', label: 'Delivery Charge', render: (row) => <span>₹{row.charge}</span> },
    { key: 'is_active', label: 'Status', render: (row) => (
      <span className={`px-2.5 py-1 rounded-full text-xs font-semibold ${row.is_active === '1' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>
        {row.is_active === '1' ? 'Active' : 'Inactive'}
      </span>
    )},
  ];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div><h1 className="text-2xl font-bold text-gray-900 dark:text-white">Delivery Charges</h1><p className="text-sm text-gray-500 mt-1">Manage delivery fee structures</p></div>
        <button className="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 transition-colors shadow-sm">New Rule</button>
      </div>
      <DataTable data={data} columns={columns} actions={[]} keyExtractor={(row) => row.id} />
    </div>
  );
}
