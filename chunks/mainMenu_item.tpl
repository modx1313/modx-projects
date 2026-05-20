{var $href = $link}
{var $tripsPageId = 285}
{var $excPageId = 570}
{var $shipsPageId = 631}
{var $yachtsPageId = 632}
{var $piersPageId = 276}
{var $addShipsLinkId = 355} 

{var $isExc = $id == $excPageId}

{var $cityData = 'getCityRelatedData' | snippet}

{if $id == $tripsPageId}
    {set $href = '/'}
{elseif $id == $excPageId}
    {if $cityData['name'] == 'msk'}
        {set $href = 571 | url}
    {else}
        {set $href = false}
    {/if}
{elseif $id == $shipsPageId}
    {set $href = $cityData['shipsId'] | url}
{elseif $id == $yachtsPageId}
    {set $href = $cityData['yachtsId'] | url}
{elseif $id == $piersPageId}
    {set $href = $cityData['piersId'] | url}
{/if}

{if $href}
    <li[[+classes]] [[+attributes]]>
        <a class="link" href="{$href}">
            <div>[[+menutitle]]</div>
        </a>
        [[+wrapper]]
    </li>
    {if $id == $addShipsLinkId}
        <li[[+classes]] [[+attributes]]>
            <a class="link" href="{754 | url}">
                <div>Теплоходы</div>
            </a>
        </li>
    {/if}
{/if}
