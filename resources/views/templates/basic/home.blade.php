@extends($activeTemplate.'layouts.frontend')

@section('content')
@php
    $banner = getContent('banner.content', true);
    $banners = getContent('banner.element',false,null,true);
@endphp

    <section class="hero-section bg_img" style="background: url({{ getImage('assets/images/frontend/banner/'.$banner->data_values->background_image, '1920x1080') }}) right; background-size: contain; background-repeat: no-repeat; ">
        <div class="container">
            <div class="row">
                <div class="col-xxl-6 col-lg-7 col-md-8 col-sm-9 col-11">
                    <h2 class="hero-section__title" style="color: #004AAD !important;">{{ __($banner->data_values->heading) }}</h2>
                    <ul class="hero-section__feature mb-4">
                        @foreach ($banners as $banner)
                            <li style="color: #212121 !important;">{{ __($banner->data_values->feature) }}</li>
                        @endforeach
                    </ul>

                    <a class="btn btn-primary" style="background: #004AAD " href="{{route('user.login')}}">Acces Now</a>
                </div>
            </div>
        </div>
    </section>

    @if($sections->secs != null)
        @foreach(json_decode($sections->secs) as $sec)
            @include($activeTemplate.'sections.'.$sec)
        @endforeach
    @endif

@endsection
