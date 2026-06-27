"use client";

import React, { useEffect, useState, useCallback } from 'react';
import DataTable, { Column, Action, BulkAction } from '../components/DataTable';
import { Edit, Eye, Trash2, CheckCircle, XCircle, UserCheck, Plus } from 'lucide-react';
import Link from 'next/link';

interface Vendor {
  _id: string;
  full_name: string;
  email: string;
  mobile_number: string;
  shop_name: string;
  is_verified: string;
  is_bestseller: string;
  wallet_balance: number;
  created_at: string;
  city: string;
}

export default function VendorsPage() {
  const [vendors, setVendors] = useState<Vendor[]>([]);
  const [loading, setLoading] = useState(true);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [total, setTotal] = useState(0);
  const [search, setSearch] = useState('');
  const [error, setError] = useState('');
  const limit = 10;

  const fetchVendors = useCallback(async () => {
    setLoading(true);
    setError('');
    try {
      const params = new URLSearchParams({ page: String(page), limit: String(limit), search });
      const res = await fetch(`/api/vendors?${params}`);
      if (!res.ok) throw new Error(`Server error: ${res.status}`);
      const json = await res.json();
      setVendors(json.data || []);
      setTotalPages(json.meta?.totalPages || 1);
      setTotal(json.meta?.total || 0);
    } catch (e: any) {
      setError(e.message || 'Failed to load vendors');
    } finally {
      setLoading(false);
    }
  }, [page, search]);

  useEffect(() => { fetchVendors(); }, [fetchVendors]);

  const toggleVerify = async (vendor: Vendor) => {
    try {
      const newVal = vendor.is_verified === '1' ? '0' : '1';
      const res = await fetch(`/api/vendors/${vendor._id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ is_verified: newVal }),
      });
      if (!res.ok) throw new Error('Update failed');
      fetchVendors();
    } catch (e: any) {
      alert(e.message);
    }
  };

  const deleteVendor = async (vendor: Vendor) => {
    if (!confirm(`"${vendor.shop_name}" को delete करें?`)) return;
    try {
      const res = await fetch(`/api/vendors/${vendor._id}`, { method: 'DELETE' });
      if (!res.ok) throw new Error('Delete failed');
      fetchVendors();
    } catch (e: any) {
      alert(e.message);
    }
  };

  const columns: Column<Vendor>[] = [
    {
      key: 'shop_image',
      label: 'Shop',
      render: (row) => (
        <div className="w-9 h-9 rounded-full bg-green-100 flex items-center justify-center text-green-700 font-bold text-sm">
          {row.shop_name?.charAt(0) || '?'}
        </div>
      )
    },
    { key: 'full_name', label: 'Full Name' },
    { key: 'mobile_number', label: 'Mobile' },
    { key: 'shop_name', label: 'Shop Name' },
    { key: 'city', label: 'City' },
    {
      key: 'wallet_balance',
      label: 'Wallet',
      render: (row) => <span className="font-semibold">₹{(row.wallet_balance ?? 0).toFixed(2)}</span>
    },
    {
      key: 'is_verified',
      label: 'Verified',
      render: (row) => row.is_verified === '1'
        ? <CheckCircle size={18} className="text-green-500" />
        : <XCircle size={18} className="text-red-400" />
    },
    {
      key: 'is_bestseller',
      label: 'Bestseller',
      render: (row) => row.is_bestseller === '1'
        ? <CheckCircle size={18} className="text-green-500" />
        : <XCircle size={18} className="text-gray-300" />
    }
  ];

  const actions: Action<Vendor>[] = [
    {
      label: 'View',
      icon: <Eye size={15} />,
      onClick: (row) => window.open(`/admin/vendors/${row._id}`, '_blank'),
      color: 'default'
    },
    {
      label: 'Toggle Verify',
      icon: <UserCheck size={15} />,
      onClick: toggleVerify,
      color: 'success'
    },
    {
      label: 'Delete',
      icon: <Trash2 size={15} />,
      onClick: deleteVendor,
      color: 'danger'
    }
  ];

  const bulkActions: BulkAction[] = [
    {
      label: 'Delete Selected',
      icon: <Trash2 size={14} />,
      onClick: async (ids) => {
        if (!confirm(`${ids.length} vendors delete करें?`)) return;
        await Promise.all(ids.map(id => fetch(`/api/vendors/${id}`, { method: 'DELETE' })));
        fetchVendors();
      },
      color: 'danger'
    }
  ];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Vendors</h1>
          <p className="text-sm text-gray-500 mt-1">Total: {total} vendors</p>
        </div>
        <Link href="/admin/vendors/create">
          <button className="flex items-center gap-2 px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition-colors shadow-sm font-medium">
            <Plus size={16} />
            New Vendor
          </button>
        </Link>
      </div>

      {error && (
        <div className="p-4 bg-red-50 border border-red-200 text-red-700 rounded-lg text-sm">
          ⚠️ {error} — <button onClick={fetchVendors} className="underline">Retry</button>
        </div>
      )}

      {/* Search */}
      <div className="flex gap-2">
        <input
          type="text"
          placeholder="Search by name, mobile, shop..."
          value={search}
          onChange={(e) => { setSearch(e.target.value); setPage(1); }}
          className="px-4 py-2 border border-gray-300 rounded-lg text-sm w-72 focus:outline-none focus:ring-2 focus:ring-green-500 dark:bg-gray-700 dark:border-gray-600 dark:text-white"
        />
      </div>

      <DataTable
        data={vendors}
        columns={columns}
        actions={actions}
        bulkActions={bulkActions}
        keyExtractor={(row) => row._id}
        loading={loading}
      />

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between">
          <span className="text-sm text-gray-500">Page {page} of {totalPages}</span>
          <div className="flex gap-2">
            <button
              onClick={() => setPage(p => Math.max(1, p - 1))}
              disabled={page === 1}
              className="px-3 py-1.5 text-sm border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40"
            >
              ← Prev
            </button>
            <button
              onClick={() => setPage(p => Math.min(totalPages, p + 1))}
              disabled={page === totalPages}
              className="px-3 py-1.5 text-sm border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-40"
            >
              Next →
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
