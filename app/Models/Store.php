<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Store extends Model
{
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function coupons()
    {
        return $this->hasMany(Coupon::class);
    }

    public function scopeActive()
    {
        return $this->where('status', 1);
    }

    public function scopeFeatured()
    {
        return $this->where('featured', 1);
    }
}
