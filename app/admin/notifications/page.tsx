"use client";
import React, { useState } from 'react';
import DataTable, { Column } from '../components/DataTable';

interface Notification { id: string; title: string; body: string; sent_to: string; sent_at: string; }

export default function NotificationsPage() {
  const [data, setData] = useState<Notification[]>([
    { id: '1', title: 'Big Sale Today!', body: 'Get 50% off on fresh veggies.', sent_to: 'All Users', sent_at: '2025-11-20 09:00' },
    { id: '2', title: 'System Update', body: 'App will be under maintenance tonight.', sent_to: 'Delivery Boys', sent_at: '2025-11-22 18:00' },
  ]);

  const columns: Column<Notification>[] = [
    { key: 'title', label: 'Title', render: (row) => <span className="font-semibold">{row.title}</span> },
    { key: 'body', label: 'Message Body' },
    { key: 'sent_to', label: 'Audience' },
    { key: 'sent_at', label: 'Sent Date' },
  ];

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div><h1 className="text-2xl font-bold text-gray-900 dark:text-white">Push Notifications</h1><p className="text-sm text-gray-500 mt-1">History of sent notifications</p></div>
        <button className="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 transition-colors shadow-sm">Send Notification</button>
      </div>
      <DataTable data={data} columns={columns} actions={[]} keyExtractor={(row) => row.id} />
    </div>
  );
}
