@php
    $policyPages = getContent('policy_pages.element',false,null,true);
@endphp
<footer class="footer-section">
    <div class="footer-section__top">
        <div class="container">
            <div class="row justify-content-center">

                <div class="col-lg-4">

                    <p class="text-white">@lang('Copyright') &copy; {{ date('Y') }} <a href="{{ route('home') }}">{{ __($general->sitename ) }}</a>. @lang('All Right Reserved')</p>

                </div>
                <div class="col-lg-8 text-end">
                    <ul class="footer-inline-link justify-content-end" >
                        @foreach($policyPages as $policy)
                            <li>
                                <a href="{{ route('policy.pages',[slug($policy->data_values->title),$policy->id]) }}">{{ __($policy->data_values->title) }}</a>
                            </li>
                        @endforeach
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="footer-section__bottom">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                </div>
            </div>
        </div>
    </div>
</footer>
