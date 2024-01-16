@extends($activeTemplate . 'layouts.frontend')

@section('content')
    <section class="pt-80 pb-80 section--bg">
        <div class="container">
            <div class="d-flex flex-wrap gap-4">
                @forelse ($stores as $store)
                    <div class="store-item text-center has--link flex-shrink-0">
                        <div class="store-item__thumb">
                            <img src="{{ getImage(getFilePath('store') . '/' . $store->image) }}"
                                alt="image">
                        </div>
                        <div class="store-item__content">
                            <div class="d-flex flex-wrap align-items-center justify-content-center text--base">
                                <h3 class="me-2">{{ $store->coupons->count() ? @$store->coupons->sortByDesc('cashback')->first()->cashback : '0.00' }}%</h3>
                                <span>@lang('Cash Back')</span>
                            </div>
                        </div>
                    </div>
                @empty
                    <div class="text-center">
                        {{ __($emptyMessage) }}
                    </div>
                @endforelse
            </div>
            {{ $stores->links() }}
        </div>
    </section>
@endsection


@push('style')
    <style>
        .store-item {
            width: calc((100% / 5) - 20px)

        }
        @media (max-width:1199px) {
            .store-item {
                width: calc((100% / 4) - 18px)
            }
        }
        @media (max-width: 767px) {
            .store-item {
                width: calc((100% / 3) - 16px)
            }
        }
        @media (max-width: 480px) {
            .store-item {
                width: calc((100% / 2) - 12px)
            }
        }
        @media (max-width: 400px) {
            .store-item {
                width: 100%
            }
        }
    </style>
@endpush