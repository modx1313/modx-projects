{var $marginClass = $type != 'yacht' ? 'margin-top' : ''}
{var $isCatalogPage = $_modx->resource.parent == 754}

<div class="ship-main-section base-width content-block-margin">
    <div class="content-block">
        <div class="bar-anchor-wrapper">
            <div class="anchor" id="ship-info-anchor"></div>
        </div>
        
        {'description_block' | chunk : [
            'text' => $_modx->resource.content,
        ]}
        
        <div class="bar-anchor-wrapper">
            <div class="anchor" id="ship-features-anchor"></div>
        </div>        
        <div class="top-border-line">
            <div class="features-wrapper">
            
                {'featuresSection' | chunk : [
                   'title' => 'Особенности',
                   'items' => $features
                ]}
                
                {'featuresSection' | chunk : [
                   'title' => ' ',
                   'icons' => 'cross',
                   'items' => $featuresCross
                ]}
                
            </div>
        </div>
        
        <div class="desktop">
            {'riverTrip.additionalSection' | chunk : [
                'type' => 'Дополнительная информация',
                'opened' => '1'
            ]}
        </div>
        
        <div class="mobile">
            {'riverTrip.additionalSection' | chunk : [
                'type' => 'Дополнительная информация',
                'opened' => '0'
            ]}
        </div>
        
        {var $mealMenuJson = 'getResourceTV' | snippet : [
          'tvId' => 165,
          'resourceId' => 'id' | resource
        ]}
        
        {if $mealMenuJson && $mealMenuJson != 'error_result'}
            {'riverTrip.additionalSection' | chunk : [
                'type' => 'Меню на борту теплохода',
                'opened' => '0'
            ]}
        {/if}

    </div>
    
    {if !$isCatalogPage}
        <div class="details-block">
        {if $type != 'yacht'}
            <div class="title">Стоимость питания</div>
        {/if}
        <div>        
            {if 'tv.shipBanquetPrice' | resource}
                <div class="detail strong">
                    <div class="name">Банкет:</div>
                    <div class="value">от {'tv.shipBanquetPrice' | resource} руб/чел</div>
                </div>
            {/if}
            {if 'tv.shipBanquetCapacity' | resource}
                <div class="detail">
                    <div class="name">Вместимость:</div>
                    <div class="value">до {'tv.shipBanquetCapacity' | resource} гостей</div>
                </div>
            {/if}
            {if 'tv.shipBuffetPrice' | resource}
                <div class="detail strong">
                    <div class="name">Фуршет:</div>
                    <div class="value">от {'tv.shipBuffetPrice' | resource} руб/чел</div>
                </div>
            {/if}
            {if 'tv.shipBuffetCapacity' | resource}
                <div class="detail">
                    <div class="name">Вместимость:</div>
                    <div class="value">до {'tv.shipBuffetCapacity' | resource} гостей</div>
                </div>
            {/if}
            {if 'tv.shipService' | resource}
                <div class="detail strong">
                    <div class="name">Обслуживание:</div>
                    <div class="value">{'tv.shipService' | resource}</div>
                </div>
            {/if}
        </div>
        <div class="title {$marginClass}">Стоимость аренды</div>
        <div>
            {if 'tv.shipMondayPrice' | resource}
                <div class="detail">
                    <div class="name">Понедельник:</div>
                    <div class="value">{'tv.shipMondayPrice' | resource} руб/час</div>
                </div>
            {/if}
            {if 'tv.shipTuesdayPrice' | resource}
                <div class="detail">
                    <div class="name">Вторник:</div>
                    <div class="value">{'tv.shipTuesdayPrice' | resource} руб/час</div>
                </div>
            {/if}
            {if 'tv.shipWednesdayPrice' | resource}
                <div class="detail">
                    <div class="name">Среда:</div>
                    <div class="value">{'tv.shipWednesdayPrice' | resource} руб/час</div>
                </div>
            {/if}
            {if 'tv.shipThursdayPrice' | resource}
                <div class="detail">
                    <div class="name">Четверг:</div>
                    <div class="value">{'tv.shipThursdayPrice' | resource} руб/час</div>
                </div>
            {/if}            
            {if 'tv.shipFridayPrice' | resource}
                <div class="detail">
                    <div class="name">Пятница:</div>
                    <div class="value">{'tv.shipFridayPrice' | resource} руб/час</div>
                </div>
            {/if}            
            {if 'tv.shipSaturdayPrice' | resource}
                <div class="detail">
                    <div class="name">Суббота:</div>
                    <div class="value">{'tv.shipSaturdayPrice' | resource} руб/час</div>
                </div>
            {/if}
            {if 'tv.shipSundayPrice' | resource}
                <div class="detail">
                    <div class="name">Воскресенье:</div>
                    <div class="value">{'tv.shipSundayPrice' | resource} руб/час</div>
                </div>
            {/if}
        </div>
        
        <button class="base-button filled" data-hystmodal="#ship-modal-form" data-id="{'id' | resource}" data-name="{'pagetitle' | resource}">
            Оставить заявку
        </button>
    </div>
    {/if}
</div>