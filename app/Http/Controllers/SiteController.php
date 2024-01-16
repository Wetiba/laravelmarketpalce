<?php

namespace App\Http\Controllers;
use App\Models\AdminNotification;
use App\Models\Advertisement;
use App\Models\Category;
use App\Models\Frontend;
use App\Models\GeneralSetting;
use App\Models\Language;
use App\Models\Page;
use App\Models\Coupon;
use App\Models\CouponReport;
use App\Models\Store;
use App\Models\SupportMessage;
use App\Models\SupportTicket;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cookie;

class SiteController extends Controller
{
    public function index(){
        $pageTitle = 'Home';
        $sections = Page::where('tempname',$this->activeTemplate)->where('slug','/')->first();
        return view($this->activeTemplate . 'home', compact('pageTitle','sections'));
    }

    public function pages($slug)
    {
        $page = Page::where('tempname',$this->activeTemplate)->where('slug',$slug)->firstOrFail();
        $pageTitle = $page->name;
        $sections = $page->secs;
        return view($this->activeTemplate . 'pages', compact('pageTitle','sections'));
    }

    public function search(Request $request, $filterType=null, $filterId=0)
    {
        $pageTitle = 'Coupon List';
        $categories = Category::where('status', 1)->get();
        $coupons = Coupon::active();
        $searchKey = $request->search_key;

        if($searchKey){
            $coupons = $coupons->where(function($query) use($searchKey){
                $query->where('title', 'like', "%$searchKey%")
                        ->orWhereHas('category', function($category) use($searchKey){
                            $category->where('name', 'like', "%$searchKey%");
                        })->orWhereHas('store', function($store) use($searchKey){
                            $store->where('name', 'like', "%$searchKey%");
                        });
            });
        }

        if($request->category){
            $pageTitle = 'Coupons List by Category';
            $coupons = $coupons->whereIn('category_id', $request->category);
        }

        if($filterType == 'category'){
            $coupons = $coupons->where('category_id', $filterId);
            $request->category = [$filterId];
        }

        if($filterType == 'store'){
            $coupons = $coupons->where('store_id', $filterId);
        }

        if($filterType == 'today-deal'){
            $pageTitle = 'Today\'s Deal';
            $coupons = $coupons->where('today_deal', 1);
        }

        if($filterType == 'top-deal'){
            $pageTitle = 'Top Deal';
            $coupons = $coupons->where('top_deal', 1);
        }

        if($filterType == 'expire-soon'){
            $pageTitle = 'Expire Soon';
            $coupons = $coupons->where('ending_date', '<=', now()->addDays(7))->orderBy('ending_date', 'ASC');
        }

        $coupons->increment('impression');

        $coupons = $coupons->with('store')->withCount(['reports' => function($report){
            $report->where('action', 'copy')->where('date', 'like', now()->format('Y-m-d'));
        }])->orderBy('featured_validity', 'DESC')->paginate(getPaginate(18));

        $this->saveCouponReport($coupons, 'impression');

        $pageTitle = $filterType == 'category' ? $coupons[0]->category->name.' '.$pageTitle : $pageTitle;
        $pageTitle = $filterType == 'store' ? $coupons[0]->store->name.' '.$pageTitle : $pageTitle;

        $sections = Page::where('tempname', $this->activeTemplate)->where('slug', 'coupon')->first();

        return view($this->activeTemplate.'coupon_list', compact('pageTitle', 'categories', 'coupons', 'sections'));
    }


    public function saveCouponClick(Request $request)
    {
        $coupon = Coupon::findOrFail($request->couponId);
        $coupon->increment('click');

        $this->saveCouponReport([$coupon], 'click');
        return true;
    }

    public function saveCouponCopy(Request $request)
    {
        $coupon = Coupon::findOrFail($request->couponId);
        $coupon->increment('copy');

        $this->saveCouponReport([$coupon], 'copy');
        return true;
    }

    public static function saveCouponReport($coupons, $reportType)
    {
        $report = [];
        $ip = getRealIP();
        $date = now()->format('Y-m-d');

        foreach ($coupons as $coupon) {
            $couponReport = CouponReport::where('coupon_id', $coupon->id)->where('action', $reportType)->where('ip', $ip)->where('date', $date)->increment('number');

            if(!$couponReport){
                $report[] = [
                    'coupon_id' => $coupon->id,
                    'action' => $reportType,
                    'number' => 1,
                    'ip' => $ip,
                    'date' => $date,
                    'created_at'=>now(),
                    'updated_at'=>now(),
                ];
            }
        }
        CouponReport::insert($report);
    }

    public function popularStore()
    {
        $pageTitle = 'Popular Stores';
        $stores = Store::featured()->where('status', 1)->with('coupons')->paginate(getPaginate());

        return view($this->activeTemplate.'popular_stores', compact('pageTitle', 'stores'));
    }

    public function stores()
    {
        $pageTitle = 'Stores';
        $stores = Store::where('status', 1)->with('coupons')->paginate(getPaginate());

        return view($this->activeTemplate.'popular_stores', compact('pageTitle', 'stores'));
    }

    public function contact()
    {
        $pageTitle = "Contact Us";
        $categories = Category::where('status', 1)->get();
        $sections = Page::where('tempname', $this->activeTemplate)->where('slug', 'contact')->first();

        return view($this->activeTemplate . 'contact',compact('pageTitle', 'categories', 'sections'));
    }


    public function contactSubmit(Request $request)
    {
        $this->validate($request, [
            'name' => 'required',
            'email' => 'required',
            'subject' => 'required|string|max:255',
            'message' => 'required',
        ]);

        if(!verifyCaptcha()){
            $notify[] = ['error','Invalid captcha provided'];
            return back()->withNotify($notify);
        }

        $request->session()->regenerateToken();

        $random = getNumber();

        $ticket = new SupportTicket();
        $ticket->user_id = auth()->id() ?? 0;
        $ticket->name = $request->name;
        $ticket->email = $request->email;
        $ticket->priority = 2;


        $ticket->ticket = $random;
        $ticket->subject = $request->subject;
        $ticket->last_reply = Carbon::now();
        $ticket->status = 0;
        $ticket->save();

        $adminNotification = new AdminNotification();
        $adminNotification->user_id = auth()->user() ? auth()->user()->id : 0;
        $adminNotification->title = 'A new support ticket has opened ';
        $adminNotification->click_url = urlPath('admin.ticket.view',$ticket->id);
        $adminNotification->save();

        $message = new SupportMessage();
        $message->support_ticket_id = $ticket->id;
        $message->message = $request->message;
        $message->save();

        $notify[] = ['success', 'Ticket created successfully!'];

        return to_route('ticket.view', [$ticket->ticket])->withNotify($notify);
    }

    public function policyPages($slug,$id)
    {
        $policy = Frontend::where('id',$id)->where('data_keys','policy_pages.element')->firstOrFail();
        $pageTitle = $policy->data_values->title;
        return view($this->activeTemplate.'policy',compact('policy','pageTitle'));
    }

    public function changeLanguage($lang = null)
    {
        $language = Language::where('code', $lang)->first();
        if (!$language) $lang = 'en';
        session()->put('lang', $lang);
        return redirect()->back();
    }

    public function adRedirect($id){
        $id = decrypt($id);
        $ad = Advertisement::findOrFail($id);
        $ad->click += 1;
        $ad->save();
        if($ad->type == 'image'){
            return redirect($ad->redirect_url);
        }
        return back();
    }

    public function blogs()
    {
        $pageTitle      = 'Blog Posts';
        $blogs          = Frontend::where('data_keys', 'blog.element')->orderBy('id','desc')->paginate(getPaginate(18));
        $sections       = Page::where('tempname',$this->activeTemplate)->where('slug','blog')->first();

        return view($this->activeTemplate.'blogs', compact('pageTitle', 'blogs', 'sections'));
    }

    public function blogDetails($slug, $id)
    {
        $pageTitle = 'Blog Details';
        $blog = Frontend::where('id',$id)->where('data_keys','blog.element')->firstOrFail();
        $recentBlogs = Frontend::where('data_keys', 'blog.element')->where('id', '!=', $blog->id)->orderBy('id','desc')->limit(10)->get();

        $seoContents['keywords']           = $blog->meta_keywords ?? [];
        $seoContents['social_title']       = $blog->data_values->title;
        $seoContents['description']        = strLimit(strip_tags($blog->data_values->description), 150);
        $seoContents['social_description'] = strLimit(strip_tags($blog->data_values->description), 150);
        $seoContents['image']              = getImage('assets/images/frontend/blog/'.$blog->data_values->blog_image);
        $seoContents['image_size']         = '850x850';

        return view($this->activeTemplate.'blog_details',compact('blog','pageTitle', 'recentBlogs', 'seoContents'));
    }


    public function cookieAccept(){
        $general = GeneralSetting::first();
        Cookie::queue('gdpr_cookie',$general->site_name , 43200);
        return back();
    }

    public function cookiePolicy(){
        $pageTitle = 'Cookie Policy';
        $cookie = Frontend::where('data_keys','cookie.data')->first();
        return view($this->activeTemplate.'cookie',compact('pageTitle','cookie'));
    }

    public function placeholderImage($size = null){
        $imgWidth = explode('x',$size)[0];
        $imgHeight = explode('x',$size)[1];
        $text = $imgWidth . '×' . $imgHeight;
        $fontFile = realpath('assets/font') . DIRECTORY_SEPARATOR . 'RobotoMono-Regular.ttf';
        $fontSize = round(($imgWidth - 50) / 8);
        if ($fontSize <= 9) {
            $fontSize = 9;
        }
        if($imgHeight < 100 && $fontSize > 30){
            $fontSize = 30;
        }

        $image     = imagecreatetruecolor($imgWidth, $imgHeight);
        $colorFill = imagecolorallocate($image, 100, 100, 100);
        $bgFill    = imagecolorallocate($image, 175, 175, 175);
        imagefill($image, 0, 0, $bgFill);
        $textBox = imagettfbbox($fontSize, 0, $fontFile, $text);
        $textWidth  = abs($textBox[4] - $textBox[0]);
        $textHeight = abs($textBox[5] - $textBox[1]);
        $textX      = ($imgWidth - $textWidth) / 2;
        $textY      = ($imgHeight + $textHeight) / 2;
        header('Content-Type: image/jpeg');
        imagettftext($image, $fontSize, 0, $textX, $textY, $colorFill, $fontFile, $text);
        imagejpeg($image);
        imagedestroy($image);
    }

    public function maintenance()
    {
        $pageTitle = 'Maintenance Mode';
        $general = GeneralSetting::first();
        if($general->maintenance_mode == 0){
            return to_route('home');
        }
        $maintenance = Frontend::where('data_keys','maintenance.data')->first();
        return view($this->activeTemplate.'maintenance',compact('pageTitle','maintenance'));
    }

}
