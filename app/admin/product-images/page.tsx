"use client";
import React, { useState } from 'react';
import DataTable, { Column } from '../components/DataTable';

interface ProductImage { id: string; product_name: string; image_url: string; is_primary: string; }

export default function ProductImagesPage() {
  const [data, setData] = useState<ProductImage[]>([
    { id: '1', product_name: 'Fresh Tomatoes', image_url: 'https://via.placeholder.com/150', is_primary: '1' },
    { id: '2', product_name: 'Fresh Tomatoes', image_url: 'https://via.placeholder.com/150/111', is_primary: '0' },
  ]);

  const columns: Column<ProductImage>[] = [
    { key: 'image_url', label: 'Image', render: (row) => <img src={row.image_url} alt="Product" className="w-12 h-12 object-cover rounded-md" /> },
    { key: 'product_name', label: 'Product Name', render: (row) => <span className="font-semibold">{row.product_name}</span> },
    { key: 'is_primary', label: 'Type', render: (row) => (
      <span className={`px-2.5 py-1 rounded-full text-xs font-semibold ${row.is_primary === '1' ? 'bg-blue-100 text-blue-800' : 'bg-gray-100 text-gray-800'}`}>
        {row.is_primary === '1' ? 'Primary' : 'Gallery'}
      </span>
    )},
  ];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div><h1 className="text-2xl font-bold text-gray-900 dark:text-white">Product Images</h1><p className="text-sm text-gray-500 mt-1">Manage multiple images per product</p></div>
        <button className="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 transition-colors shadow-sm">Upload Image</button>
      </div>
      <DataTable data={data} columns={columns} actions={[]} keyExtractor={(row) => row.id} />
    </div>
  );
}
