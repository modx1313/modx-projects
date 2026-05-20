{var $isPast = 'getTripStatus' | snippet}
{var $url = 'id' | resource | url}
{var $hideGiftBtn = ('tv.hideGiftBtn' | resource) == 'Y'}

<div class="tickets-section">
    <div class="main-price-prefix">от</div>
    <div class="main-price-section">
        <div class="main-price">
            [[*price]] ₽
        </div>
        <div class="base-price">
            [[*discountPrice]] ₽
        </div>
        <div class="discount-percent">
            [[*discountPercent]]%
        </div>
    </div>

    {if !$isPast}
        {'buyButton' | chunk : [
            'classes' => 'base-button transparent',
            'text' => 'Открыть расписание',
            'hideNzMoskvaButton' => 1
        ]}
    {else}
        <div class="base-button transparent inactive">
            Распродано
        </div>
    {/if}
    
    
    {if !$isPast}
        <button class="base-button transparent" data-hystmodal="#tickets-modal">Стоимость и категории билетов</button>
    
        {'buyButton' | chunk : [
            'classes' => 'base-button filled',
            'text' => 'Купить билеты',
            'hideNzMoskvaButton' => 1
        ]}
    {/if}

    <div class="money-return">
        <img src="/assets/img/icons/money-return-icon.svg" alt="" class="icon">
        <div class="text">
                {'getMigxValuesById' | snippet : [
                    'parametersTvId' => 144,
                    'valueIdsArr' => 'tv.ticketsReturnInformationShort' | resource,
                    'fieldName' => 'text'
                ]}
        </div>
    </div>
    
    {if !$isPast && !$hideGiftBtn}
        <div class="gift-button noselect pointer hover" data-hystmodal="#gifts-modal">
            <img src="/assets/img/icons/gift-icon.svg" alt="" class="icon">
            <div class="text">Подарить</div>
        </div>
    {/if}
</div>
