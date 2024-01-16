<?php

namespace App\Http\Controllers\User\Customer;

use App\Http\Controllers\Controller;
use App\Models\AccountTransaction;
use App\Models\AffiliateCoupons;
use App\Models\Coupon;
use App\Models\User;
use App\Models\Voucher;
use GuzzleHttp\Promise\Create;
use Illuminate\Http\Request;

class CustomerController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //


        $pageTitle = 'Customer Account';
        $transactions = AccountTransaction::where('type', 'customer')->orderBy('created_at', 'asc')->where('user_id', \Auth::user()->id)->paginate(10);
        $vouchers = Voucher::where('user_id', auth()->id())->orderBy('created_at', 'asc')->get();
        $affiliateCoupons = AffiliateCoupons::where('user_id' , auth()->id())->paginate(3);
        return view($this->activeTemplate . 'user.customer.index', compact('pageTitle' , 'transactions' , 'vouchers' , 'affiliateCoupons' ));

    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }


    public function addCoupon(Request $request){

        $request->validate([
               'coupon_code' => 'required|string'
            ]);

        if (!$coupon = Coupon::query()->where('coupon_code', '=' , $request->coupon_code)->get() ) {

            $notify[] = ['error','Coupon no exists'];
            return back()->withNotify($notify);

        }elseif ($coupon[0]->current_use >= $coupon[0]->quantity_to_use){


            $notify[] = ['error','Coupon over the limit'];
            return back()->withNotify($notify);

        }elseif (AffiliateCoupons::query()->where('user_id' , '=' , auth()->id())->where('coupon_id' , '=' , $coupon[0]->id)->exists()){

            $notify[] = ['error','Coupon is already in your list'];
            return back()->withNotify($notify);

        }

        $affiliate = AffiliateCoupons::query()->create([ 'user_id' => auth()->id() , 'coupon_id' => $coupon[0]->id ]);

        $affiliate->coupon->current_use ++;
        $affiliate->save();

        $notify[] = ['Success','Coupon was added successfully.'];
        return back()->withNotify($notify);


    }

    public function addVoucher(Request $request){

        $request->validate([
               'file' => 'required|string',
               'coupon_code' => 'required'
            ]);



        $notify[] = ['Success','Coupon was added successfully.'];
        return back()->withNotify($notify);


    }

    public function notifyVoucher($voucher){



    }


}
