{var $iconSrc = $icons == 'cross' ? '/assets/img/icons/cross.png' : '/assets/img/icons/approve-icon.svg'}
<div class="included-options-section">
    <h2 class="subsection-title">{$title}</h2>
    <div class="included-options-grid">

        {foreach $items as $item}
            <div class="item">
                <img src="{$iconSrc}" alt="" class="icon">
                <div class="text">{$item['name']}</div>
            </div>
        {/foreach}    
    </div>
</div>