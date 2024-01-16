@extends($activeTemplate.'layouts.master')
@section('content')
<section class="pt-80 pb-80">
    <div class="container">
        <div class="text-end">
            <a href="{{ route('user.coupon.add') }}" class="btn btn-sm btn--base mb-2 add-store"> <i class="fa fa-plus"></i> @lang('Add New')</a>
        </div>
        <div class="table-responsive table-responsive--md">
            <table class="table custom--table">
                <thead>
                    <tr>
                        <th>@lang('S.N.')</th>
                        <th>@lang('Title')</th>
                        <th>@lang('Category')</th>
                        <th>@lang('Card Code')</th>
                        <th>@lang('Status')</th>
                        <th>@lang('Featured')</th>
                        <th>@lang('Action')</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($coupons as $coupon)
                        <tr>
                            <td data-label="@lang('S.N.')">{{ $coupons->firstItem() + $loop->index }}</td>
                            <td data-label="@lang('Title')">{{ __($coupon->title) }}</td>
                            <td data-label="@lang('Category')">{{ __($coupon->category->name) }}</td>
                            <td data-label="@lang('Card Code')">{{ $coupon->coupon_code }}</td>
                            <td data-label="@lang('Status')">
                                @if($coupon->status == 0)
                                    <span class="badge badge--warning">@lang('Pending')</span>
                                @elseif($coupon->status == 1 && $coupon->ending_date > now())
                                    <span class="badge badge--success">@lang('Active')</span>
                                @elseif($coupon->status == 2 && $coupon->ending_date > now())
                                    <span class="badge badge--warning">@lang('Inactive')</span>
                                @elseif(($coupon->status == 1 || $coupon->status == 2) && $coupon->ending_date <= now())
                                    <span class="badge badge--dark">@lang('Expired')</span>
                                @else
                                    <span class="badge badge--danger">@lang('Rejected')</span>
                                    <button class="btn-info btn-rounded  badge reasonBtn" data-reason="{{ @$coupon->reason }}"><i class="fa fa-info"></i></button>
                                @endif
                            </td>
                            <td data-label="@lang('Featured')">{{ $coupon->featured_validity >= now() ? showDateTime($coupon->featured_validity, 'Y-m-d') : '-' }}</td>
                            <td data-label="Action">
                                <a href="{{ route('user.coupon.add', $coupon->id) }}" class="icon-btn bg--base" data-bs-toggle="tooltip" data-bs-position="top" title="@lang('Edit')"><i class="las la-pen"></i></a>
                                @if ($coupon->status == 2 && $coupon->ending_date > now())
                                    <button class="icon-btn bg-success confirmationBtn" data-bs-toggle="tooltip" data-bs-position="top" title="@lang('Active Card')" data-question="@lang('Are you sure to active this card')" data-action="{{ route('user.coupon.status', $coupon->id) }}"><i class="las la-toggle-off"></i></button>
                                @else
                                    <button class="icon-btn bg-warning confirmationBtn {{ ($coupon->status != 1 || $coupon->ending_date < now()) ? 'disabled' : '' }}" data-bs-toggle="tooltip" data-bs-position="top" title="@lang('Inative Card')" data-question="@lang('Are you sure to inactive this card')" data-action="{{ route('user.coupon.status', $coupon->id) }}"><i class="las la-toggle-off"></i></button>
                                @endif
                                <a href="{{ route('user.coupon.boost', $coupon->id) }}" class="icon-btn bg--primary" data-bs-toggle="tooltip" data-bs-position="top" title="@lang('Boost')"><i class="las la-rocket"></i></a>
                                <a href="{{ route('user.coupon.report', $coupon->id) }}" class="icon-btn bg--success" data-bs-toggle="tooltip" data-bs-position="top" title="@lang('View Report')"><i class="las la-chart-bar"></i></a>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="100%" class="text-center">{{ __($emptyMessage) }}</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
        {{ $coupons->links() }}
    </div>
    <x-confirmation-modal btnSize="btn-sm" btnBase="btn--base"></x-confirmation-modal>
</section>

<div id="reasonModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">@lang('Rejected Reason')</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <i class="las la-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <p class="reason"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn--dark btn-sm" data-bs-dismiss="modal">@lang('Close')</button>
            </div>
        </div>
    </div>
</div>
@endsection

@push('script')
    <script>
        (function($) {
        "use strict";
            $('.reasonBtn').on('click', function(){
                var modal   = $('#reasonModal');
                modal.find('.reason').text($(this).data('reason'));
                modal.modal('show');
            });
        })(jQuery);
    </script>
@endpush
