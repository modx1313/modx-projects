{var $city = 'getCityRelatedData' | snippet}
{var $parentId = $type == 'ship' ? $city['shipsId'] : $city['yachtsId']}

{var $isCatalogPage = $_modx->resource.id == 754}
{set $parentId = $isCatalogPage ? 754 : $parentId}
{var $template = $isCatalogPage ? 'shipCatalog.item' : 'ship.item'}


{var $limit = 6}
{if !$total}
    {var $total = 'pdoResources' | snippet : [
        'parents' => $parentId,
        'returnIds' => 1,
        'limit' => 0
    ] | split | length}
{/if}
<div 
    class="base-width content-block-margin ships-catalog js-ships-catalog" 
    data-total-count="{$total}" data-current-count="{$limit}" 
    data-limit="{$limit}"
    data-parent-id="{$parentId}"
    data-filter-tag
    data-sort="popularity"
>
    <h2 class="section-title">{$title}</h2>
    
    <div class="wrapper js-ajax-insert">
        
        {'pdoResources' | snippet : [
            'parents' => $parentId,
            'limit' => 6,
            'sortby' => 'menuindex',
            'sortdir' => 'ASC',
            'tpl' => $template,
            'resources' => $shipsIds,
            'includeTVs' => 'shipCapacity,shipBanquetPrice,shipBuffetPrice,shipPrice,previewImage,photoTagColor,photoTagText,shipsFilter,shipStatus,availableTripsForShip'
        ]}
    </div>
    {if $total > $limit}        
        <button class="base-button transparent show-more-button js-show-more-ships">
            Показать еще
        </button>
        <img src="/assets/img/icons/circle-dots.gif" alt="" class="loading-items js-loading-items js-hidden">
    {/if}
</div>