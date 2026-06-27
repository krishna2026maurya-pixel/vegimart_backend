"use client";

import React, { useState } from 'react';

// ─── Section Wrapper ─────────────────────────────────────
export function FormSection({ title, children, columns = 2 }: { title: string; children: React.ReactNode; columns?: 1 | 2 | 3 | 4 }) {
  const colClass = { 1: 'grid-cols-1', 2: 'grid-cols-1 md:grid-cols-2', 3: 'grid-cols-1 md:grid-cols-3', 4: 'grid-cols-1 md:grid-cols-4' }[columns];
  return (
    <div className="bg-white dark:bg-gray-800 rounded-xl shadow-sm border border-gray-200 dark:border-gray-700 overflow-hidden">
      <div className="px-6 py-4 border-b border-gray-200 dark:border-gray-700 bg-gray-50 dark:bg-gray-800/60">
        <h3 className="text-sm font-semibold text-gray-800 dark:text-gray-200 uppercase tracking-wide">{title}</h3>
      </div>
      <div className={`p-6 grid gap-5 ${colClass}`}>
        {children}
      </div>
    </div>
  );
}

export function FullSpan({ children }: { children: React.ReactNode }) {
  return <div className="col-span-full">{children}</div>;
}

interface TextInputProps {
  label: string; name: string; value: string;
  onChange: (name: string, value: string) => void;
  required?: boolean; placeholder?: string; type?: string;
  prefix?: string; suffix?: string; readOnly?: boolean;
}

export function TextInput({ label, name, value, onChange, required, placeholder, type = 'text', prefix, suffix, readOnly }: TextInputProps) {
  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      <div className="relative flex items-center">
        {prefix && <span className="absolute left-3 text-gray-500 text-sm z-10">{prefix}</span>}
        <input
          type={type} name={name} value={value}
          onChange={(e) => onChange(name, e.target.value)}
          readOnly={readOnly} placeholder={placeholder}
          className={`w-full border border-gray-300 dark:border-gray-600 rounded-lg py-2 text-sm bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-green-500 transition ${prefix ? 'pl-8' : 'pl-3'} ${suffix ? 'pr-8' : 'pr-3'} ${readOnly ? 'bg-gray-50 dark:bg-gray-600 cursor-not-allowed' : ''}`}
        />
        {suffix && <span className="absolute right-3 text-gray-500 text-sm">{suffix}</span>}
      </div>
    </div>
  );
}

interface TextareaProps {
  label: string; name: string; value: string;
  onChange: (name: string, value: string) => void;
  rows?: number; required?: boolean; placeholder?: string;
}

export function Textarea({ label, name, value, onChange, rows = 3, required, placeholder }: TextareaProps) {
  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      <textarea name={name} value={value} rows={rows}
        onChange={(e) => onChange(name, e.target.value)} placeholder={placeholder}
        className="w-full border border-gray-300 dark:border-gray-600 rounded-lg px-3 py-2 text-sm bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-green-500 transition resize-none"
      />
    </div>
  );
}

interface SelectProps {
  label: string; name: string; value: string;
  onChange: (name: string, value: string) => void;
  options: { value: string; label: string }[];
  required?: boolean; placeholder?: string;
}

export function Select({ label, name, value, onChange, options, required, placeholder }: SelectProps) {
  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      <select name={name} value={value} onChange={(e) => onChange(name, e.target.value)}
        className="w-full border border-gray-300 dark:border-gray-600 rounded-lg px-3 py-2 text-sm bg-white dark:bg-gray-700 text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-green-500 transition">
        {placeholder && <option value="">{placeholder}</option>}
        {options.map((opt) => <option key={opt.value} value={opt.value}>{opt.label}</option>)}
      </select>
    </div>
  );
}

interface ToggleProps {
  label: string; name: string; value: boolean;
  onChange: (name: string, value: boolean) => void; helperText?: string;
}

export function Toggle({ label, name, value, onChange, helperText }: ToggleProps) {
  return (
    <div className="flex items-start gap-3 py-2">
      <button type="button" role="switch" aria-checked={value}
        onClick={() => onChange(name, !value)}
        className={`relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none focus:ring-2 focus:ring-green-500 focus:ring-offset-2 mt-0.5 ${value ? 'bg-green-500' : 'bg-gray-200 dark:bg-gray-600'}`}>
        <span className={`pointer-events-none inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out ${value ? 'translate-x-5' : 'translate-x-0'}`} />
      </button>
      <div>
        <p className="text-sm font-medium text-gray-700 dark:text-gray-300">{label}</p>
        {helperText && <p className="text-xs text-gray-500">{helperText}</p>}
      </div>
    </div>
  );
}

interface FileUploadProps { label: string; name: string; accept?: string; helperText?: string; required?: boolean; }

export function FileUpload({ label, name, accept = 'image/*', helperText, required }: FileUploadProps) {
  const [preview, setPreview] = useState<string | null>(null);
  return (
    <div>
      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">
        {label} {required && <span className="text-red-500">*</span>}
      </label>
      {preview && (
        <div className="relative mb-2">
          <img src={preview} alt="Preview" className="w-full max-h-40 object-contain rounded-lg border border-gray-200" />
          <button type="button" onClick={() => setPreview(null)} className="absolute top-1 right-1 text-xs bg-red-600 text-white px-2 py-0.5 rounded">Remove</button>
        </div>
      )}
      <label className="flex flex-col items-center justify-center w-full h-24 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 dark:bg-gray-700 dark:border-gray-600 dark:hover:bg-gray-600 transition">
        <svg className="w-6 h-6 mb-1 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" /></svg>
        <p className="text-xs text-gray-500">Click to upload</p>
        {helperText && <p className="text-xs text-gray-400">{helperText}</p>}
        <input type="file" name={name} accept={accept} onChange={(e) => { const f = e.target.files?.[0]; if (f) setPreview(URL.createObjectURL(f)); }} className="hidden" />
      </label>
    </div>
  );
}
