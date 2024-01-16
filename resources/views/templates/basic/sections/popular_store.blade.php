@php
    $popularStore = getContent('popular_store.content', true);
    $stores = \App\Models\Store::where('featured', 1)->where('status', 1)
    ->with(['coupons' => function($coupon){
        $coupon->where('status', 1);
    }])->latest()->limit(10)->get();
@endphp
<section class="pt-80 pb-80 section--bg">
    <div class="container">
        <div class="section-header d-flex justify-content-between align-items-center gap-3">
            <h2 class="section-title">{{ __($popularStore->data_values->heading) }}</h2>
            <a href="{{ route('popular.stores') }}" class="btn btn--base btn-md flex-shrink-0">@lang('View All')</a>
        </div>
        <div class="store-slider">
            @foreach ($stores as $store)
                <div class="single-slide">
                    <div class="store-item text-center has--link">
                        <div class="store-item__thumb">
                            <img src="{{ getImage(getFilePath('store').'/'.$store->image) }}" alt="image">
                        </div>
                        <div class="store-item__content">
                            <div class="d-flex flex-wrap align-items-center justify-content-center text--base">
                                <h3 class="me-2">{{ $store->coupons->count() ? @$store->coupons->sortByDesc('cashback')->first()->cashback : '0.00' }}%</h3>
                                <span>@lang('Cash Back Up To')</span>
                            </div>
                        </div>
                    </div><!-- store-item end -->
                </div>
            @endforeach
        </div>
    </div>
</section>
