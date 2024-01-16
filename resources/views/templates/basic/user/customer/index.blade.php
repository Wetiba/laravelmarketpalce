@extends($activeTemplate.'layouts.master')

@section('content')

    <div class="pt-3 pb-80">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">

                    <!-- Nav tabs -->
                    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="pills-dashboard-tab" data-bs-toggle="pill" data-bs-target="#pills-dashboard" type="button" role="tab" aria-controls="pills-dashboard" aria-selected="true">@lang('Dashboard')</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-transactions-tab" data-bs-toggle="pill" data-bs-target="#pills-transactions" type="button" role="tab" aria-controls="pills-transactions" aria-selected="false">@lang('Transantions')</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-affiliate-coupons-tab" data-bs-toggle="pill" data-bs-target="#pills-affiliate-coupons" type="button" role="tab" aria-controls="pills-affiliate-coupons" aria-selected="false">@lang('Affiliate Cards')</button>
                        </li>

                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="pills-vouchers-tab" data-bs-toggle="pill" data-bs-target="#pills-vouchers" type="button" role="tab" aria-controls="pills-vouchers" aria-selected="false">@lang('Vouchers')</button>
                        </li>
                    </ul>
                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-dashboard" role="tabpanel" aria-labelledby="pills-dashboard-tab">

                            <h3>Hi!, <small class="small">{{Auth::user()->firstname}}</small> </h3>

                        </div>
                        <div class="tab-pane fade" id="pills-affiliate-coupons" role="tabpanel" aria-labelledby="pills-affiliate-coupons-tab">


                            <div class="card custom--card border-0 dashboard-table-card">
                                <div class="card-header section--bg d-flex flex-wrap justify-content-end">
                                    <button  class="btn btn--base btn-sm add-coupon" data-bs-toggle="tooltip" data-bs-position="top" title="@lang('Add Card')" >+ Add New</button>

                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive table-responsive--md overflow-hidden">
                                        <table class="table custom--table">
                                            <thead>
                                            <tr>
                                                <th>@lang('S.N.')</th>
                                                <th>@lang('Card Code')</th>
{{--
                                                <th>@lang('Cashback %')</th>
--}}
                                                <th>@lang('Status')</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            @forelse ($affiliateCoupons as $affiliateCoupon)
                                                <tr>
                                                    <td data-label="@lang('S.N.')">{{ $loop->iteration }}</td>
                                                    <td data-label="@lang('Card Code')"> {{$affiliateCoupon->coupon->coupon_code}} </td>
{{--
                                                    <td data-label="@lang('Cashback')">{{ $affiliateCoupon->coupon->cashback }}</td>
--}}
                                                    <td data-label="@lang('Status')">
                                                        @if($affiliateCoupon->status == '1')
                                                            <span class="badge badge--success">@lang('Active')</span>
                                                        @else
                                                            <span class="badge badge--danger">@lang('Inactive')</span>
                                                        @endif
                                                    </td>

                                                </tr>
                                            @empty
                                                <tr>
                                                    <td colspan="100%" class="text-center">{{ __($emptyMessage) }}</td>
                                                </tr>
                                            @endforelse
                                            </tbody>
                                        </table>
                                        {{$affiliateCoupons->links()}}

                                    </div>
                                </div>
                            </div>


                        </div>
                        <div class="tab-pane fade" id="pills-transactions" role="tabpanel" aria-labelledby="pills-transactions-tab">

                            <div class="card custom--card border-0 dashboard-table-card">
                                <div class="card-header section--bg d-flex flex-wrap justify-content-between algin-items-center">
                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive table-responsive--md">
                                        <table class="table custom--table">
                                            <thead>
                                            <tr>
                                                <th>@lang('S.N.')</th>
                                                <th>@lang('Amount')</th>
                                                <th>@lang('type')</th>
                                                <th>@lang('Created')</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            @forelse ($transactions as $transaction)
                                                <tr>
                                                    <td data-label="@lang('S.N.')">{{ $loop->iteration }}</td>
                                                    <td data-label="@lang('Amount')"> {{$transaction->amount}} </td>
                                                    <td data-label="@lang('Status')">
                                                      @if($coupon->type == 'deposit')
                                                            <span class="badge badge--success">@lang('Deposit')</span>
                                                        @else
                                                            <span class="badge badge--danger">@lang('Withdrawal')</span>
                                                            <button class="btn-info btn-rounded  badge reasonBtn">@lang('Withdrawal')</i></button>
                                                        @endif
                                                    </td>
                                                    <td data-label="@lang('Created')">{{ $transaction->created_at }}</td>

                                                </tr>
                                            @empty
                                                <tr>
                                                    <td colspan="100%" class="text-center">{{ __($emptyMessage) }}</td>
                                                </tr>
                                            @endforelse
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="tab-pane fade" id="pills-vouchers" role="tabpanel" aria-labelledby="pills-vouchers-tab">

                            <div class="card custom--card border-0 dashboard-table-card">
                                <div class="card-header section--bg d-flex flex-wrap justify-content-end">
                                    <button  class="btn btn--base btn-sm add-voucher" data-bs-toggle="tooltip" data-bs-position="top" title="@lang('Add Voucher')" >+ Add New</button>
                                </div>
                                <div class="card-body p-0">
                                    <div class="table-responsive table-responsive--md">
                                        <table class="table custom--table">
                                            <thead>
                                            <tr>
                                                <th>@lang('S.N.')</th>
                                                <th>@lang('File')</th>
                                                <th>@lang('Card Code')</th>
                                                <th>@lang('Status')</th>
                                                <th>@lang('Action')</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            @forelse ($transactions as $transaction)
                                                <tr>
                                                    <td data-label="@lang('S.N.')">{{ $loop->iteration }}</td>
                                                    <td data-label="@lang('File')"><a target="_blank" href="{{ __($transaction->file) }}"></a> <i class="fa fa-link"></i> </td>
                                                    <td data-label="@lang('Card Code')">{{ $transaction->coupon_code }}</td>
                                                    <td data-label="@lang('Status')">
                                                        @if($coupon->status == 'pending')
                                                            <span class="badge badge--warning">@lang('Pending')</span>
                                                        @elseif($coupon->status == 'approved')
                                                            <span class="badge badge--success">@lang('Approved')</span>
                                                        @else
                                                            <span class="badge badge--danger">@lang('Rejected')</span>
                                                            <button class="btn-info btn-rounded  badge reasonBtn" data-reason="{{ @$transaction->reason }}"><i class="fa fa-info"></i></button>
                                                        @endif
                                                    </td>
                                                    <td data-label="Action">
                                                        <button class="icon-btn bg-success confirmationBtn" data-bs-toggle="tooltip" data-bs-position="top" title="@lang('Notify')" data-question="@lang('Are you sure to notify this voucher')" data-action="{{ route('user.customer.voucher-notify', $coupon->id) }}"><i class="las la-toggle-off"></i></button>
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
                                </div>
                            </div>


                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>


     {{--Add Coupon Modal --}}
    <div id="storeCouponModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Active Code</h5>
                    <button type="button" class="close btn--danger" data-bs-dismiss="modal" aria-label="Close">
                        <i class="las la-times"></i>
                    </button>
                </div>
                <form method="POST">
                    @csrf
                    <div class="modal-body">
                        <div class="row">

                            <div class="form-group">
                                <label for="email" class="form-label">@lang('Card Code')</label>
                                <input type="text" name="coupon_code" class="form-control form--control" required>
                            </div>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn--base w-100">
                            @lang('Submit')
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

     {{--Add Voucher Modal--}}
    <div class="modal   fade " id="storeVoucherModal" tabindex="-1" role="dialog" aria-labelledby="createModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="modalLabel"> @lang('Add Voucher')</h4>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">×</span></button>
                </div>
                <form class="form-horizontal" method="post" action="#"
                      enctype="multipart/form-data">
                    @csrf
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <label class="font-weight-bold">@lang('File') <span
                                            class="text-danger">*</span></label>
                                    <input type="file" size-validation="" class="btn btn-primary profilePicUpload"
                                           name="image" id="imageUpload" accept=".png, .jpg, .jpeg, .gif">
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="form-group">
                                    <div class="image-size">
                                        <label for="" class="font-weight-bold">@lang('Card Code') <strong
                                                class="text-danger">*</strong></label>
                                        <input type="text" class="form--control"  name="coupon_code">

                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn--primary w-100" id="btn-save" value="add">@lang('Submit')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

@endsection


@push('script')
    <script>
        (function($) {
            "use strict";

            var defaultImage = '{{ getImage(getFilePath('store')) }}';
            var action = `{{ route('user.customer.affilitate-coupon') }}`
            $('.add-coupon').on('click', function() {
                var modal = $('#storeCouponModal');
                modal.find('form').attr('action', action);
                modal.modal('show');
            });

            $('.add-voucher').on('click', function() {
                var modal = $('#storeVoucherModal');
                modal.find('form').attr('action', action);
                modal.modal('show');
            });


            $('.edit-store').on('click', function() {
                var modal = $('#storeModal');
                var data = $(this).data();
                console.log(data);
                modal.find('.modal-title').text(`@lang('Update Store')`);
                modal.find('[name=name]').val(data.name);
                modal.find('[name=cash_back]').val(data.cashback);
                modal.find('.profilePicPreview').css('background-image', `url(${data.image})`);
                modal.find('form').attr('action', action+`/${data.id}`);

                if(data.status == 1){
                    modal.find('input[name=status]').bootstrapToggle('on');
                }else{
                    modal.find('input[name=status]').bootstrapToggle('off');
                }

                modal.find('.statusGroup').show();
                modal.modal('show');
            });

            $('#storeCouponModal').on('hidden.bs.modal', function() {
                $('#storeModal form')[0].reset();
            });

        })(jQuery);
    </script>
@endpush

@push('style-lib')
    <link rel="stylesheet" href="{{ asset('assets/admin/css/vendor/bootstrap-toggle.min.css') }}">
@endpush
@push('script-lib')
    <script src="{{ asset('assets/admin/js/vendor/bootstrap-toggle.min.js') }}"></script>
@endpush


