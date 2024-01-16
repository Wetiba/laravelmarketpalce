@extends('admin.layouts.app')
@section('panel')


    @if($features)

        <div class="d-flex flex-wrap justify-content-end mb-3">
            <div class="d-inline">
                <div class="input-group justify-content-end">
                    <input type="text" name="search_table" class="form-control bg--white" placeholder="@lang('Search')...">
                    <button class="btn btn--primary input-group-text"><i class="fa fa-search"></i></button>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-body p-0">
                        <div class="table-responsive--sm table-responsive">
                            <table class="table table--light style--two custom-data-table">
                                <thead>
                                <tr>
                                    <th>@lang('SL')</th>
                                    <th>@lang('Detail')</th>
                                    <th>@lang('Action')</th>
                                </tr>
                                </thead>
                                <tbody class="list">
                                @forelse($features as $feature)
                                    <tr>
                                        <td data-label="@lang('SL')">{{$loop->iteration}}</td>
                                        <td data-label="@lang('Details')">{{$feature->feature}}</td>
                                        <td data-label="@lang('Action')">
                                            <div class="button--group">


                                                <button  class="btn btn-sm btn-outline--primary update-feature" data-feature="{{$feature->feature}}"><i class="la la-pencil-alt"></i> @lang('Edit')</button>

                                                <button class="btn btn-sm btn-outline--danger confirmationBtn"
                                                        data-action="{{ route('admin.package.feature.delete', $feature->id) }}"
                                                        data-question="@lang('Are you sure to remove this item?')"><i class="la la-trash"></i> @lang('Remove')</button>
                                            </div>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td class="text-muted text-center" colspan="100%">{{ __($emptyMessage) }}</td>
                                    </tr>
                                @endforelse
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    @endif
    {{-- if section element end --}}


    {{-- Modoal add feature --}}
    <div class="modal fade" role="dialog" tabindex="-1" id="fetureModal" >
        <div class="modal-dialog" role="document">
            <div class="modal-content">

                <div class="modal-header">

                    <h5 class="modal-title">@lang('Add new feature')</h5>
                    <button type="text" class="close" data-bs-dismiss="modal" aria-label="Close" ><i class="la la-close"></i></button>

                </div>

                <form  method="post" action="" >
                 @csrf
                <div class="modal-body">

                    <input type="text" hidden name="idPackage" value="{{$idPackage}}">
                    <div class="form-group">
                        <label for="feature">@lang('Feature')</label>
                        <textarea  class="form-control" name="feature" id="feature" required> </textarea>
                    </div>

                </div>
                <div class="modal-footer">

                    <button type="submit" class="btn btn-primary w-100 h-45" >@lang('Submit')</button>
                </div>

                </form>

            </div>
        </div>
    </div>

    <x-confirmation-modal></x-confirmation-modal>

@endsection


@push('breadcrumb-plugins')
    <button class="btn btn-sm btn-outline--primary add-feature" data-package="" ><i class="las la-plus"></i>@lang('Add New')</button>
@endpush



@push('script')

   <script>

       (function ($){
           var action = '{{route('admin.package.feature.save-update')}}';
           var modal = $('#fetureModal');
           "use strict";
           $('.add-feature').on('click', function (){
               modal.find('form').attr('action' , action)
               modal.modal('show');
           });


           $('.update-feature').on('click' , function (){

               modal.find('[name=feature]').val($(this).data('feature'))
               modal.find('form').attr('action',  `${action}` + '/' + {{$idPackage}} );
               modal.modal('show');

           })



       })(jQuery);

   </script>

@endpush
