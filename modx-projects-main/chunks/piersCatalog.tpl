{var $city = 'getCityRelatedData' | snippet}
{var $limit = 6}
{var $total = 'pdoResources' | snippet : ['parents' => $city['piersId'], 'returnIds' => 1, 'limit' => 0] | split : ',' | length}
{var $current = $total > $limit ? $limit : $total}
{var $button = $total > $limit}


<div class="base-width content-block-margin piers-catalog js-piers-catalog" data-parent-id={$city['piersId']} data-current-count="{$current}" data-total-count="{$total}">
    <div class="js-ajax-insert wrapper">
        {'pdoResources' | snippet : [
            'parents' => $city['piersId'],
            'limit' => $limit,
            'tpl' => 'pierItem',
            'sortby' => 'menuindex',
            'sortdir' => 'ASC',
            'includeTVs' => 'pierPreviewImage,pierSubwayStation,pierAddress,photoTagColor,photoTagText'
        ]}
    </div>
    
    {if $button}
        <button class="show-more-btn base-button transparent js-show-more-piers">Показать еще</button>
        <img src="/assets/img/icons/circle-dots.gif" alt="" class="loading-items js-loading-items js-hidden">
    {/if}
</div>