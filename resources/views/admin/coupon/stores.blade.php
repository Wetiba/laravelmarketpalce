@extends('admin.layouts.app')
@section('panel')
    <div class="row">
        <div class="col-lg-12">
            <div class="card b-radius--10 ">
                <div class="card-body p-0">
                    <div class="table-responsive--md  table-responsive">
                        <table class="table table--light style--two">
                            <thead>
                            <tr>
                                <th>@lang('S.N.')</th>
                                <th>@lang('Name')</th>
                                <th>@lang('Username')</th>
                                <th>@lang('Coupon')</th>
                                @if (!request()->routeIs('admin.store.featured'))
                                    <th>@lang('Featured')</th>
                                @endif
                                <th>@lang('Status')</th>
                                <th>@lang('Action')</th>
                            </tr>
                            </thead>
                            <tbody>
                            @forelse($stores as $store)
                                <tr>
                                    <td data-label="@lang('S.N')">{{ $stores->firstItem() + $loop->index }}</td>
                                    <td data-label="@lang('Name')">{{ __($store->name) }}</td>
                                    <td data-label="@lang('Username')">
                                        @if ($store->user_id)
                                            <a href="{{ route('admin.users.detail', $store->user_id) }}">
                                                {{  $store->user->username }}
                                            </a>
                                        @else
                                            -
                                        @endif
                                    </td>
                                    <td data-label="@lang('Coupon')">
                                        <a href="{{ route('admin.coupon.store', $store->id) }}" class="icon-btn">{{ $store->coupons->count() }}</a>
                                    </td>
                                    @if (!request()->routeIs('admin.store.featured'))
                                        <td data-label="@lang('Featured')">
                                            @if($store->featured == 1)
                                                <span class="text--small badge font-weight-normal badge--success">@lang('Yes')</span>
                                            @else
                                                <span class="text--small badge font-weight-normal badge--warning">@lang('No')</span>
                                            @endif
                                        </td>
                                    @endif
                                    <td data-label="@lang('Status')">
                                        @if($store->status == 1)
                                            <span class="text--small badge font-weight-normal badge--success">@lang('Active')</span>
                                        @else
                                            <span class="text--small badge font-weight-normal badge--warning">@lang('Inactive')</span>
                                        @endif
                                    </td>
                                    <td data-label="@lang('Action')">
                                        <button class="btn btn-sm btn-outline--primary editStore"
                                         data-id="{{ $store->id }}" 
                                         data-name="{{ $store->name }}"
                                         data-status="{{ $store->status }}"
                                         data-featured="{{ $store->featured }}"
                                         data-image="{{ getImage(getFilePath('store').'/'.$store->image) }}"
                                         data-toggle="tooltip"  data-original-title="@lang('Edit')">
                                            <i class="las la-pen text-shadow"></i> @lang('Edit')
                                        </button>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td class="text-muted text-center" colspan="100%">{{ __($emptyMessage) }}</td>
                                </tr>
                            @endforelse

                            </tbody>
                        </table><!-- table end -->
                    </div>
                </div>
                @if($stores->hasPages())
                <div class="card-footer py-4">
                    {{ paginateLinks($stores) }}
                </div>
                @endif
            </div>
        </div>
    </div>

{{-- Store modal --}}
<div id="storeModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"></h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form method="POST" enctype="multipart/form-data">
                @csrf
                <div class="modal-body">
                    <div class="form-group">
                        <div class="image-upload">
                            <div class="thumb">
                                <div class="avatar-preview">
                                    <div class="profilePicPreview" style="background-image: url({{ getImage(getFilePath('store')) }})">
                                        <button type="button" class="remove-image"><i class="fa fa-times"></i></button>
                                    </div>
                                </div>
                                <div class="avatar-edit">
                                    <input type="file" class="profilePicUpload" name="image" id="profilePicUpload2" accept=".png, .jpg, .jpeg">
                                    <label for="profilePicUpload2" class="bg--success">@lang('Store Image')</label>
                                    <small class="mt-2 text-facebook">@lang('Supported files'): <b>@lang('jpeg'), @lang('jpg'), @lang('png').</b> </small>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>@lang('Name')</label>
                        <input class="form-control" type="text" name="name" required>
                    </div>
                    <div class="form-group statusGroup">
                        <label>@lang('Status')</label>
                        <input type="checkbox" data-width="100%" data-onstyle="-success" data-offstyle="-danger"
                            data-bs-toggle="toggle" data-on="@lang('Active')" data-off="@lang('Inactive')" name="status">
                    </div>
                    <div class="form-group">
                        <label>@lang('Featured')</label>
                        <input type="checkbox" data-width="100%" data-onstyle="-success" data-offstyle="-danger"
                            data-bs-toggle="toggle" data-on="@lang('Yes')" data-off="@lang('No')" name="featured">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn--primary w-100">@lang('Submit')</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection

@push('breadcrumb-plugins')
    <div class="d-flex flex-wrap justify-content-sm-end header-search-wrapper">
        <form action="" method="GET" class="header-search-form">
            <div class="input-group has_append">
                <input type="text" name="search" class="form-control bg-white text--black" placeholder="@lang('Search Store')" value="{{ request()->search }}">
                <button class="btn btn--primary" type="submit"><i class="fa fa-search"></i></button>
            </div>
        </form>
        <button class="btn btn-outline--primary box--shadow1 addStore"><i class="las la-plus"></i>@lang('Add New')</button>
    </div>
@endpush

@push('style')
    <style>
        .btn {
            display: inline-flex;
            justify-content: center;
            align-items: center
        }
        .header-search-wrapper {
            gap: 15px
        }
        @media (max-width:400px) {
            .header-search-form {
                width: 100%
            }
        }
    </style>
@endpush

@push('script')
    <script>
        (function ($) {
            "use strict";
            var modal   = $('#storeModal');
            var action  = `{{ route('admin.store.save') }}`;

            $('.addStore').click(function(){
                modal.find('.modal-title').text("@lang('Add Store')");
                modal.find('.statusGroup').hide();
                modal.find('form').attr('action', action);
                modal.modal('show');
            });

            modal.on('shown.bs.modal', function (e) {
                $(document).off('focusin.modal');
            });

            $('.editStore').click(function () {
                var data = $(this).data();
                modal.find('.modal-title').text("@lang('Update Store')");
                modal.find('.statusGroup').show();
                modal.find('[name=name]').val(data.name);
                modal.find('.profilePicPreview').css('background-image', `url(${data.image})`);
                console.log(data.image);
                if(data.status == 1){
                    modal.find('input[name=status]').bootstrapToggle('on');
                }else{
                    modal.find('input[name=status]').bootstrapToggle('off');
                }

                if(data.featured == 1){
                    modal.find('input[name=featured]').bootstrapToggle('on');
                }else{
                    modal.find('input[name=featured]').bootstrapToggle('off');
                }


                modal.find('form').attr('action', `${action}/${data.id}`);
                modal.modal('show');
            });

            modal.on('hidden.bs.modal', function () {
                modal.find('form')[0].reset();
            });

        })(jQuery);
    </script>
@endpush
