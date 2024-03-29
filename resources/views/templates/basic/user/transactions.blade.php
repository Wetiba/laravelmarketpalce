@extends($activeTemplate.'layouts.master')
@section('content')
    <section class="pt-80 pb-80">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <form action="">
                        <div class="mb-3 ms-auto d-flex justify-content-end w-50 payment-search">
                            <div class="input-group">
                                <input type="text" name="search" class="form-control form--control" value="{{ request()->search }}" placeholder="@lang('Search by transactions')">
                                <button class="input-group-text bg--base text-white">
                                    <i class="las la-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                    <div class="table-responsive table-responsive--md">
                        <table class="table custom--table">
                            <thead>
                            <tr>
                                <th>@lang('SN')</th>
                                <th class="text-center">@lang('Initiated')</th>
                                <th class="text-center">@lang('Amount')</th>
                                <th class="text-center">@lang('Trx Reference')</th>
                                <th class="text-center">@lang('Account')</th>
                                <th class="text-center">@lang('Type')</th>
                                <th>@lang('Details')</th>
                            </tr>
                            </thead>
                            <tbody>
                            @forelse($transactions as $transaction)
                                <tr>
                                    <td data-label="@lang('SN')">
                                        <span class="fw-bold"> <span class="text-primary">{{ __($loop->iteration) }}</span> </span>
                                    </td>

                                    <td class="text-center" data-label="@lang('Initiated')">
                                        {{ showDateTime($transaction->created_at) }}<br>{{ diffForHumans($transaction->created_at) }}
                                    </td>
                                    <td class="text-center" data-label="@lang('Amount')">
                                       <span class="{{ $transaction->type == 'deposit' ?  'text-success' : 'text-danger'  }} " title="@lang('amount')">{{ showAmount($transaction->amount)}} </span>

                                    </td>
                                    <td class="text-center" data-label="@lang('Conversion')">
                                        1 {{ __($general->cur_text) }} =  {{ showAmount($deposit->rate) }} {{__($deposit->method_currency)}}
                                        <br>
                                        <strong>{{ showAmount($deposit->final_amo) }} {{__($deposit->method_currency)}}</strong>
                                    </td>
                                    <td class="text-center" data-label="@lang('Status')">
                                        @php echo $deposit->statusBadge @endphp
                                    </td>
                                    @php
                                        $details = ($deposit->detail != null) ? json_encode($deposit->detail) : null;
                                    @endphp

                                    <td data-label="@lang('Details')">
                                        <a href="javascript:void(0)" class="icon-btn btn--base @if($deposit->method_code >= 1000) detailBtn @else disabled @endif"
                                           @if($deposit->method_code >= 1000)
                                               data-info="{{ $details }}"
                                           @endif
                                           @if ($deposit->status == 3)
                                               data-admin_feedback="{{ $deposit->admin_feedback }}"
                                           @endif
                                           data-bs-toggle="tooltip"
                                           data-bs-position="top" title="@lang('View Details')"
                                        >
                                            <i class="las la-desktop"></i>
                                        </a>
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
                {{ $deposits->links() }}
            </div>
        </div>
    </section>

    {{-- APPROVE MODAL --}}
    <div id="detailModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">@lang('Details')</h5>
                    <span type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <i class="las la-times"></i>
                </span>
                </div>
                <div class="modal-body">
                    <ul class="list-group userData mb-2">
                    </ul>
                    <div class="feedback"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-dark btn-sm" data-bs-dismiss="modal">@lang('Close')</button>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('script')
    <script>
        (function ($) {
            "use strict";
            $('.detailBtn').on('click', function () {
                var modal = $('#detailModal');

                var userData = $(this).data('info');
                var html = '';
                if(userData){
                    userData.forEach(element => {
                        if(element.type != 'file'){
                            html += `
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <span>${element.name}</span>
                                <span">${element.value}</span>
                            </li>`;
                        }
                    });
                }

                modal.find('.userData').html(html);

                if($(this).data('admin_feedback') != undefined){
                    var adminFeedback = `
                        <div class="my-3">
                            <strong>@lang('Admin Feedback')</strong>
                            <p>${$(this).data('admin_feedback')}</p>
                        </div>
                    `;
                }else{
                    var adminFeedback = '';
                }

                modal.find('.feedback').html(adminFeedback);


                modal.modal('show');
            });
        })(jQuery);
    </script>
@endpush
