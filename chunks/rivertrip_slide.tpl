{if $disabled != 1}
    <a href="{$link}"class="swiper-slide rivertrip-slide">
        <img class="rivertrip-slide__image" src="{$img}" alt="баннер">
        <div class="rivertrip-slide__gradient"></div>
        <div class="rivertrip-slide__content">
                <h2 class="rivertrip-slide__title">{$title}</h2>
                <div class="rivertrip-slide__bottom">
                    <div class="rivertrip-slide__tabs">
                        <div class="rivertrip-slide__date-tab"><img src="/assets/img/icons/calendar.svg" alt="дата">{$date}</div>
                        <div class="rivertrip-slide__duration-tab"><img src="/assets/img/icons/clock.svg" alt="">{$duration}</div>
                    </div>
                    <div class="rivertrip-slide__price-block">
                        <div class="rivertrip-slide__price">{$price} ₽</div>
                        {if $old_price}
                            <div class="rivertrip-slide__old-price">{$old_price} ₽</div>
                        {/if}
                        {if $discount}
                            <div class="rivertrip-slide__discount">-{$discount}%</div>
                        {/if}
                    </div>
                    
                </div>
        
        </div>
    </a>
{/if}