[[homepage.prepareData]]
[[!homepage.prepareUncachedData]]


<div class="homepage js-page-data" data-id="homepage">
    <div class="main-banner-section base-width">
        [[getImageList? 
            &tvname=`mainBanner` 
            &tpl=`mainBanner`
            &limit=`1`
        ]]
    </div>
    
    <h1 class="main-title base-width">{'tv.mainTitle' | resource}</h1>
    
    <div class="base-width relative large-margin-bottom">
        <div class="extended-tags-section js-filter-item swiper-container js-extended-tags-swiper" data-filter-name="tag" data-filter-type="tag">
            <div class="swiper-wrapper">
                [[getChunkCollection? 
                    &tpl=`extendedTagItem`
                    &valuesJson=`[[+extendedTagsJson]]`
                ]]    
            </div>
            <div class="slider-button-prev js-slider-button-prev white pointer noselect"></div>
            <div class="slider-button-next js-slider-button-next white pointer noselect"></div>
        </div>
        <div class="swiper-scrollbar js-extended-tags-swiper-scrollbar"></div>
    </div>
    
    <h2 class="section-title base-width">Каталог экскурсий</h2>
    
    [[$catalogFilterSection]]
    
    <div class="catalog-section base-width js-catalog-section" data-parent-id=[[*id]] data-current-count=[[+currentCount]] data-total-count=[[+totalCount]]>
        <div class="js-ajax-insert wrapper">
            [[getChunkCollection?
                &tpl=`catalogItem`
                &valuesJson=`[[+catalogItemsJson]]`
            ]]
        </div>
            <button class="
                show-more-btn 
                base-button 
                transparent 
                js-show-more-catalog-items 
                {if [[+showMoreItemsBtn]] != '1'}
                    js-hidden
                {/if}
            ">Показать еще</button>
            <img src="/assets/img/icons/circle-dots.gif" alt="" class="loading-items js-loading-items js-hidden">
        
    </div>
    
    [[$homepage.subscribeSection]]
    [[$homepage.articlesSection]]
    [[$homepage.textSection]]
    [[!$homepage.reviewsSection]]

    [[$homepage.tagsSection]]
    [[$staticAdvantagesSection]]

    [[$fullImageModal]]
</div>