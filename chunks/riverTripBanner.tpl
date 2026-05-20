{if $_modx->resource.slider_rivertrip}
<div class="base-width">
    
    <div class="rivertrip-slider">
        <div class="swiper-wrapper">
            {'getImageList' | snippet : [
                'tvname' => 'slider_rivertrip',
                'tpl' => 'rivertrip_slide'
            ]}
        </div>
        <div class="slider-button-prev round"></div>
        <div class="slider-button-next round"></div>
        <div class="swiper-pagination"></div>
    </div>
</div>
{/if}