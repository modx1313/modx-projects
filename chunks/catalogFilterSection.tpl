{var $pageId = 'id' | resource}
{var $isExcPage = $pageId == 571}

<div class="base-width relative filter-swiper-container">
    <div class="filter-section js-filter-items-swiper">
        <div class="swiper-wrapper">

            {'catalogFilterItem' | chunk : [
                'title' => 'Цена',
                'filterType' => 'price',
                'filterName' => 'price',
                'minPrice' => 'minPrice' | placeholder
                'maxPrice' => 'maxPrice' | placeholder
            ]}    

            {'catalogFilterItem' | chunk : [
                'title' => 'Продолжительность',
                'filterType' => 'list',
                'filterName' => 'duration',
                'json' => 'durationJson' | placeholder
            ]}    
            
            {if $isExcPage}
                {'catalogFilterItem' | chunk : [
                    'title' => 'Теплоход',
                    'filterType' => 'list',
                    'filterName' => 'ships',
                    'additionalClasses' => 'js-hidden',
                    'json' => 'shipsJson' | placeholder
                ]}    
            {else}
                {'catalogFilterItem' | chunk : [
                    'title' => 'Теплоход',
                    'filterType' => 'list',
                    'filterName' => 'ships',
                    'json' => 'shipsJson' | placeholder
                ]}    
            {/if}
            
            {'catalogFilterItem' | chunk : [
                'title' => 'Временной интервал',
                'filterType' => 'list',
                'filterName' => 'interval',
                'json' => 'intervalJson' | placeholder
            ]}    
        </div>
    </div>
    <div class="swiper-scrollbar js-filter-items-swiper-scrollbar"></div>
</div>
