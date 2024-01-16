<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Coupon extends Model
{
    protected $casts = [
        'ending_date' => 'datetime'
    ];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function store()
    {
        return $this->belongsTo(Store::class);
    }

    public function reports()
    {
        return $this->hasMany(CouponReport::class);
    }

    public function scopePending()
    {
        return $this->where('status', 0);
    }

    public function scopeActive()
    {
        return $this->where('status', 1)->where('ending_date', '>', now())->whereHas('store',function($q){
            $q->where('status',1);
        });
    }

    public function scopeInactive()
    {
        return $this->where('status', 2)->where('ending_date', '>', now());
    }

    public function scopeExpired()
    {
        return $this->where(function($query){
            $query->where('status', 1)->orWhere('status', 2);
        })->where('ending_date', '<=', now());
    }

    public function scopeRejected()
    {
        return $this->where('status', 3);
    }

    public function scopeTodayDeal()
    {
        return $this->where('today_deal', 1);
    }

    public function scopeTopDeal()
    {
        return $this->where('top_deal', 1);
    }

}
