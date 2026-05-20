<div class="text-section-background full-width">
    <div class="text-section base-width">
        <div class="section-title">[[*tags.textBlockTitle]]</div>
        <div class="images js-homepage-textblock-swiper">
            <div class="swiper-wrapper">
                [[getChunkCollection?
                	&tpl=`textSectionImage`
                	&valuesJson=`[[*tags.imageGallery]]`
                ]]
            </div>
            <div class="slider-button-prev white js-slider-button-prev pointer noselect"></div>
            <div class="slider-button-next white js-slider-button-next pointer noselect"></div>
        </div>
        <div class="article">
            {'description_block' | chunk : [
                'text' => 'content' | resource,
                'limit' => 420
            ]}
        </div>
    </div>
</div>