"use client";

import React, { useEffect, useState, useCallback } from 'react';
import DataTable, { Column, Action, BulkAction } from '../components/DataTable';
import { Trash2, Plus, CheckCircle, XCircle } from 'lucide-react';

interface User {
  _id: string;
  name: string;
  email: string;
  mobile_no: string;
  city?: string;
  wallet_balance: number;
  is_active: string;
}

export default function UsersPage() {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [total, setTotal] = useState(0);
  const [search, setSearch] = useState('');
  const [error, setError] = useState('');
  const limit = 10;

  const fetchData = useCallback(async () => {
    setLoading(true); setError('');
    try {
      const params = new URLSearchParams({ page: String(page), limit: String(limit), search });
      const res = await fetch(`/api/users?${params}`);
      if (!res.ok) throw new Error(`Server error: ${res.status}`);
      const json = await res.json();
      setUsers(json.data || []);
      setTotalPages(json.meta?.totalPages || 1);
      setTotal(json.meta?.total || 0);
    } catch (e: any) { setError(e.message || 'Failed to load users'); }
    finally { setLoading(false); }
  }, [page, search]);

  useEffect(() => { fetchData(); }, [fetchData]);

  const columns: Column<User>[] = [
    { key: 'avatar', label: '', render: (row) => (
      <div className="w-9 h-9 rounded-full bg-indigo-100 flex items-center justify-center text-indigo-700 font-bold text-sm">
        {row.name?.charAt(0) || '?'}
      </div>
    )},
    { key: 'name', label: 'Name', render: (row) => <span className="font-semibold text-gray-900 dark:text-white">{row.name || '-'}</span> },
    { key: 'mobile_no', label: 'Mobile' },
    { key: 'email', label: 'Email' },
    { key: 'wallet_balance', label: 'Wallet', render: (row) => <span className="font-semibold">₹{(row.wallet_balance ?? 0).toFixed(2)}</span> },
    { key: 'is_active', label: 'Status', render: (row) => row.is_active === '1'
      ? <CheckCircle size={18} className="text-green-500" />
      : <XCircle size={18} className="text-red-400" />
    },
  ];

  const actions: Action<User>[] = [
    {
      label: 'Delete', icon: <Trash2 size={15} />, color: 'danger',
      onClick: async (row) => {
        if (!confirm(`"${row.name}" user को delete करें?`)) return;
        await fetch(`/api/users/${row._id}`, { method: 'DELETE' });
        fetchData();
      }
    },
  ];

  const bulkActions: BulkAction[] = [{
    label: 'Delete Selected', icon: <Trash2 size={14} />, color: 'danger',
    onClick: async (ids) => {
      if (!confirm(`${ids.length} users delete करें?`)) return;
      await Promise.all(ids.map(id => fetch(`/api/users/${id}`, { method: 'DELETE' })));
      fetchData();
    }
  }];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Users</h1>
          <p className="text-sm text-gray-500 mt-1">Total: {total} users</p>
        </div>
      </div>
      {error && <div className="p-4 bg-red-50 border border-red-200 text-red-700 rounded-lg text-sm">⚠️ {error} — <button onClick={fetchData} className="underline">Retry</button></div>}
      <div>
        <input type="text" placeholder="Search by name, mobile, email..."
          value={search} onChange={(e) => { setSearch(e.target.value); setPage(1); }}
          className="px-4 py-2 border border-gray-300 rounded-lg text-sm w-72 focus:outline-none focus:ring-2 focus:ring-green-500 dark:bg-gray-700 dark:border-gray-600 dark:text-white" />
      </div>
      <DataTable data={users} columns={columns} actions={actions} bulkActions={bulkActions} keyExtractor={(row) => row._id} loading={loading} />
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
