<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Category;
use App\Models\FeaturePackage;
use App\Models\Package;
use App\Models\Coupon;
use App\Models\Store;
use App\Rules\FileTypeValidate;
use Illuminate\Http\Request;
use Intervention\Image\Facades\Image;

class ManageCouponController extends Controller
{

    protected $pageTitle = 'All Coupons';
    protected $view = 'admin.coupon.index';
    protected $coupons = null;

    protected $storeView = 'admin.coupon.stores';
    protected $stores = null;

    public function allCoupons($store = null)
    {
        $data = $this->filterCoupons(null, $store);
        return view($this->view, $data);
    }

    public function pendingCoupons()
    {
        $data = $this->filterCoupons('pending');
        return view($this->view, $data);
    }

    public function activeCoupons()
    {
        $data = $this->filterCoupons('active');
        return view($this->view, $data);
    }

    public function expiredCoupons()
    {
        $data = $this->filterCoupons('expired');
        return view($this->view, $data);
    }

    public function rejectedCoupons()
    {
        $data = $this->filterCoupons('rejected');
        return view($this->view, $data);
    }

    public function todayDeal()
    {
        $data = $this->filterCoupons('todayDeal');
        return view($this->view, $data);
    }

    public function topDeal()
    {
        $data = $this->filterCoupons('topDeal');
        return view($this->view, $data);
    }

    protected function filterCoupons($scope = null, $store = null)
    {
        $coupons = Coupon::query();
        if ($scope) {
            $coupons = Coupon::$scope();
            $this->pageTitle = ucfirst($scope) . ' Coupons';
        }

        $searchKey = request()->search;

        if ($searchKey) {
            $coupons = $coupons->where(function ($query) use ($searchKey) {
                $query->where('title', 'like', "%$searchKey%")
                    ->orWhereHas('category', function ($category) use ($searchKey) {
                        $category->where('name', 'like', "%$searchKey%");
                    })->orWhereHas('store', function ($store) use ($searchKey) {
                        $store->where('name', 'like', "%$searchKey%");
                    })->orWhereHas('user', function ($user) use ($searchKey) {
                        $user->where('username', 'like', "%$searchKey%");
                    });
            });
        }

        if ($store) {
            $coupons = $coupons->where('store_id', $store);
        }

        $coupons = $coupons->with('user', 'category', 'store')->latest()->paginate(getPaginate());

        $data['coupons'] = $coupons;
        $data['pageTitle'] = $this->pageTitle;

        return $data;
    }

    public function couponForm($id = 0)
    {
        $pageTitle = ($id ? 'Update' : 'Add') . ' Coupon';
        $categories = Category::where('status', 1)->get();
        $coupon = $id ? Coupon::findOrFail($id) : '';
        $stores = Store::where('status', 1)->orderBy('user_id')->get();

        return view('admin.coupon.coupon_form', compact('pageTitle', 'categories', 'coupon', 'stores'));
    }

    public function saveCoupon(Request $request, $id = 0)
    {
        $imgValidation = $id ? 'nullable' : 'required';
        $request->validate([
            'title' => 'required|string|max:255',
            'category_id' => 'required|integer',
            'store_id' => 'required|integer|exists:stores,id',
            'coupon_code' => 'required|string|max:40',
            'ending_date' => 'required|date',
            'cashback' => 'required|numeric|gt:0',
            'url' => 'required|max:255',
            "store_id" => 'required|string|max:40',
            'description' => 'required',
            'image' => ["$imgValidation", 'image', new FileTypeValidate(['jpg', 'jpeg', 'png'])],
        ]);

        $coupon = new Coupon();
        $notification = 'added';

        if ($id) {
            $coupon = Coupon::findOrFail($id);
            $coupon->status = $request->status ? 1 : 2;
            $notification = 'updated';
        }

        if ($request->hasFile('image')) {
            try {
                $old = $coupon->image;
                $coupon->image = fileUploader($request->image, getFilePath('coupon'), getFileSize('coupon'), $old);
            } catch (\Exception$e) {
                $notify[] = ['error', 'Couldn\'t upload your image'];
                return back()->withNotify($notify);
            }
        }

        $coupon->title = $request->title;
        $coupon->category_id = $request->category_id;
        $coupon->store_id = $request->store_id;
        $coupon->coupon_code = $request->coupon_code;
        $coupon->ending_date = $request->ending_date;
        $coupon->cashback = $request->cashback;
        $coupon->url = $request->url;
        $coupon->description = $request->description;
        $coupon->today_deal = $request->today_deal ? 1 : 0;
        $coupon->top_deal = $request->top_deal ? 1 : 0;
        $coupon->save();

        $notify[] = ['success', "Coupon $notification successfully"];
        return back()->withNotify($notify);

    }

    public function changeStatus(Request $request)
    {
        $request->validate([
            'action' => 'required|in:1,3',
            'coupon_id' => 'required|integer|min:1'
        ]);

        $coupon = Coupon::findOrFail($request->coupon_id);
        $coupon->status = $request->action;
        $coupon->reason = $request->reason;
        $coupon->save();

        $notification = $request->action == 1 ? 'approved' : 'rejected';
        $notify[] = ['success', "Coupon $notification successfully"];
        return back()->withNotify($notify);

    }

    public function packages()
    {
        $pageTitle = 'All Package';
        $packages = Package::latest()->paginate(getPaginate());
        $categories = Category::paginate(getPaginate());

        return view('admin.coupon.packages', compact('pageTitle', 'packages', 'categories'));
    }

    public function savePackage(Request $request, $id = 0)
    {

        $imgValidation = $id ? 'nullable' : 'required';

        $request->validate([
            'name' => 'required|max:40',
            'sub_heading' => 'required|max:500',
            'duration' => 'required|integer|min:1',
            'price' => 'required|numeric|gt:0',
            'quantity_coupon_use' => 'required|numeric|min:1',
            'image' => ["$imgValidation", 'image', new FileTypeValidate(['jpg', 'jpeg', 'png'])],
        ]);




        $package = new Package();
        $notification = 'added';

        if ($id) {
            $package = Package::findOrFail($id);
            $package->status = $request->status ? 1 : 0;
            $oldImage =   $package->image;
            $notification = 'updated';
        }


        if ($request->hasFile('image')) {
            try {
                $old = $package->image;
                $package->image = fileUploader($request->image, getFilePath('coupon'), '', $old);
            } catch (\Exception$e) {
                $notify[] = ['error', 'Couldn\'t upload your image'];
                return back()->withNotify($notify);
            }
        }


        $package->name = $request->name;
        $package->sub_heading = $request->sub_heading;
        $package->duration = $request->duration;
        $package->price = $request->price;
        $package->quantity_coupon_use = $request->quantity_coupon_use;
        $package->save();

        $notify[] = ['success', "Package $notification successfully"];
        return back()->withNotify($notify);
    }

    public function getFeateruresPackage($package)
    {

        $current = Package::query()->findOrFail($package);
        $pageTitle = 'Package ' . $current['name'] . ': Add features';
        $features = $current->feature;
        $idPackage = $current->id;

        return view('admin.coupon.features_package', compact('idPackage', 'features', 'pageTitle'));

    }

    public function saveFeaturePackagage(Request $request, $id = 0)
    {

        $request->validate([
            'feature' => 'required|max:500'
        ]);

        $feature = new FeaturePackage();
        $notification = "Added";

        if ($id) {
            $feature = FeaturePackage::query()->findOrFail($id);
            $notification = "Updated";
        }

        $feature->feature = $request->feature;
        $feature->package_id = $request->idPackage;
        $feature->save();

        $notify[] = ['success', "Feature $notification successfuly"];
        return back()->with($notify);

    }


    public function delteFeaturePackage(Request $request, $id){


       if (  FeaturePackage::query()->findOrFail($id)->delete()){
           $notify [] = ['success', 'Feature deleted successfully'];
           return back()->with($notify);
       }


        $notify [] = ['error', 'System Error'];
        return back()->with($notify);


    }


    public function stores()
    {
        $data = $this->filterStores();
        $data['pageTitle'] = 'All Stores';
        return view($this->storeView, $data);
    }

    public function active()
    {
        $data = $this->filterStores('active');
        $data['pageTitle'] = 'Active Stores';
        return view($this->storeView, $data);
    }

    public function featured()
    {
        $data = $this->filterStores('featured');
        $data['pageTitle'] = 'Featured Stores';
        return view($this->storeView, $data);
    }

    protected function filterStores($scope = null)
    {
        $stores = Store::query();
        if ($scope) {
            $stores = Store::$scope();
        }

        $searchKey = request()->search;

        if ($searchKey) {
            $stores = $stores->where(function ($query) use ($searchKey) {
                $query->where('name', 'like', "%$searchKey%")
                    ->orWhereHas('user', function ($user) use ($searchKey) {
                        $user->where('username', 'like', "%$searchKey%");
                    });
            });
        }

        $stores = $stores->with('user', 'coupons')->latest()->paginate(getPaginate());

        $data['stores'] = $stores;

        return $data;
    }


    public function storeList(Request $request)
    {
        $query = Store::query();
        if (request()->search) {
            $query->where('name', 'like', "%$request->search%")->get();
        }

        $stores = $query->latest()->paginate(getPaginate());
        foreach ($stores as $store) {
            $response[] = [
                "id" => $store->id,
                "text" => $store->name,
            ];
        }

        return $response ?? [];
    }

    public function savestore(request $request, $id = 0)
    {
        $imgValidation = $id ? 'nullable' : 'required';
        $request->validate([
            'name' => 'required|max:40',
            'image' => ["$imgValidation", 'image', new FileTypeValidate(['jpg', 'jpeg', 'png'])],
        ]);

        $store = new Store();
        $notification = 'added';
        $oldImage = '';

        if ($id) {
            $store = Store::findOrFail($id);
            $store->status = $request->status ? 1 : 0;
            $notification = 'updated';
            $oldImage = $store->image;
        }

        if ($request->hasFile('image')) {
            try {
                $store->image = fileUploader($request->image, getFilePath('store'), null, $oldImage);
            } catch (\Exception$e) {
                $notify[] = ['error', 'Couldn\'t upload your image'];
                return back()->withNotify($notify);
            }
        }

        $store->name = $request->name;
        $store->featured = $request->featured ? 1 : 0;
        $store->save();

        $notify[] = ['success', "Store $notification successfully"];
        return back()->withNotify($notify);
    }
}
