{var $photoTagColor = $_modx->runSnippet('getMigxValuesById', [
    'valueIdsArr' => [$_pls['tv.photoTagColor']],
    'parametersTvId' => 48
]) | fromJSON}

{var $trips = $_modx->runSnippet('getFilterData', ['pier' => $id]) | fromJSON}
{var $tripsCount = $trips['count']['total'] ?: 0}
{var $url = $id | url}


<div class="item">
    <a href="{$url}">
        <div class="image">
            <img data-src="{$_pls['tv.pierPreviewImage'] | pthumb : 'w=457&h=310&zc=1'}" alt="[[+alt]]" class="lazyload"/>
            <div class="tag" style="background-color: {$photoTagColor[0]['color']}">{$_pls['tv.photoTagText']}</div>
        </div>
    </a>
    <a href="{$url}">
        <div class="title">
           {$pagetitle}
        </div>
    </a>
    
    <div class="property">
        <img src="/assets/img/icons/pier-icon.svg" alt="" class="icon">
        <div class="text">Количество рейсов: {$tripsCount}</div>
    </div>
    <div class="property">
        <img src="/assets/img/icons/subway-icon.svg" alt="" class="icon">
        <div class="text">Метро: {$_pls['tv.pierSubwayStation']}</div>
    </div>
    <div class="property">
        <img src="/assets/img/icons/location-icon-transparent.svg" alt="" class="icon">
        <div class="text">{$_pls['tv.pierAddress']}</div>
    </div>
    
    <a href="{$url}" class="base-button filled">Подробнее</a>
</div>
    