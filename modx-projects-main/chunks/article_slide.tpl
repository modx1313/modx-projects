{var $photoTagColor = $_modx->runSnippet('getMigxValuesById', [
    'valueIdsArr' => [$_pls['tv.photoTagColor']],
    'parametersTvId' => 48
]) | fromJSON}

{var $url = $id | url}


<div class="item swiper-slide article-item" data-total-count="{$count}">
    <a href="{$url}">
        <div class="image">
            <img data-src="{$_pls['tv.article.previewImage'] | pthumb : 'w=457&h=310&zc=1'}" alt="[[+alt]]" class="lazyload"/>
            <div class="tag" style="background-color: {$photoTagColor[0]['color']}">{$_pls['tv.photoTagText']}</div>
        </div>
    </a>
    <a href="{$url}">
        <div class="title">
           {$pagetitle}
        </div>
    </a>
    <div class="info-wrapper">
        <div class="date">{$publishedon | date_format:"%d.%m.%Y"}</div>
        <div class="group">{$_pls['tv.article.group']}</div>
    </div>
    <div class="annotation">{$introtext}</div>
    <a href="{$url}" class="base-button transparent">Читать полностью</a>
    
</div>