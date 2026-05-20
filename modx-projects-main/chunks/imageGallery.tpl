<div class="gallery-wrapper">

    <div class="gallery-slider js-gallery-swiper">
        <div class="swiper-wrapper">
            [[getChunkCollection?
            	&tpl=`gallerySwiperItem`
            	&valuesJson=`[[*imageGallery]]`
            ]]
        </div>
        <div class="slider-button-prev round js-slider-button-prev pointer noselect always-visible"></div>
        <div class="slider-button-next round js-slider-button-next pointer noselect always-visible"></div>
        <div class="swiper-pagination"></div>
    </div>

    <div class="gallery-static-section">
        [[getImageList?
            &tvname=`imageGallery`
            &tpl=`galleryStaticItem`
            &offset=`1`
            &limit=`4`
        ]]
    </div>

</div>