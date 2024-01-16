@php
    $contact = getContent('contact_us.content', true);
    $socials = getContent('social_icon.element', false, null, true);
@endphp
<header class="header">
    @include($activeTemplate . 'partials.top_header')
    <div class="header__bottom">
        <div class="container">
            <nav class="navbar navbar-expand-xl align-items-center">
                <a class="site-logo site-title" href="{{ route('home') }}">
                    <img src="{{ getImage(getFilePath('logoIcon') . '/logo.png') }}" alt="logo">
                </a>
                <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                    <span class="menu-toggle"></span>
                </button>
                <div class="collapse navbar-collapse mt-lg-0 mt-3" id="navbarSupportedContent">
                    <ul class="navbar-nav main-menu m-auto">
                        <li><a href="{{ route('user.home') }}">@lang('Dashboard')</a></li>
                        <li class="menu_has_children">
                            <a href="javascript:void(0)">@lang('Customer')</a>

                            <ul class="sub-menu">
                                <li><a href="{{ route('user.customer.dashboard') }}">@lang('Dashboard')</a></li>
                            </ul>

                        </li>


                        <li class="menu_has_children">
                            <a href="javascript:void(0)">@lang('Cards')</a>


                            <ul class="sub-menu">
                                <li><a href="{{ route('user.coupon.add') }}">@lang('Add New')</a></li>
                                <li><a href="{{ route('user.coupon.all') }}">@lang('All Cards')</a></li>
                                <li><a href="{{ route('user.coupon.pending') }}">@lang('Pending Cards')</a></li>
                                <li><a href="{{ route('user.coupon.active') }}">@lang('Active Cards')</a></li>
                                <li><a href="{{ route('user.coupon.expired') }}">@lang('Expired Cards')</a></li>
                                <li><a href="{{ route('user.coupon.rejected') }}">@lang('Rejected Cards')</a></li>
                            </ul>
                        </li>
                        <li><a href="{{ route('user.store.index') }}">@lang('My Stores')</a></li>

                        <li><a href="{{ route('user.deposit.history') }}">@lang('Payment History')</a></li>
                        <li><a href="{{ route('user.deposit.history') }}">@lang('Transactions')</a></li>

                        <li class="menu_has_children">
                            <a href="javascript:void(0)">@lang('Account')</a>
                            <ul class="sub-menu">
                                <li><a href="{{ route('user.profile.setting') }}">@lang('Profile Setting')</a></li>
                                <li><a href="{{ route('user.change.password') }}">@lang('Change Password')</a></li>
                                <li><a href="{{ route('ticket') }}">@lang('Support Tickets')</a></li>
                            </ul>
                        </li>
                    </ul>
                    <div class="nav-right justify-content-xl-end">

                         <p><span>Vendor: <strong>$ {{getBalance(auth()->user()->id, 'vendor')}} </strong> |    </span> <span>Customer: <strong>$ {{getBalance(auth()->user()->id, 'customer')}} </strong> </span> </p>

                    </div>
                </div>
            </nav>
        </div>
    </div>
</header>
