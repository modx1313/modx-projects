{var $pageId = 'id' | resource}
{var $isExcPage = $pageId == 571}

<div 
    class="item noselect pointer js-filter-item [[+additionalClasses]]" 
    data-filter-name="[[+filterName]]" 
    data-filter-type="[[+filterType]]" 
    data-global-min="[[+minPrice]]"
    data-global-max="[[+maxPrice]]"
    data-current-min="[[+minPrice]]"
    data-current-max="[[+maxPrice]]">
    <div class="wrapper">
        {if $filterType != 'price'}
        <div class="title js-filter-toggle">
            {if $filterName == 'ships'}
            <div class="catalog-filters__field-label">[[+title]]</div>
            <div class="text js-filter-title" data-default-value="[[+defaultValue]]">[[+defaultValue]]</div>
            {else}
            <div class="text js-filter-title" data-default-value="[[+title]]">[[+title]]</div>
            {/if}
            <img class="expand icon" src="/assets/img/icons/down-arrow-medium.svg" alt="раскрыть фильтр">
            <img class="collapse icon" src="/assets/img/icons/up-arrow-medium.svg" alt="свернуть фильтр">
            <img class="close icon" src="/assets/img/icons/close-icon.svg" alt="свернуть фильтр">
        </div>
        {/if}

        {if $filterType == 'list'}
        <div class="js-ajax-insert values-section js-filter-values">
            {if $filterName == 'ships'}
            <div class="row js-apply-filter js-ships-filter-all active" data-value-id="">Все модели</div>
            {/if}
            {'getChunkCollection' | snippet : [
                'tpl' => 'filterValueRow',
                'valuesJson' => $json,
                'debug' => 1
            ]}
        </div>
        {/if}
        
        {if $filterType == 'price'}
            <div class="price-section">
              <div class="catalog-filters__group-label">[[+title]]</div>
              <div class="js-price-input-section price-input">
                <div class="field">
                    <div class="text">Мин. цена</div>
                    <input type="number" class="js-input-min input-min js-price-input" value="{$minPrice}">
                    <div class="ruble">₽</div>

                </div>
                <div class="price-separator" aria-hidden="true"></div>
                <div class="field">
                    <div class="text">Макс. цена</div>
                    <input type="number" class="js-input-max input-max js-price-input" value="{$maxPrice}">
                    <div class="ruble">₽</div>
                </div>
              </div>
              <div class="slider">
                <div class="progress js-price-progress"></div>
              </div>
              <div class="js-range-input-section range-input">
                <input type="range" class="js-range-min js-range-input range-min" min="{$minPrice}" max="{$maxPrice}" value="{$minPrice}" step="1">
                <input type="range" class="js-range-max js-range-input range-max" min="{$minPrice}" max="{$maxPrice}" value="{$maxPrice}" step="1">
              </div>
              <button class="base-button filled pointer noselect js-apply-filter">Готово</button>
            </div>
            <div class="no-options-section">Нет доступных опций</div>
        {/if}
    </div>
</div>