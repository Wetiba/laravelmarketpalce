<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Models\GeneralSetting;
use App\Models\Package;
use App\Models\Coupon;
use App\Models\CouponReport;
use App\Models\Store;
use App\Rules\FileTypeValidate;
use Illuminate\Http\Request;

class CouponController extends Controller
{
    public function allCoupons()
    {
        $pageTitle = 'My All Cards';
        $coupons  = Coupon::where('user_id', auth()->id())->with('category', 'store')->latest()->paginate(getPaginate());
        return view($this->activeTemplate.'user.coupon.index', compact('pageTitle', 'coupons'));
    }

    public function pendingCoupons()
    {
        $pageTitle = 'My Pending Cards';
        $coupons = Coupon::pending()->where('user_id', auth()->id())->with('category', 'store')->latest()->paginate(getPaginate());
        return view($this->activeTemplate.'user.coupon.index', compact('pageTitle', 'coupons'));
    }

    public function activeCoupons()
    {
        $pageTitle = 'My Active Cards';
        $coupons = Coupon::active()->where('user_id', auth()->id())->with('category', 'store')->latest()->paginate(getPaginate());
        return view($this->activeTemplate.'user.coupon.index', compact('pageTitle', 'coupons'));
    }

    public function expiredCoupons()
    {
        $pageTitle = 'My Expired Cards';
        $coupons = Coupon::expired()->where('user_id', auth()->id())->with('category', 'store')->latest()->paginate(getPaginate());
        return view($this->activeTemplate.'user.coupon.index', compact('pageTitle', 'coupons'));
    }

    public function rejectedCoupons()
    {
        $pageTitle = 'My Rejected Cards';
        $coupons = Coupon::rejected()->where('user_id', auth()->id())->with('category', 'store')->latest()->paginate(getPaginate());
        return view($this->activeTemplate.'user.coupon.index', compact('pageTitle', 'coupons'));
    }

    public function couponForm($id=0)
    {
        $pageTitle  = ($id ? 'Update' : 'Add').' Cards';
        $categories = Category::where('status', 1)->get();
        $stores = Store::where('user_id', auth()->id())->where('status', 1)->get();
        $coupon = $id ? Coupon::where('user_id', auth()->id())->findOrFail($id) : '';

        return view($this->activeTemplate.'user.coupon.form', compact('pageTitle', 'categories', 'stores', 'coupon'));
    }

    public function saveCoupon(Request $request, $id=0)
    {
        $imgValidation = $id ? 'nullable':'required';
      /*  $request->validate([
            'title'       => 'required|string|max:40',
            'coupon_code' => 'required|string|max:40',
            'category_id' => 'required|integer',
            'ending_date' => 'required|date_format:d-m-Y h:i a|after:yesterday',
            'store_id'    => 'required|integer',
            'url'         => 'required|max:255',
            'cashback'    => 'required|numeric|gt:0',
            'description' => 'required',
            'image'       => ["$imgValidation",'image',new FileTypeValidate(['jpg','jpeg','png'])]
        ]);*/



        $request->validate([
            'title'       => 'required|string|max:40',
            'coupon_code' => 'required|string|max:40',
            'category_id' => 'required|integer',
            'ending_date' => 'required|date_format:d-m-Y h:i a|after:yesterday',
            'store_id'    => 'required|integer',
            'description' => 'required',

        ]);

        $category = Category::where('status', 1)->findOrFail($request->category_id);
        $store = Store::where('user_id', auth()->id())->where('status', 1)->findOrFail($request->store_id);
        $coupon = $id ? Coupon::where('user_id', auth()->id())->findOrFail($id) : new Coupon();
        $filename = $id ? $coupon->image : '';

        if($request->hasFile('image')){
            try{
                $filename = fileUploader($request->image, getFilePath('coupon'), getFileSize('coupon'), $filename);
            } catch(\Exception $e){
                $notify[] = ['error', 'Couldn\'t upload your image'];
                return back()->withNotify($notify);
            }
        }

        $general = GeneralSetting::first();

        $coupon->user_id     = auth()->id();
        $coupon->category_id = $category->id;
        $coupon->store_id    = $store->id;
        $coupon->title       = $request->title;
        $coupon->coupon_code = $request->coupon_code;
        $coupon->ending_date = $request->ending_date;
/*        $coupon->url         = $request->url;*/
/*        $coupon->cashback    = $request->cashback;*/
        $coupon->description = $request->description;
/*        $coupon->image       = $filename;*/
        $coupon->status      = $general->coupon_auto_approve;
        $coupon->save();

        $notification = $id ? 'updated' : 'added';
        $notify[] = ['success', "Cards $notification successfully"];
        return back()->withNotify($notify);
    }

    public function changeStatus($id)
    {
        $coupon = Coupon::where('user_id', auth()->id())->findOrFail($id);

        if($coupon->status != 1 && $coupon->status != 2){
            $notify[] = ['error', 'You can\'t active/inactive this coupon'];
            return back()->withNotify($notify);
        }

        $coupon->status = $coupon->status == 1 ? 2 : 1;
        $coupon->save();

        $notification = $coupon->status == 1 ? 'active' : 'inactive';
        $notify[] = ['success', "Coupon $notification successfully"];
        return back()->withNotify($notify);
    }

    public function boost($couponId)
    {
        $pageTitle = 'Boost Package';
        $coupon = Coupon::where('id', $couponId)->where('user_id', auth()->id())->firstOrFail();

        if($coupon->status != 1 || $coupon->ending_date < now()){
            $notify[] = ['error', 'You can boost only your active card'];
            return back()->withNotify($notify);
        }

        $packages = Package::where('status', 1)->orderBy('price')->latest()->paginate(getPaginate());

        return view($this->activeTemplate.'user.coupon.boost_package', compact('pageTitle', 'couponId', 'packages'));
    }

    public function boostingProcess(Request $request)
    {
        $request->validate([
            'package_id' => 'required|integer|min:1',
            'coupon_id'  => 'required|integer|min:1'
        ]);

        $package = Package::where('id', $request->package_id)->where('status', 1)->firstOrFail();
        Coupon::where('id', $request->coupon_id)->where('user_id', auth()->id())->firstOrFail();

        session()->put('boosting_data', [
            'coupon_id' => $request->coupon_id,
            'package_id' => $package->id,
            'price'      => $package->price
        ]);

        return redirect()->route('user.deposit');
    }

    public function stores()
    {
        $pageTitle    = 'My All Stores';
        $stores = Store::where('user_id', auth()->id())->with('user', 'coupons')->latest()->paginate(getPaginate());
        return view($this->activeTemplate.'user.coupon.store_list', compact('pageTitle', 'stores'));
    }

    public function saveStore(Request $request, $id=0)
    {
        $imgValidation = $id ? 'nullable':'required';
        $request->validate([
            'name'      => 'required|string|max:40',
            'image'     => ["$imgValidation",'image',new FileTypeValidate(['jpg','jpeg','png'])]
        ]);

        $store = new Store();
        $filename = '';
        $notification = 'added';

        if($id){
            $store         = Store::findOrFail($id);
            $store->status = $request->status ? 1 : 0;
            $filename      = $store->image;
            $notification  = 'updated';
        }

        if($request->hasFile('image')){
            try{
                $filename = fileUploader($request->image, getFilePath('store'), null, $filename);
            } catch(\Exception $e){
                $notify[] = ['error', 'Couldn\'t upload your image'];
                return back()->withNotify($notify);
            }
        }

        $store->user_id   = auth()->id();
        $store->name      = $request->name;
        $store->image     = $filename;
        $store->save();

        $notify[] = ['success', "Store $notification successfully"];
        return back()->withNotify($notify);
    }

    public function viewReport($id)
    {
        $pageTitle = 'Coupon Reports';
        $coupon = Coupon::where('id', $id)->where('user_id', auth()->id())->with([
            'reports'=>function($query){
                $query->where('created_at', '>=', now()->subDays(30));
            }
        ])->firstOrFail();

        $couponReport['date'] = collect([]);
        $impression = $this->couponReport('impression',$coupon->id);

        $impression->map(function ($reportData) use ($couponReport) {
            $couponReport['date']->push($reportData->date);
        });

        $click =$this->couponReport('click',$coupon->id);

        $click->map(function ($reportData) use ($couponReport) {
            $couponReport['date']->push($reportData->date);
        });

        $copy = $this->couponReport('copy',$coupon->id);

        $copy->map(function ($reportData) use ($couponReport) {
            $couponReport['date']->push($reportData->date);
        });

        $couponReport['date'] = dateSorting($couponReport['date']->unique()->toArray());

        return view($this->activeTemplate.'user.coupon.report', compact('pageTitle', 'coupon', 'couponReport', 'impression', 'click', 'copy'));
    }

    private function couponReport($type,$couponId){
        return CouponReport::where('coupon_id', $couponId)
                ->where('action', $type)->where('created_at', '>=', now()->subDays(30))
                ->selectRaw("SUM(number) as amount, date")
                ->orderBy('created_at')
                ->groupBy('date')
                ->get();
    }
}
