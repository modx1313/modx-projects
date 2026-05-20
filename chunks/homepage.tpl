[[homepage.prepareData]]
[[!homepage.prepareUncachedData]]

{var $pageId = $_modx->resource.id}

<div class="homepage js-page-data" data-id="[[+resourceType]]">
    {if in_array($_modx->resource.parent, [285,570])}
        [[$riverTripBanner]]
    {else}
        <div class="main-banner-section base-width">
            [[getImageList? 
                &tvname=`mainBanner` 
                &tpl=`mainBanner`
                &limit=`1`
            ]]
        </div>
    {/if}
    
    {if $pageId = 10}
        <h2 class="main-title base-width">{'tv.mainTitle' | resource}</h2>
    {else}
        <h1 class="main-title base-width">{'tv.mainTitle' | resource}</h1>
    {/if}
    
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
    
    <div class="catalog-filters-head base-width">
        <h2 class="section-title catalog-filters-head__title">[[+catalogTitle]]</h2>
        [[$catalogFilterSection]]
    </div>
    
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

    {'homepage.tagsSection' | chunk}
    
    {if $pageId == 10}
        <div class='base-width'>
            <h1 class="bottom-h1">
                Речные прогулки по Москве-реке
            </h1>
        </div>
    {/if}
    
    [[$staticAdvantagesSection]]

    [[$fullImageModal]]
</div>