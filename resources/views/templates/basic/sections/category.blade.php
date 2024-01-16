@php
    $category = getContent('category.content', true);
    $categories = \App\Models\Category::where('status', 1)->latest()->get();
@endphp
<div class="category-section section--bg2">
    <div class="container">
        <div class="row gy-4">
            <div class="col-lg-3">
                <div class="category-content justify-content-lg-start justify-content-center">
                    <h3 class="category-title">{{ __($category->data_values->heading) }}</h3>
                </div>
            </div>
            <div class="col-lg-9 ps-lg-4">
                <div class="category-slider">
                    @foreach($categories as $category)
                        <div class="single-slide">
                            <div class="category-item has--link">
                                <a href="{{ route('coupon.filter.type', ['category', $category->id]) }}" class="item--link"></a>
                                @php echo $category->icon @endphp
                                <p class="caption">{{ __($category->name) }}</p>
                            </div>
                        </div>
                    @endforeach
                </div>
            </div>
        </div>
    </div>
</div>
