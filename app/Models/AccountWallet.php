<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AccountWallet extends Model
{
    use HasFactory;

    protected $table = "account_wallets";
    protected $fillable = ['user_id' , 'balance' , 'balance_limit' , 'type'];


}
