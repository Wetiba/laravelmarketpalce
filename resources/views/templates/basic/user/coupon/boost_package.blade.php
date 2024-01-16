@extends($activeTemplate.'layouts.master')
@section('content')
<section class="pt-80 pb-80">
    <div class="container">
        <div class="row justify-content-center">
            @forelse ($packages as $package)
                <div class="col-xxl-4 col-lg-4 col-md-4">
                    <div class="custom--card">
                        <div class="card-header" style="background: #08207E !important;">

                            <img src="{{ env('APP_URL') . '/' . getFilePath('coupon') }}/{{$package->image}}" alt="">
                            <br><br>
                            <span class="text-white" >{{ $general->cur_sym }}{{ showAmount($package->price) }}</span>
                            <h2 class="text-white" >{{ __($package->name) }}</h2>

                        </div>
                        <div class="card-body p-0">


                            <div class="p-2 text-center" style="background: #08207E;">
                                <h3 class="text-white" style="line-height: 15px;"><small style="font-size: 15px" >{{$package->sub_heading}}</small> </h3>
                                <br>
                            </div>

                            <ul class="list-group">

                                @foreach($package->feature as $item)

                                    <li class="list-group-item d-flex  align-items-center" style="background: #004AAD" >
                                        <span style="margin-right: 10px;"> <i class="fa fa-arrow-right text-white"></i></span>
                                        <span class="text-white"> {{$item->feature}}</span>
                                    </li>

                                @endforeach


                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                @lang('Price')
                                <span>{{ $general->cur_sym }}{{ showAmount($package->price) }}</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                @lang('Duration')
                                <span>{{ $package->duration }} @lang('Days')</span>
                                </li>

                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    @lang('Quantity to use')
                                    <span>#{{ $package->quantity_coupon_use}} </span>
                                </li>
                            </ul>
                            <button class="btn btn--base w-100 mt-3 boostBtn" data-package_id="{{ $package->id }}" data-coupon_id="{{ $couponId }}">@lang('Boost Now')</button>

                        </div>
                    </div>
                </div>
            @empty
                <div class="text-center">
                    {{ __($emptyMessage) }}
                </div>
            @endforelse
        </div>
        {{ $packages->links() }}
    </div>
</section>

<div id="boostModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">@lang('Confirmation Alert!')</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <i class="las la-times"></i>
                </button>
            </div>
            <form action="{{ route('user.coupon.boost.process') }}" method="POST">
                @csrf
                <div class="modal-body">
                    <p>@lang('Are you sure to purchase this package?')</p>
                </div>
                <input type="hidden" name="package_id">
                <input type="hidden" name="coupon_id">
                <div class="modal-footer">
                    <button type="button" class="btn btn--dark btn-sm" data-bs-dismiss="modal">@lang('No')</button>
                    <button type="submit" class="btn btn--base btn-sm">@lang('Yes')</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection

@push('script')

<script>
    (function ($) {
        "use strict";
        $(document).on('click','.boostBtn', function () {
            var modal   = $('#boostModal');
            let data    = $(this).data();
            modal.find('[name=package_id]').val(data.package_id);
            modal.find('[name=coupon_id]').val(data.coupon_id);
            modal.modal('show');
        });
    })(jQuery);
</script>
@endpush
