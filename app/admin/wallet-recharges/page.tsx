"use client";
import React, { useState } from 'react';
import DataTable, { Column } from '../components/DataTable';

interface WalletRecharge { id: string; user_name: string; amount: number; transaction_id: string; status: string; date: string; }

export default function WalletRechargesPage() {
  const [data, setData] = useState<WalletRecharge[]>([
    { id: '1', user_name: 'Rahul', amount: 500, transaction_id: 'TXN12345678', status: 'success', date: '2025-11-20' },
    { id: '2', user_name: 'Priya', amount: 1000, transaction_id: 'TXN87654321', status: 'pending', date: '2025-11-21' },
  ]);

  const columns: Column<WalletRecharge>[] = [
    { key: 'user_name', label: 'User Name', render: (row) => <span className="font-semibold">{row.user_name}</span> },
    { key: 'amount', label: 'Amount', render: (row) => <span>₹{row.amount}</span> },
    { key: 'transaction_id', label: 'Transaction ID', render: (row) => <span className="font-mono text-sm">{row.transaction_id}</span> },
    { key: 'status', label: 'Status', render: (row) => (
      <span className={`px-2.5 py-1 rounded-full text-xs font-semibold ${
        row.status === 'success' ? 'bg-green-100 text-green-800' :
        row.status === 'failed' ? 'bg-red-100 text-red-800' : 'bg-yellow-100 text-yellow-800'
      }`}>{row.status.toUpperCase()}</span>
    )},
    { key: 'date', label: 'Date' },
  ];

  return (
    <div className="space-y-6">
      <div><h1 className="text-2xl font-bold text-gray-900 dark:text-white">Wallet Recharges</h1><p className="text-sm text-gray-500 mt-1">History of user wallet top-ups</p></div>
      <DataTable data={data} columns={columns} actions={[]} keyExtractor={(row) => row.id} />
    </div>
  );
}
