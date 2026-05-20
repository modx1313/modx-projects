{var $href = $link}
{var $isExc = $id == 570}

{if $id == 285}
    {set $href = '/'}
{elseif $id == 276}
    {set $href = 8 | url}
{elseif $id == 631}
    {set $href = 196 | url}
{elseif $id == 632}
    {set $href = 197 | url}
{/if}


{if !$isExc}

    <li[[+classes]] [[+attributes]]>
        <a class="link" href="{$href}">
            <div>[[+menutitle]]</div>
            <img src="/assets/img/icons/right-arrow-white.svg" alt="раскрыть меню" class="open-menu-icon">
        </a>
        <div class="link">
            <div>[[+menutitle]]</div>
            <img src="/assets/img/icons/right-arrow-white.svg" alt="раскрыть меню" class="open-menu-icon">
        </div>
        [[+wrapper]]
    </li>

{else}

    <li[[+classes]] [[+attributes]] data-type="excursion">
        <a class="link" style="display:flex" href="{571 | url}">
            <div>Экскурсии</div>
        </a>
        [[+wrapper]]
    </li>

{/if}