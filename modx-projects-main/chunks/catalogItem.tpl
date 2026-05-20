{var $img = '/assets/resourceimages/'~$id~'/'~$mainImage}
{var $isPast = 'getIsPast' | snippet : ['parent' => $parent]}

<div class="catalog-item">
    <a href="[[+uri]]">
        <div class="image">
            <img
                src=""
                data-src="{$img | pthumb : 'w=450&h=300&zc=1'}?v1"
                alt="[[+alt]]" 
                class="lazyload"
            />
            <div class="tag" style="background-color: [[+photoTagColor]]">{$photoTagText}</div>
        </div>
    </a>
    <a href="[[+uri]]">
        <div class="title">
            [[If?
               &subject=`[[+shortTitle]]`
               &operator=`EQ`
               &operand=``
               &then=`[[+pagetitle]]`
               &else=`[[+shortTitle]]`
            ]]
        </div>
    </a>
    
    <div class="info">
        <div class="catalog-item__info-wrapper">
            <div class="item">
                <img class="icon" src="/assets/img/icons/timer-icon.svg" alt="продолжительность">
                <div class="text">[[+duration]]</div>
            </div>
            <div class="item">
                <img class="icon" src="/assets/img/icons/metro-icon.svg" alt="место отправления">
                <div class="text">[[+metro]]</div>
            </div>
        </div>
        <div class="item">
            <img class="icon" src="/assets/img/icons/location-icon-lines.svg" alt="Причал">
            <div class="text">{$tripPiers | resource : 'pagetitle'}</div>
        </div>
    </div>
    

    <div class="advantages">
        [[getChunkCollection?
        	&tpl=`riverTrip.previewItemAdvantage`
        	&valuesLinesSeparated=`[[+previewAdvantages]]`
        	&migxReferenceTvId=`24`
        	&quantity=`8`
        ]]
    </div>
    
    {var $isTeplohodInfoService = $ticketsServiceType == 'teplohod.info'}

    
    {if !$isPast && $isTeplohodInfoService && $teplohodServiceId}
            <div class="teplohod-widget-nearest">
                <div class="name">Ближайшие рейсы</div>
                <div data-bind="teplohod-widget-nearest" data-widget_id="12468" data-event_id="{$teplohodServiceId}" data-date="nearest" data-limit="5" class="widget-loaded">
                    <div class="nearest-widget-empty"></div>
                </div>
            </div>

    {/if}


    <div class="catalog-item__price-wrapper">
        <div class="price">
            <div class="base">
                <span class="price-prefix">от</span>{$price} <span class="ruble">₽</span>
            </div>
            <div class="discount">
                {$discountPrice} <span class="ruble">₽</span>
            </div>
            <div class="percent">
                -{$discountPercent}%
            </div>
        </div>
        {var $hideRatingClass = intval($rating) ? '' : 'hide'}
        <div class="rating {$hideRatingClass}">
            [[getRatingStars? &rating=`[[+rating]]`]]
            <div class="number">
                {$rating}
            </div>
        </div>
    </div>
    
    <div class="buttons">
        <a href="[[+uri]]" class="base-button transparent">Подробнее</a>
        
        {if is_null($ticketsServiceType)}
            {var $ticketsId = $teplohodServiceId}
            {set $ticketsServiceType = 'teplohod.info'}
        {/if}
        {if $ticketsServiceType == 'teplohod.info'}
            {var $ticketsId = $teplohodServiceId}
        {/if}
        {if $ticketsServiceType == 'radario.ru'}
            {var $ticketsId = $radarioServiceId}
        {/if}
        {if $ticketsServiceType == 'незабываемая.москва'}
            {var $ticketsId = $nzMoskvaServiceId}
        {/if}
        
        {if !$isPast}
            {'buyButton' | chunk : [
                'classes' => 'base-button filled',
                'text' => 'Купить билеты',
                'ticketsId' => $ticketsId,
                'ticketsServiceType' => $ticketsServiceType
            ]}
        {else}
            <div class="base-button filled">Распродано</div>
        {/if}
        
    </div>
</div>