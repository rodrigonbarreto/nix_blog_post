<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    public function run(): void
    {
        Product::insert([
            ['name' => 'Mechanical Keyboard', 'description' => 'Cherry MX Brown switches', 'price' => 89.99, 'sku' => 'KB-001', 'active' => true, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'USB-C Hub', 'description' => '7-in-1 with HDMI and ethernet', 'price' => 45.00, 'sku' => 'HUB-002', 'active' => true, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Monitor Light Bar', 'description' => 'LED lamp for your monitor', 'price' => 59.99, 'sku' => 'MLB-003', 'active' => true, 'created_at' => now(), 'updated_at' => now()],
            ['name' => 'Webcam Cover', 'description' => 'Sliding privacy cover', 'price' => 4.99, 'sku' => 'WC-004', 'active' => false, 'created_at' => now(), 'updated_at' => now()],
        ]);
    }
}
