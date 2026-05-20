<div class="page-text-section-background full-width">
    <div class="page-text-section base-width">
        <div class="section-title">{$title}</div>
        <div class="images js-homepage-textblock-swiper">
            <div class="swiper-wrapper">
                [[getChunkCollection?
                	&tpl=`homepage.textSectionImage`
                	&valuesJson=`{$images}`
                ]]
            </div>
            <div class="slider-button-prev white js-slider-button-prev pointer noselect"></div>
            <div class="slider-button-next white js-slider-button-next pointer noselect"></div>
        </div>
        <div class="article">
            {'description_block' | chunk : [
                'text' => $text,
                'limit' => 420
            ]}
        </div>
        
        
    </div>
</div>