<div class="article-groups base-width {$view}">
    
    {foreach $groups as $group}
        {if $group['count'] == 1}
            {continue}
        {/if}
        
        <div 
            class="group content-block-margin js-article-group" 
            data-total-count="{$group['count']}" 
            data-current-count="{$limit}" 
            data-group-id="{$group['id']}">
            
            <div class="section-title">{$group['name']}</div>
            
            <div class="grid js-ajax-insert">
                {'pdoResources' | snippet : [
                    'parents' => 141,
                    'tvFilters' => 'article.group==' ~ $group['id'],
                    'tpl' => 'article.slide',
                    'limit' => $limit,
                    'includeTVs' => 'article.previewImage,article.group,photoTagColor,photoTagText'
                ]}
                
            </div>
            
            {if $group['count'] > $limit}        
                <button class="base-button transparent show-more-button js-show-more-articles">
                    Показать еще
                </button>
                <img src="/assets/img/icons/circle-dots.gif" alt="" class="loading-items js-loading-items js-hidden">
            {/if}
        </div>
    {/foreach}
</div>
