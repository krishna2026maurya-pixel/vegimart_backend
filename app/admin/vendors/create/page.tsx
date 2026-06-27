"use client";

import React, { useState } from 'react';
import { useRouter } from 'next/navigation';
import { ArrowLeft, Save } from 'lucide-react';
import { FormSection, FullSpan, TextInput, Textarea, Select, Toggle, FileUpload } from '../../components/FormComponents';

const initialState = {
  full_name: '', email: '', mobile_number: '', password: '',
  shop_name: '', shop_category: '', business_type: '', services_coverage: '',
  gst_number: '', pan_number: '', licence_number: '',
  address: '', city: '', state: '', pincode: '', country: '', landmark: '',
  gps_lat: '', gps_long: '', gps_location: '',
  is_verified: false, is_bestseller: false,
  wallet_balance: '0.00', handling_charge: '',
  fiberbase_token: '',
};

export default function CreateVendorPage() {
  const router = useRouter();
  const [form, setForm] = useState(initialState);

  const handleChange = (name: string, value: string | boolean) => {
    setForm(prev => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    alert('Vendor created! (Connect to API to save)');
    router.push('/admin/vendors');
  };

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          <button onClick={() => router.back()} className="p-2 text-gray-500 hover:text-gray-700 hover:bg-gray-100 rounded-lg transition">
            <ArrowLeft size={20} />
          </button>
          <div>
            <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Create Vendor</h1>
            <p className="text-sm text-gray-500">Vendors</p>
          </div>
        </div>
        <div className="flex gap-3">
          <button onClick={() => router.push('/admin/vendors')} className="px-4 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition">
            Cancel
          </button>
          <button onClick={handleSubmit} className="flex items-center gap-2 px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 transition shadow-sm">
            <Save size={16} /> Create
          </button>
        </div>
      </div>

      <form onSubmit={handleSubmit} className="space-y-6">
        {/* Personal Information */}
        <FormSection title="Personal Information" columns={2}>
          <TextInput label="Full Name" name="full_name" value={form.full_name} onChange={handleChange} required />
          <TextInput label="Email" name="email" value={form.email} onChange={handleChange} type="email" />
          <TextInput label="Mobile Number" name="mobile_number" value={form.mobile_number} onChange={handleChange} required />
          <TextInput label="Password" name="password" value={form.password} onChange={handleChange} type="password" required placeholder="Set a password" />
        </FormSection>

        {/* Shop Information */}
        <FormSection title="Shop Information" columns={2}>
          <TextInput label="Shop Name" name="shop_name" value={form.shop_name} onChange={handleChange} />
          <Select label="Shop Category" name="shop_category" value={form.shop_category} onChange={handleChange}
            placeholder="Select category..."
            options={[{ value: '1', label: 'Vegetables' }, { value: '2', label: 'Fruits' }, { value: '3', label: 'Dairy' }]} />
          <TextInput label="Business Type" name="business_type" value={form.business_type} onChange={handleChange} />
          <TextInput label="Services Coverage" name="services_coverage" value={form.services_coverage} onChange={handleChange} />
          <FullSpan>
            <FileUpload label="Shop Image" name="shop_image" helperText="Upload shop photo (JPG, PNG)" />
          </FullSpan>
        </FormSection>

        {/* Business Documents */}
        <FormSection title="Business Documents" columns={2}>
          <TextInput label="GST Number" name="gst_number" value={form.gst_number} onChange={handleChange} />
          <TextInput label="PAN Number" name="pan_number" value={form.pan_number} onChange={handleChange} />
          <TextInput label="Licence Number" name="licence_number" value={form.licence_number} onChange={handleChange} />
          <div /> {/* spacer */}
          <FileUpload label="GST Certificate" name="gst_certificate" accept="image/*,application/pdf" helperText="PDF or Image" />
          <FileUpload label="PAN Card" name="pan_card" accept="image/*,application/pdf" helperText="PDF or Image" />
          <FileUpload label="Aadhar Front" name="aadhar_front" helperText="Front side image" />
          <FileUpload label="Aadhar Back" name="aadhar_back" helperText="Back side image" />
        </FormSection>

        {/* Address Information */}
        <FormSection title="Address Information" columns={2}>
          <FullSpan>
            <Textarea label="Address" name="address" value={form.address} onChange={handleChange} />
          </FullSpan>
          <TextInput label="City" name="city" value={form.city} onChange={handleChange} />
          <TextInput label="State" name="state" value={form.state} onChange={handleChange} />
          <TextInput label="Pincode" name="pincode" value={form.pincode} onChange={handleChange} />
          <TextInput label="Country" name="country" value={form.country} onChange={handleChange} />
          <FullSpan>
            <TextInput label="Landmark" name="landmark" value={form.landmark} onChange={handleChange} />
          </FullSpan>
        </FormSection>

        {/* GPS Location */}
        <FormSection title="GPS Location" columns={2}>
          <TextInput label="GPS Latitude" name="gps_lat" value={form.gps_lat} onChange={handleChange} />
          <TextInput label="GPS Longitude" name="gps_long" value={form.gps_long} onChange={handleChange} />
          <FullSpan>
            <Textarea label="GPS Location Description" name="gps_location" value={form.gps_location} onChange={handleChange} />
          </FullSpan>
          <FullSpan>
            <div className="w-full h-48 bg-gray-200 dark:bg-gray-700 rounded-lg flex items-center justify-center text-gray-500 text-sm">
              📍 Google Map Preview (requires API key)
            </div>
          </FullSpan>
        </FormSection>

        {/* Status & Settings */}
        <FormSection title="Status & Settings" columns={2}>
          <Toggle label="Is Verified" name="is_verified" value={form.is_verified} onChange={handleChange} helperText="Mark this vendor as verified" />
          <Toggle label="Is Bestseller" name="is_bestseller" value={form.is_bestseller} onChange={handleChange} helperText="Feature this vendor as bestseller" />
        </FormSection>

        {/* Financial Information */}
        <FormSection title="Financial Information" columns={2}>
          <TextInput label="Wallet Balance" name="wallet_balance" value={form.wallet_balance} onChange={handleChange} prefix="₹" readOnly />
          <TextInput label="Handling Charge" name="handling_charge" value={form.handling_charge} onChange={handleChange} prefix="₹" type="number" />
        </FormSection>

        {/* System Information */}
        <FormSection title="System Information" columns={1}>
          <TextInput label="Firebase Token" name="fiberbase_token" value={form.fiberbase_token} onChange={handleChange} readOnly placeholder="Auto-populated from mobile app" />
        </FormSection>

        {/* Form Footer */}
        <div className="flex justify-end gap-3 pb-6">
          <button type="button" onClick={() => router.push('/admin/vendors')} className="px-6 py-2 text-sm font-medium text-gray-700 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition">
            Cancel
          </button>
          <button type="submit" className="flex items-center gap-2 px-6 py-2 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 transition shadow-sm">
            <Save size={16} /> Create Vendor
          </button>
        </div>
      </form>
    </div>
  );
}
