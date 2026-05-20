{var $city = 'getCityRelatedData' | snippet}
{var $where = '[{"articleCity:LIKE":"%'~$city['name']~'%"}]'}

<div class="articles-section mobile base-width js-articles-swiper">
    <div class="section-title">Полезная информация</div>
    <div class="wrapper swiper-wrapper">
        {'pdoResources' | snippet : [
            'parents' => 141,
            'depth' => 0,
            'limit' => 6,
            'where' => $where,
            'tpl' => 'articlePreview',
            'sortby' => 'publishedon',
            'sortdir' => 'DESC',
            'includeTVs' => 'article.previewImage,photoTagColor,photoTagText,articleCity'
        ]}
    </div>
    <div class="slider-button-prev white js-slider-button-prev js-hidden pointer noselect"></div>
    <div class="slider-button-next white js-slider-button-next js-hidden pointer noselect"></div>
    
</div>

<div class="articles-section base-width">
    <div class="section-title">Полезная информация</div>
    <div class="wrapper">
        {'pdoResources' | snippet : [
            'parents' => 141,
            'depth' => 0,
            'limit' => 6,
            'where' => $where,
            'tpl' => 'articlePreview',
            'sortby' => 'publishedon',
            'sortdir' => 'DESC',
            'includeTVs' => 'article.previewImage,photoTagColor,photoTagText,articleCity'
        ]}
    </div>
</div>


