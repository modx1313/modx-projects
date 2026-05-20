{var $ticketsServiceId = $ticketsId ?: 'tv.teplohodServiceId' | resource}

<a 
    class="{$classes}" 
    href="javascript:;" 
    data-fancyboxtkt="1" 
    data-toolbar="0" 
    data-infobar="0" 
    data-arrows="0" 
    data-touch="0" 
    data-animationeffect="0" 
    data-keyboard="0" 
    data-type="iframe" 
    data-src="https://account.teplohod.info/order/event-order?widget_id=7491&event_id={$ticketsServiceId}"
>
    {if $text}
        {$text}
    {else}
        Купить билеты
    {/if}
</a>