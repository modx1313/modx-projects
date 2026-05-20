{var $photoTagColor = $_modx->runSnippet('getMigxValuesById', [
    'valueIdsArr' => [$_pls['tv.photoTagColor']],
    'parametersTvId' => 48
]) | fromJSON}

{var $url = $id | url}
{var $availableTrips = $_pls['tv.availableTripsForShip'] == '1' ? '' : $_pls['tv.availableTripsForShip']}
{var $availableTripsCount = 0}
{if $availableTrips}
    {var $availableTripsArr = $availableTrips | split : '||'}
    {set $availableTripsCount = $availableTripsArr | length}
{/if}
{var $isAvailable = $_pls['tv.shipStatus'] ? 'да' : 'нет'}

<div class="item swiper-slide ship-item" data-total-count="{$count}">
    <a href="{$url}">
        <div class="image">
            <img data-src="{$_pls['tv.previewImage'] | pthumb : 'w=457&h=310&zc=1'}" alt="[[+alt]]" class="lazyload"/>
            <div class="tag" style="background-color: {$photoTagColor[0]['color']}">{$_pls['tv.photoTagText']}</div>
        </div>
    </a>
    <a href="{$url}">
        <div class="title">
           {$pagetitle}
        </div>
    </a>
    <div class="info-wrapper">
        <div class="detail">
            <div class="name">Вместимость</div>
            <div class="value">до {$_pls['tv.shipCapacity']} чел</div>
        </div>
        <div class="detail">
            <div class="name">Количество прогулок</div>
            <div class="value">{$availableTripsCount}</div>
        </div>
        <div class="detail">
            <div class="name">Доступен для аренды</div>
            <div class="value">{$isAvailable}</div>
        </div>
    </div>
    <div class="button-wrapper">
        <a href="{$url}" class="base-button filled">Подробнее</a>
    </div>
    
</div>