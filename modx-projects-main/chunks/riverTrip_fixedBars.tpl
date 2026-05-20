{var $isPast = 'getTripStatus' | snippet}
{var $hideRoute = 'tv.hideRoute' | resource}

<div class="fixed-bar top js-river-trip-fixed-bar js-hidden js-top-bar-swiper" data-hystfixed>
    <div class="wrapper swiper-wrapper base-width">
        [[If?
           &subject=`[[+advantagesSection]]`
           &operator=`EQ`
           &operand=`1`
           &then=`<a class="swiper-slide" href="[[~[[*id]]]]#advantages-anchor">Что включено</a>`
           &else=``
        ]]
        
        {if $hideRoute != 'yes'}
            <a class="swiper-slide" href="[[~[[*id]]]]#route-anchor">Маршрут</a>
        {/if}
        
        [[If?
           &subject=`[[+importantInformationSection]]`
           &operator=`EQ`
           &operand=`1`
           &then=`<a class="swiper-slide" href="[[~[[*id]]]]#info-anchor">Важная информация</a>`
           &else=``
        ]]

        <a class="swiper-slide" href="[[~[[*id]]]]#location-anchor">Расположение</a>

        [[If?
           &subject=`[[+mealOptionsSection]]`
           &operator=`EQ`
           &operand=`1`
           &then=`<a class="swiper-slide" href="[[~[[*id]]]]#meal-anchor">Меню</a>`
           &else=``
        ]]
        
        <a class="swiper-slide" href="[[~[[*id]]]]#refund-anchor">Возврат билетов</a>

        <a class="swiper-slide" href="[[~[[*id]]]]#questions-anchor">Вопросы</a>

    </div>
</div>

<div class="fixed-bar bottom" data-hystfixed>
    <div class="wrapper base-width">
        <div class="main-price-section">
            <div class="prefix">от</div>
            <div class="main-price">
                [[*price]] ₽
            </div>
            <div class="discount-wrapper">
                <div class="base-price">
                    [[*discountPrice]] ₽
                </div>
                <div class="discount-percent">
                    -[[*discountPercent]]%
                </div>
            </div>
        </div>
        {if !$isPast}
            {'buyButton' | chunk : [
                'classes' => 'base-button filled',
                'text' => 'Купить билеты'
            ]}
        {else}
            <div class="base-button filled inactive">Распродано</div>
        {/if}
    </div>
</div>