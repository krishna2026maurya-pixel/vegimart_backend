"use client";
import React, { useState } from 'react';
import DataTable, { Column } from '../components/DataTable';

interface UserAddress { id: string; user_name: string; address_type: string; address: string; city: string; pincode: string; }

export default function UserAddressesPage() {
  const [data, setData] = useState<UserAddress[]>([
    { id: '1', user_name: 'Neha', address_type: 'Home', address: '123, Rose Villa, MG Road', city: 'Mumbai', pincode: '400001' },
    { id: '2', user_name: 'Karan', address_type: 'Office', address: '45, Tech Park, Andheri', city: 'Mumbai', pincode: '400053' },
  ]);

  const columns: Column<UserAddress>[] = [
    { key: 'user_name', label: 'User Name', render: (row) => <span className="font-semibold">{row.user_name}</span> },
    { key: 'address_type', label: 'Type', render: (row) => <span className="px-2 py-0.5 bg-gray-100 text-gray-700 text-xs rounded-full font-medium">{row.address_type}</span> },
    { key: 'address', label: 'Address' },
    { key: 'city', label: 'City' },
    { key: 'pincode', label: 'Pincode' },
  ];

  return (
    <div className="space-y-6">
      <div><h1 className="text-2xl font-bold text-gray-900 dark:text-white">User Addresses</h1><p className="text-sm text-gray-500 mt-1">Saved delivery addresses</p></div>
      <DataTable data={data} columns={columns} actions={[]} keyExtractor={(row) => row.id} />
    </div>
  );
}
