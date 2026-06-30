"use client";
import React, { useEffect, useState, useCallback } from 'react';
import DataTable, { Column } from '../components/DataTable';
import { Search } from 'lucide-react';

interface AbandonedCart {
  _id: string;
  user_name: string;
  user_mobile: string;
  items_count: number;
  total_value: number;
  updated_at: string;
}

export default function AbandonedCartsPage() {
  const [data, setData] = useState<AbandonedCart[]>([]);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [search, setSearch] = useState('');
  const [error, setError] = useState('');
  const limit = 10;

  const fetchData = useCallback(async () => {
    setLoading(true);
    setError('');
    try {
      const params = new URLSearchParams({
        page: String(page),
        limit: String(limit),
        search: search
      });
      const res = await fetch(`/api/abandoned-carts?${params}`);
      const json = await res.json();
      if (!res.ok) throw new Error(json.error);

      setData(json.data || []);
      setTotalPages(json.meta?.totalPages || 1);
    } catch (e: any) {
      setError(e.message);
    } finally {
      setLoading(false);
    }
  }, [page, search]);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  const columns: Column<AbandonedCart>[] = [
    { key: 'user_name', label: 'User Name', render: (row) => <span className="font-semibold">{row.user_name}</span> },
    { key: 'user_mobile', label: 'Mobile' },
    { key: 'items_count', label: 'Items' },
    { key: 'total_value', label: 'Total Value', render: (row) => <span>₹{row.total_value.toFixed(2)}</span> },
    { key: 'updated_at', label: 'Last Updated', render: (row) => <span>{new Date(row.updated_at).toLocaleString()}</span> },
  ];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Abandoned Carts</h1>
          <p className="text-sm text-gray-500 mt-1">Users who left items in cart</p>
        </div>
      </div>

      {error && <div className="p-4 bg-red-50 border border-red-200 text-red-700 rounded-lg text-sm">⚠️ {error}</div>}

      <div className="flex items-center gap-3">
        <div className="relative">
          <Search className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" size={18} />
          <input
            type="text"
            placeholder="Search by name or mobile..."
            value={search}
            onChange={(e) => { setSearch(e.target.value); setPage(1); }}
            className="pl-10 pr-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-700 text-sm focus:outline-none focus:ring-2 focus:ring-green-500 w-64 md:w-80 shadow-sm"
          />
        </div>
      </div>

      <DataTable
        data={data}
        columns={columns}
        actions={[]}
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
