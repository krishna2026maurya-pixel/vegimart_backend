"use client";

import React, { useEffect, useState, useCallback } from 'react';
import DataTable, { Column, Action, BulkAction } from '../components/DataTable';
import { Eye, Trash2, Plus } from 'lucide-react';
import Link from 'next/link';

interface VendorCategory {
  _id: string;
  category_name: string;
  description: string;
  category_image?: string;
  cat_type_id?: number;
}

export default function VendorCategoriesPage() {
  const [categories, setCategories] = useState<VendorCategory[]>([]);
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
      const res = await fetch(`/api/vendor-categories?${params}`);
      if (!res.ok) throw new Error(`Server error: ${res.status}`);
      const json = await res.json();
      setCategories(json.data || []);
      setTotalPages(json.meta?.totalPages || 1);
      setTotal(json.meta?.total || 0);
    } catch (e: any) {
      setError(e.message || 'Failed to load vendor categories');
    } finally {
      setLoading(false);
    }
  }, [page, search]);

  useEffect(() => { fetchData(); }, [fetchData]);

  const columns: Column<VendorCategory>[] = [
    {
      key: 'category_image',
      label: 'Image',
      render: (row) => (
        row.category_image ? (
          <img src={row.category_image.startsWith('/') || row.category_image.startsWith('http') ? row.category_image : `/uploads/${row.category_image}`} alt={row.category_name} className="w-10 h-10 rounded-lg object-cover" />
        ) : (
          <div className="w-10 h-10 rounded-lg bg-green-100 flex items-center justify-center text-green-700 font-bold">
            {row.category_name?.charAt(0) || 'V'}
          </div>
        )
      )
    },
    { key: 'category_name', label: 'Category Name', render: (row) => <span className="font-semibold text-gray-900 dark:text-white">{row.category_name}</span> },
    { key: 'description', label: 'Description' },
    { key: 'cat_type_id', label: 'Type ID' },
  ];

  const actions: Action<VendorCategory>[] = [
    {
      label: 'Delete',
      icon: <Trash2 size={15} />,
      color: 'danger',
      onClick: async (row) => {
        if (!confirm(`"${row.category_name}" vendor category को delete करें?`)) return;
        await fetch(`/api/vendor-categories/${row._id}`, { method: 'DELETE' });
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
        if (!confirm(`${ids.length} vendor categories delete करें?`)) return;
        await Promise.all(ids.map(id => fetch(`/api/vendor-categories/${id}`, { method: 'DELETE' })));
        fetchData();
      }
    },
  ];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Vendor Categories</h1>
          <p className="text-sm text-gray-500 mt-1">Total: {total} categories</p>
        </div>
        <Link href="/admin/vendor-categories/create">
          <button className="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition shadow-sm font-medium">
            <Plus size={16} /> New Vendor Category
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
          placeholder="Search vendor categories..."
          value={search}
          onChange={(e) => { setSearch(e.target.value); setPage(1); }}
          className="px-4 py-2 border border-gray-300 rounded-lg text-sm w-72 focus:outline-none focus:ring-2 focus:ring-green-500 dark:bg-gray-700 dark:border-gray-600 dark:text-white"
        />
      </div>

      <DataTable
        data={categories}
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
