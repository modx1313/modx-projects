{var $photoTagColor = $_modx->runSnippet('getMigxValuesById', [
    'valueIdsArr' => [$_pls['tv.photoTagColor']],
    'parametersTvId' => 48
]) | fromJSON}

{var $url = $id | url}


<div class="item swiper-slide ship-item" data-total-count="{$count}">
    <a href="{$url}">
        <div class="image">
            <img src="{$_pls['tv.previewImage'] | pthumb : 'w=457&h=310&zc=1'}" alt="[[+alt]]" class=""/>
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
        {if $_pls['tv.shipBanquetPrice']}
            <div class="detail">
                <div class="name">Банкет</div>
                <div class="value">{$_pls['tv.shipBanquetPrice']} ₽/чел</div>
            </div>
        {/if}
        
        {if $_pls['tv.shipBuffetPrice']}
            <div class="detail">
                <div class="name">Фуршет</div>
                <div class="value">{$_pls['tv.shipBuffetPrice']} ₽/чел</div>
            </div>
        {/if}
        <div class="detail">
            <div class="name">Стоимость</div>
            <div class="value">от {$_pls['tv.shipPrice']} ₽/час</div>
        </div>
    </div>
    <div class="button-wrapper">
        <a href="{$url}" class="base-button transparent">Подробнее</a>
        <div class="base-button filled" data-hystmodal="#ship-modal-form" data-id="{$id}" data-name="{$pagetitle}">Получить расчет</div>
    </div>
    
</div>