"use client";
import React, { useState } from 'react';
import DataTable, { Column } from '../components/DataTable';

interface DeliveryTx { id: string; delivery_boy_name: string; order_id: string; amount: number; type: string; created_at: string; }

export default function DeliveryTransactionsPage() {
  const [data, setData] = useState<DeliveryTx[]>([
    { id: '1', delivery_boy_name: 'Raj', order_id: 'ORD-12345', amount: 30, type: 'credit', created_at: '2025-11-25 10:30' },
    { id: '2', delivery_boy_name: 'Amit', order_id: 'ORD-12346', amount: 50, type: 'credit', created_at: '2025-11-25 11:15' },
  ]);

  const columns: Column<DeliveryTx>[] = [
    { key: 'delivery_boy_name', label: 'Delivery Boy', render: (row) => <span className="font-semibold">{row.delivery_boy_name}</span> },
    { key: 'order_id', label: 'Order ID' },
    { key: 'amount', label: 'Amount', render: (row) => <span className={row.type === 'credit' ? 'text-green-600 font-semibold' : 'text-red-600 font-semibold'}>
      {row.type === 'credit' ? '+' : '-'}₹{row.amount}
    </span> },
    { key: 'type', label: 'Type', render: (row) => <span className="uppercase text-xs font-semibold">{row.type}</span> },
    { key: 'created_at', label: 'Date/Time' },
  ];

  return (
    <div className="space-y-6">
      <div><h1 className="text-2xl font-bold text-gray-900 dark:text-white">Delivery Transactions</h1><p className="text-sm text-gray-500 mt-1">Wallet transactions for delivery boys</p></div>
      <DataTable data={data} columns={columns} actions={[]} keyExtractor={(row) => row.id} />
    </div>
  );
}
