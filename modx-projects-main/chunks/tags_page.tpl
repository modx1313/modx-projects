{var $data = '!tags.prepareData' | snippet}

<div class="homepage tagpage js-page-data" data-id="homepage">

    <div class="base-width content-block-margin">
        <a href="[[~[[*id]]]]#catalog-anchor" class="banner-section">
            <img src="[[pthumb? &input=`[[*tags.banner]]` &options=`w=1140&h=392&zc=1`]]" class="image" alt="">
            <div class="inner-wrapper">
                <div class="text">[[*tags.bannerText]]</div>
                <div class="base-button filled">{$data['buttonText']}</div>
            </div>
        </a>
    </div>
    
    <div class="anchor-wrapper">
        <div class="anchor" id="catalog-anchor"></div>
    </div>
    
    <h1 class="section-title base-width">[[*pagetitle]]</h1>
    
    <div class="base-width relative large-margin-bottom">
        <div class="extended-tags-section js-filter-item swiper-container js-extended-tags-swiper" data-filter-name="tag" data-filter-type="tag">
            <div class="swiper-wrapper">
                {'getChunkCollection' | snippet : [
                    'tpl' => 'extendedTagItem',
                    'valuesJson' => $data['extendedTagsJson']
                ]}
            </div>
            <div class="slider-button-prev js-slider-button-prev white pointer noselect"></div>
            <div class="slider-button-next js-slider-button-next white pointer noselect"></div>
        </div>
        <div class="swiper-scrollbar js-extended-tags-swiper-scrollbar"></div>
    </div>
    
    <div class="js-hidden js-text-tag-page" data-id="{$_modx->resource.id}"></div>
    
    [[$catalogFilterSection]]

    
    <div class="catalog-section base-width js-catalog-section" data-parent-id="[[+parentId]]" data-text-tag-id="[[*id]]" data-current-count="[[+currentCount]]" data-total-count="[[+totalCount]]">
        <div class="js-ajax-insert wrapper">
            {if $data['catalogItemsJson'] != '[]'}
                {'getChunkCollection' | snippet : [
                    'tpl' => 'catalogItem',
                    'valuesJson' => $data['catalogItemsJson']
                ]}
                
            {else}
                <div class="empty-result-text">В данный момент актуальных прогулок по данному тегу нет</div>
            {/if}
        </div>
        {if $data['showMoreItemsBtn'] == '1'}
            <button class="show-more-btn base-button transparent js-show-more-catalog-items">Показать еще</button>
            <img src="/assets/img/icons/circle-dots.gif" alt="" class="loading-items js-loading-items js-hidden">
        {/if}
        
    </div>

    {if $data['oldTripsSection'] == '1'}
        {'riverTrip.slider' | chunk : [
            'title' => 'Прошедшие прогулки'
            'tripData' => $data['riverTripSliderJson']
        ]}
    {/if}
    [[$tags.textSection]]
    [[$homepage.tagsSection]]
    [[$staticAdvantagesSection]]
    
    <div class="fixed-bar bottom" data-hystfixed>
        [[$showAllTripsSection]]
    </div>

    [[$fullImageModal]]
</div>