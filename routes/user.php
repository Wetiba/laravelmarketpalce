<?php

use Illuminate\Support\Facades\Route;

Route::namespace('User\Auth')->name('user.')->group(function () {

    Route::controller('LoginController')->group(function () {
        Route::get('/login', 'showLoginForm')->name('login');
        Route::post('/login', 'login');
        Route::get('logout', 'logout')->name('logout');
    });

    Route::controller('RegisterController')->group(function () {
        Route::get('register', 'showRegistrationForm')->name('register');
        Route::post('register', 'register')->middleware('registration.status');
        Route::post('check-mail', 'checkUser')->name('checkUser');
    });

    Route::controller('ForgotPasswordController')->group(function () {
        Route::get('password/reset', 'showLinkRequestForm')->name('password.request');
        Route::post('password/email', 'sendResetCodeEmail')->name('password.email');
        Route::get('password/code-verify', 'codeVerify')->name('password.code.verify');
        Route::post('password/verify-code', 'verifyCode')->name('password.verify.code');
    });
    Route::controller('ResetPasswordController')->group(function () {
        Route::post('password/reset', 'reset')->name('password.update');
        Route::get('password/reset/{token}', 'showResetForm')->name('password.reset');
    });
});

Route::middleware('auth')->name('user.')->group(function () {
    //authorization
    Route::namespace('User')->controller('AuthorizationController')->group(function () {
        Route::get('authorization', 'authorizeForm')->name('authorization');
        Route::get('resend-verify/{type}', 'sendVerifyCode')->name('send.verify.code');
        Route::post('verify-email', 'emailVerification')->name('verify.email');
        Route::post('verify-mobile', 'mobileVerification')->name('verify.mobile');
    });

    Route::middleware(['check.status'])->group(function () {

        Route::get('user-data', 'User\UserController@userData')->name('data');
        Route::post('user-data-submit', 'User\UserController@userDataSubmit')->name('data.submit');

        Route::middleware('registration.complete')->namespace('User')->group(function () {


            Route::controller('Customer\CustomerController')->group(function () {

                Route::get('customer/dashboard', 'Customer\CustomerController@index')->name('customer.dashboard');

                //Affiliate Coupon
                 Route::post('customer/affilitate-coupon' , 'Customer\CustomerController@addCoupon')->name('customer.affilitate-coupon');

                //Voucher
                Route::get('customer/voucher/notify/{id}', 'Customer\CustomerController@notifyVoucher')->name('customer.voucher-notify');

            });


            Route::controller('UserController')->group(function () {
                Route::get('dashboard', 'home')->name('home');

                //Report
                Route::any('payment/history', 'depositHistory')->name('deposit.history');

                Route::get('attachment-download/{fil_hash}', 'attachmentDownload')->name('attachment.download');
            });

            //Profile setting
            Route::controller('ProfileController')->group(function () {
                Route::get('profile-setting', 'profile')->name('profile.setting');
                Route::post('profile-setting', 'submitProfile');
                Route::get('change-password', 'changePassword')->name('change.password');
                Route::post('change-password', 'submitPassword');
            });

            //CouponController
            Route::controller('CouponController')->prefix('coupon')->name('coupon.')->group(function () {
                Route::get('all', 'allCoupons')->name('all');
                Route::get('pending', 'pendingCoupons')->name('pending');
                Route::get('active', 'activeCoupons')->name('active');
                Route::get('rejected', 'rejectedCoupons')->name('rejected');
                Route::get('expired', 'expiredCoupons')->name('expired');
                Route::get('add/{id?}', 'couponForm')->name('add');
                Route::post('save/{id?}', 'saveCoupon')->name('save');
                Route::post('status/{id}', 'changeStatus')->name('status');
                Route::get('boost/{id}', 'boost')->name('boost');
                Route::post('boost/process', 'boostingProcess')->name('boost.process');
                Route::get('view-report/{id}', 'viewReport')->name('report');
            });
            Route::controller('CouponController')->prefix('store')->name('store.')->group(function () {
                Route::get('all', 'stores')->name('index');
                Route::post('save/{id?}', 'saveStore')->name('save');
            });
        });

        // Payment
        Route::middleware('registration.complete')->controller('Gateway\PaymentController')->group(function () {
            Route::any('/payment', 'deposit')->name('deposit');
            Route::post('payment/insert', 'depositInsert')->name('deposit.insert');
            Route::get('payment/confirm', 'depositConfirm')->name('deposit.confirm');
            Route::get('payment/manual', 'manualDepositConfirm')->name('deposit.manual.confirm');
            Route::post('payment/manual', 'manualDepositUpdate')->name('deposit.manual.update');
        });
    });
});
