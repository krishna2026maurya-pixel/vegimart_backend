"use client";
import React from 'react';
import { Shield, User } from 'lucide-react';
export default function AdminsPage() {
  const admins = [
    { id: 1, name: 'UdayBharat', email: 'admin@admin.com', mobile: '6396063416', type: 'admin', is_active: true, created_at: '2025-11-25' },
    { id: 3, name: 'Sanjay', email: 'sanjay383@gmail.com', mobile: '6390583448', type: 'admin', is_active: true, created_at: '2025-11-25' },
  ];
  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div><h1 className="text-2xl font-bold text-gray-900 dark:text-white">Admins</h1><p className="text-sm text-gray-500 mt-1">{admins.length} admin users</p></div>
      </div>
      <div className="bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 overflow-hidden">
        <table className="w-full text-sm">
          <thead className="bg-gray-50 dark:bg-gray-700 text-xs uppercase text-gray-600 dark:text-gray-300">
            <tr>
              <th className="px-6 py-3 text-left">Admin</th>
              <th className="px-6 py-3 text-left">Mobile</th>
              <th className="px-6 py-3 text-left">Type</th>
              <th className="px-6 py-3 text-left">Status</th>
              <th className="px-6 py-3 text-left">Created</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-100 dark:divide-gray-700">
            {admins.map(admin => (
              <tr key={admin.id} className="hover:bg-gray-50 dark:hover:bg-gray-700/50">
                <td className="px-6 py-4">
                  <div className="flex items-center gap-3">
                    <div className="w-9 h-9 rounded-full bg-indigo-100 flex items-center justify-center text-indigo-700 font-bold">{admin.name.charAt(0)}</div>
                    <div><p className="font-semibold text-gray-900 dark:text-white">{admin.name}</p><p className="text-xs text-gray-500">{admin.email}</p></div>
                  </div>
                </td>
                <td className="px-6 py-4 text-gray-600 dark:text-gray-400">{admin.mobile}</td>
                <td className="px-6 py-4"><span className="px-2 py-1 bg-indigo-100 text-indigo-800 rounded-full text-xs font-semibold capitalize">{admin.type}</span></td>
                <td className="px-6 py-4"><span className={`px-2.5 py-1 rounded-full text-xs font-semibold ${admin.is_active ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>{admin.is_active ? 'Active' : 'Inactive'}</span></td>
                <td className="px-6 py-4 text-gray-500 text-xs">{admin.created_at}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
