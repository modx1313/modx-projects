<div class="images-title">Фотографии клиентов</div>

<div class="images-slider js-reviews-images-swiper">
    <div class="swiper-wrapper">
        [[!getChunkCollection?
            &tpl=`reviewImageSliderItem`
            &valuesJson=`[[+reviewsImagesJson]]`
            &placeholder=`image`
            &quantity=`10`
        ]]
    </div>
    
    <div class="slider-button-prev white js-slider-button-prev js-hidden pointer noselect"></div>
    <div class="slider-button-next white js-slider-button-next js-hidden pointer noselect"></div>
    
</div>