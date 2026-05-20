
<div class="similar-events-section base-width content-block-margin">
    <div class="section-title">[[+title]]</div>
    <div class="swiper-container">
        <div class="river-trip-slider js-similar-trips-swiper[[+classModifier]]">
            <div class="swiper-wrapper">
                {if $tripData}
                    {'getChunkCollection' | snippet : [
                        'tpl' => 'riverTrip.sliderItem',
                        'valuesJson' => $tripData
                    ]}
                {else}
                    [[getChunkCollection?
                	    &tpl=`riverTrip.sliderItem`
                	    &valuesJson=`[[+riverTripSliderJson]]`
                    ]]
                {/if}
            </div>
        </div>
        <div class="slider-button-prev round js-similar-trips-slider{$classModifier}-button-prev js-hidden pointer noselect"></div>
        <div class="slider-button-next round js-similar-trips-slider{$classModifier}-button-next js-hidden pointer noselect"></div>
    </div>
</div>