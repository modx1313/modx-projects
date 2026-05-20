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

<div class="fixed-bar bottom ship-catalog" data-hystfixed>
    <div class="wrapper base-width">

        <div class="flex-wrapper">
            <div class="text">Не нашли подходящего варианта?</div>
            <a href="{754 | url}" class="link base-button filled">Посмотреть весь каталог теплоходов</a>
        </div>
      
    </div>
</div>