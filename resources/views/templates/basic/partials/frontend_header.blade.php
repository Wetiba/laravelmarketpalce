@php
    $contact = getContent('contact_us.content', true);
    $socials = getContent('social_icon.element',false,null,true);
@endphp
<header class="header">
    @include($activeTemplate.'partials.top_header')
    <div class="header__bottom mt-2" >
        <div class="container">
            <nav class="navbar navbar-expand-xl align-items-center">
                <a class="site-logo site-title" href="{{ route('home') }}">
                    <img src="{{ getImage(getFilePath('logoIcon') .'/logo.png') }}"
                        alt="logo">
                </a>
                <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="menu-toggle"></span>
                </button>
                <div class="collapse navbar-collapse mt-lg-0 mt-3" id="navbarSupportedContent">
                    <ul class="w-100  text-end">
                        <li><a class="btn btn-primary p-2" href="https://buckleupsavings.com/">@lang('Home')</a></li>

                    </ul>
                    <div class="">

                    </div>
                </div>
            </nav>
        </div>
    </div><!-- header__bottom end -->
</header>
