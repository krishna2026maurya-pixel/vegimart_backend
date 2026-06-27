"use client";

import React, { useEffect, useState, useCallback } from 'react';
import DataTable, { Column, Action, BulkAction } from '../components/DataTable';
import { Trash2, Plus } from 'lucide-react';
import Link from 'next/link';

interface Brand {
  _id: string;
  name: string;
  logo?: string;
  is_active: string;
}

export default function BrandsPage() {
  const [brands, setBrands] = useState<Brand[]>([]);
  const [loading, setLoading] = useState(true);
  const [total, setTotal] = useState(0);
  const [search, setSearch] = useState('');
  const [error, setError] = useState('');

  const fetchData = useCallback(async () => {
    setLoading(true); setError('');
    try {
      const params = new URLSearchParams({ search });
      const res = await fetch(`/api/brands?${params}`);
      if (!res.ok) throw new Error(`Server error: ${res.status}`);
      const json = await res.json();
      setBrands(json.data || []);
      setTotal(json.meta?.total || 0);
    } catch (e: any) { setError(e.message || 'Failed to load brands'); }
    finally { setLoading(false); }
  }, [search]);

  useEffect(() => { fetchData(); }, [fetchData]);

  const columns: Column<Brand>[] = [
    {
      key: 'logo', label: 'Logo',
      render: (row) => row.logo
        ? <img src={row.logo} alt={row.name} className="w-10 h-10 rounded-full object-cover" />
        : <div className="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center text-blue-700 font-bold">{row.name?.charAt(0) || 'B'}</div>
    },
    { key: 'name', label: 'Brand Name', render: (row) => <span className="font-semibold text-gray-900 dark:text-white">{row.name}</span> },
    {
      key: 'is_active', label: 'Status',
      render: (row) => (
        <span className={`px-2.5 py-1 rounded-full text-xs font-semibold ${row.is_active === '1' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>
          {row.is_active === '1' ? 'Active' : 'Inactive'}
        </span>
      )
    },
  ];

  const actions: Action<Brand>[] = [
    {
      label: 'Delete', icon: <Trash2 size={15} />, color: 'danger',
      onClick: async (row) => {
        if (!confirm(`"${row.name}" को delete करें?`)) return;
        await fetch(`/api/brands/${row._id}`, { method: 'DELETE' });
        fetchData();
      }
    },
  ];

  const bulkActions: BulkAction[] = [{
    label: 'Delete Selected', icon: <Trash2 size={14} />, color: 'danger',
    onClick: async (ids) => {
      if (!confirm(`${ids.length} brands delete करें?`)) return;
      await Promise.all(ids.map(id => fetch(`/api/brands/${id}`, { method: 'DELETE' })));
      fetchData();
    }
  }];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Brand List</h1>
          <p className="text-sm text-gray-500 mt-1">Total: {total} brands</p>
        </div>
        <Link href="/admin/brands/create">
          <button className="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition shadow-sm font-medium">
            <Plus size={16} /> New Brand
          </button>
        </Link>
      </div>
      {error && <div className="p-4 bg-red-50 border border-red-200 text-red-700 rounded-lg text-sm">⚠️ {error} — <button onClick={fetchData} className="underline">Retry</button></div>}
      <div>
        <input type="text" placeholder="Search brands..." value={search} onChange={(e) => setSearch(e.target.value)}
          className="px-4 py-2 border border-gray-300 rounded-lg text-sm w-72 focus:outline-none focus:ring-2 focus:ring-green-500 dark:bg-gray-700 dark:border-gray-600 dark:text-white" />
      </div>
      <DataTable data={brands} columns={columns} actions={actions} bulkActions={bulkActions} keyExtractor={(row) => row._id} loading={loading} />
    </div>
  );
}
