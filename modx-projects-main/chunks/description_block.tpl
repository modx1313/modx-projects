{var $textLimit = $limit ?: 345} 
{var $textLimitMobile = $limit ?: 130} 

<div class="description-wrapper js-description">
    <div class="description">
        <span class="text full">
            {$text}
        </span>
    </div>
    
    {if $text | length > $textLimit}
        <button class="expand-description-btn desktop js-expand-description noselect pointer">
            Подробнее
        </button>
    {/if}
    {if $text | length > $textLimitMobile}
        <button class="expand-description-btn mobile js-expand-description noselect pointer">
            Подробнее
        </button>
    {/if}
</div>

