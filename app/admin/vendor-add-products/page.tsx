"use client";

import React, { useEffect, useState, useCallback } from 'react';
import DataTable, { Column, Action, BulkAction } from '../components/DataTable';
import { Eye, Trash2, Plus } from 'lucide-react';
import Link from 'next/link';

interface VendorProduct {
  _id: string;
  product_name: string;
  brand?: string;
  category?: string;
  subcategory?: string;
  quantity?: string;
  mrp: number;
  selling_price: number;
  gst?: number;
  stock_status?: string;
  product_images?: string;
}

export default function VendorProductsPage() {
  const [products, setProducts] = useState<VendorProduct[]>([]);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [total, setTotal] = useState(0);
  const [search, setSearch] = useState('');
  const [error, setError] = useState('');
  const limit = 10;

  const fetchData = useCallback(async () => {
    setLoading(true);
    setError('');
    try {
      const params = new URLSearchParams({ page: String(page), limit: String(limit), search });
      const res = await fetch(`/api/vendor-add-products?${params}`);
      if (!res.ok) throw new Error(`Server error: ${res.status}`);
      const json = await res.json();
      setProducts(json.data || []);
      setTotalPages(json.meta?.totalPages || 1);
      setTotal(json.meta?.total || 0);
    } catch (e: any) {
      setError(e.message || 'Failed to load vendor products');
    } finally {
      setLoading(false);
    }
  }, [page, search]);

  useEffect(() => { fetchData(); }, [fetchData]);

  const columns: Column<VendorProduct>[] = [
    {
      key: 'product_images',
      label: 'Image',
      render: (row) => (
        row.product_images ? (
          <img src={row.product_images.startsWith('/') || row.product_images.startsWith('http') ? row.product_images : `/uploads/${row.product_images}`} alt={row.product_name} className="w-10 h-10 rounded-lg object-cover" />
        ) : (
          <div className="w-10 h-10 rounded-lg bg-green-100 flex items-center justify-center text-green-700 font-bold">
            {row.product_name?.charAt(0) || 'P'}
          </div>
        )
      )
    },
    { key: 'product_name', label: 'Product Name', render: (row) => <span className="font-semibold text-gray-900 dark:text-white">{row.product_name}</span> },
    { key: 'brand', label: 'Brand' },
    { key: 'quantity', label: 'Quantity' },
    { key: 'mrp', label: 'MRP', render: (row) => <span>₹{row.mrp}</span> },
    { key: 'selling_price', label: 'Selling Price', render: (row) => <span className="text-green-600 font-semibold">₹{row.selling_price}</span> },
    { key: 'stock_status', label: 'Stock Status' },
  ];

  const actions: Action<VendorProduct>[] = [
    {
      label: 'Delete',
      icon: <Trash2 size={15} />,
      color: 'danger',
      onClick: async (row) => {
        if (!confirm(`"${row.product_name}" को delete करें?`)) return;
        await fetch(`/api/vendor-add-products/${row._id}`, { method: 'DELETE' });
        fetchData();
      }
    },
  ];

  const bulkActions: BulkAction[] = [
    {
      label: 'Delete Selected',
      icon: <Trash2 size={14} />,
      color: 'danger',
      onClick: async (ids) => {
        if (!confirm(`${ids.length} products delete करें?`)) return;
        await Promise.all(ids.map(id => fetch(`/api/vendor-add-products/${id}`, { method: 'DELETE' })));
        fetchData();
      }
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Vendor Products</h1>
          <p className="text-sm text-gray-500 mt-1">Total: {total} products</p>
        </div>
        <Link href="/admin/vendor-add-products/create">
          <button className="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition shadow-sm font-medium">
            <Plus size={16} /> New Vendor Product
          </button>
        </Link>
      </div>

      {error && (
        <div className="p-4 bg-red-50 border border-red-200 text-red-700 rounded-lg text-sm">
          ⚠️ {error} — <button onClick={fetchData} className="underline">Retry</button>
        </div>
      )}

      <div>
        <input
          type="text"
          placeholder="Search products..."
          value={search}
          onChange={(e) => { setSearch(e.target.value); setPage(1); }}
          className="px-4 py-2 border border-gray-300 rounded-lg text-sm w-72 focus:outline-none focus:ring-2 focus:ring-green-500 dark:bg-gray-700 dark:border-gray-600 dark:text-white"
        />
      </div>

      <DataTable
        data={products}
        columns={columns}
        actions={actions}
        bulkActions={bulkActions}
        keyExtractor={(row) => row._id}
        loading={loading}
      />

      {totalPages > 1 && (
        <div className="flex items-center justify-between">
          <span className="text-sm text-gray-500">Page {page} of {totalPages}</span>
          <div className="flex gap-2">
            <button onClick={() => setPage(p => Math.max(1, p - 1))} disabled={page === 1}
              className="px-3 py-1.5 text-sm border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40">← Prev</button>
            <button onClick={() => setPage(p => Math.min(totalPages, p + 1))} disabled={page === totalPages}
              className="px-3 py-1.5 text-sm border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40">Next →</button>
          </div>
        </div>
      )}
    </div>
  );
}
