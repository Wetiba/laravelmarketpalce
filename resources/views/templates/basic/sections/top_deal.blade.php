@php
    $topDeal = getContent('top_deal.content', true);
    $coupons = \App\Models\Coupon::active()
    ->where('top_deal', 1)
    ->with('store')
    ->withCount(['reports' => function($report){
        $report->where('action', 'copy')->where('date', 'like', now()->format('Y-m-d'));
    }])
    ->orderBy('featured_validity', 'DESC')
    ->limit(8);
    $coupons->increment('impression');
    $coupons = $coupons->get();
    App\Http\Controllers\SiteController::saveCouponReport($coupons, 'impression');
@endphp

<section class="pt-80 pb-80 section--bg">
    <div class="container">
        <div class="section-header d-flex justify-content-between align-items-center gap-3">
            <h2 class="section-title">{{ __($topDeal->data_values->heading) }}</h2>
            <a href="{{ route('coupon.filter.type', 'top-deal') }}" class="btn btn--base btn-md flex-shrink-0">@lang('View All')</a>
        </div>
        <div class="row justify-content-center gy-4">
            @foreach ($coupons as $coupon)
                <div class="col-xl-3 col-lg-4 col-sm-6">
                    <div class="coupon-item has--link">
                        <a href="javascript:void(0)" 
                            data-coupon="{{ $coupon }}"
                            data-ending_date="{{ showDateTime($coupon->ending_date) }}"
                            data-store_image="{{ getImage(getFilePath('store').'/'.$coupon->store->image)  }}"
                            class="item--link coupon-details"></a>
                        <div class="coupon-item__thumb">
                            <img src="{{ getImage(getFilePath('coupon').'/'. $coupon->image,getFileSize('coupon')) }}" alt="image">
                                @if ($coupon->featured_validity >= now())
                                    <span class="coupon-label">@lang('Featured')</span>
                                @endif
                        </div>
                        <div class="coupon-item__content">
                            <div class="coupon-item__meta">
                                <a href="{{ route('coupon.filter.type', ['store', $coupon->store_id]) }}"
                                    class="store-name text--base">{{ __($coupon->store->name) }}</a>
                            </div>
                            <h4 class="title">{{ __($coupon->title) }}</h4>
                            <div class="coupon-item__bottom">
                                <span class="fs--14px">{{ $coupon->reports_count }} @lang('used today')</span>
                            </div>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>
    </div>
</section>
