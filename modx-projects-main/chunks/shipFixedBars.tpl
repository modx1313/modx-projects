{var $url = 'id' | resource | url}

<div class="fixed-bar top js-river-trip-fixed-bar js-hidden js-top-bar-swiper" data-hystfixed>
    <div class="wrapper swiper-wrapper base-width">
        {if $type == 'ship'}
            <a class="swiper-slide" href="{$url}#ship-info-anchor">Описание теплохода</a>
            <a class="swiper-slide" href="{$url}#ship-features-anchor">Особенности теплохода</a>
            <a class="swiper-slide" href="{$url}#similar-ships-anchor">Похожие теплоходы</a>
            <a class="swiper-slide" href="{$url}#faq-anchor">Часто задаваемые вопросы</a>
        {else}
        
        {/if}
    </div>
</div>

<div class="fixed-bar bottom" data-hystfixed>
    <div class="wrapper base-width">
        <div class="main-price-section">
            <div class="prefix">от</div>
            <div class="main-price">
                {'tv.shipPrice' | resource} ₽
            </div>
        </div>

        <div class="base-button filled inactive" data-hystmodal="#ship-modal-form" data-id="{'id' | resource}" data-name="{'pagetitle' | resource}">
            Оставить заявку
        </div>
    </div>
</div>