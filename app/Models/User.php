<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens;

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'address' => 'object',
        'ver_code_send_at' => 'datetime'
    ];


    public function loginLogs()
    {
        return $this->hasMany(UserLogin::class);
    }

    public function deposits()
    {
        return $this->hasMany(Deposit::class)->where('status','!=',0);
    }

    public function coupons()
    {
        return $this->hasMany(Coupon::class);
    }

    public function fullname(): Attribute
    {
        return new Attribute(
            get: fn () => $this->firstname . ' ' . $this->lastname,
        );
    }

    public function accountwallet($type) {

      return $this->hasMany(AccountWallet::class )->where('type' , '=' , $type);

    }



    // SCOPES
    public function scopeActive()
    {
        return $this->where('status', 1);
    }

    public function scopeBanned()
    {
        return $this->where('status', 0);
    }

    public function scopeEmailUnverified()
    {
        return $this->where('ev', 0);
    }

    public function scopeMobileUnverified()
    {
        return $this->where('sv', 0);
    }

    public function scopeEmailVerified()
    {
        return $this->where('ev', 1);
    }

    public function scopeMobileVerified()
    {
        return $this->where('sv', 1);
    }

    public function scopeWithBalance()
    {
        return $this->where('balance','>', 0);
    }

}
