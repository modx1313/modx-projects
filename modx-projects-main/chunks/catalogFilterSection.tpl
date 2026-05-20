{var $pageId = 'id' | resource}
{var $isExcPage = $pageId == 571}

<div class="base-width catalog-filters">
    <button class="catalog-filters__open-btn js-catalog-filters-open" type="button">
        <span>Фильтры</span>
    </button>

    <div class="relative filter-swiper-container catalog-filters__drawer js-catalog-filters-drawer">
        <div class="catalog-filters__backdrop js-catalog-filters-close"></div>
        <div class="catalog-filters__panel">
            <div class="catalog-filters__mobile-header">
                <div class="catalog-filters__mobile-title">
                    <span>Фильтры</span>
                </div>
                <button class="catalog-filters__close-btn js-catalog-filters-close" type="button" aria-label="Закрыть фильтры">
                    <img src="/assets/img/icons/close-icon.svg" alt="закрыть фильтры">
                </button>
            </div>

            <div class="filter-section">
                <div class="catalog-filters__items">

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
            
            {'catalogFilterItem' | chunk : [
                'title' => 'Временной интервал',
                'filterType' => 'list',
                'filterName' => 'interval',
                'json' => 'intervalJson' | placeholder
            ]}

            {if $isExcPage}
                {'catalogFilterItem' | chunk : [
                    'title' => 'Модель теплохода:',
                    'defaultValue' => 'Все модели',
                    'filterType' => 'list',
                    'filterName' => 'ships',
                    'additionalClasses' => 'js-hidden',
                    'json' => 'shipsJson' | placeholder
                ]}    
            {else}
                {'catalogFilterItem' | chunk : [
                    'title' => 'Модель теплохода:',
                    'defaultValue' => 'Все модели',
                    'filterType' => 'list',
                    'filterName' => 'ships',
                    'json' => 'shipsJson' | placeholder
                ]}    
            {/if}
                </div>
            </div>
            <div class="catalog-filters__mobile-actions">
                <button class="base-button filled pointer noselect js-catalog-filters-apply" type="button">Применить фильтры</button>
                <button class="base-button pointer noselect js-catalog-filters-reset" type="button">Сбросить фильтры</button>
            </div>
        </div>
    </div>
</div>
