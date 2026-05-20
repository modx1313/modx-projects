{var $data = 'piers.prepareData' | snippet}

<div class="pier-page">
    <h1 class="main-title base-width">{'tv.piersTitle' | resource}</h1>

    <div class="main-banner base-width">
        <img src="{'tv.piersBanner' | resource}" alt="">
    </div>
    
    <div class="base-width content-block-margin">
        {'description_block' | chunk : [
            'text' => 'tv.piersDescription' | resource,
            'limit' => 420
        ]}
    </div>
    
    
    <h2 class="section-title base-width">{'tv.piersCatalogTitle' | resource}</h2>
    
    {'piersCatalog' | chunk}
    
    {'riverTrip.slider' | chunk : [
        'title' => 'Речные прогулки',
        'riverTripSliderJson' => $data['trips']
    ]}
    
    {if $data['oldTrips'] != '[]'}
        {'riverTrip.slider' | chunk : [
            'title' => 'Прошедшие прогулки',
            'classModifier' => '2',
            'riverTripSliderJson' => $data['oldTrips']
        ]}
    {/if}
    
    <h2 class="section-title base-width">{'tv.piersMapTitle' | resource}</h2>
    
    <div class="base-width large-map-section content-block-margin">
        <div class="map">
            {'tv.piersMap' | resource}
        </div>
    </div>
    
    <div class="articles-slider-wrapper base-width content-block-margin">
        <h2 class="section-title">Новости</h2>
        <div class="swiper-container">
            <div class="articles-slider js-main-articles-swiper">
                <div class="swiper-wrapper">
                    {var $where = '[{"articleCity:LIKE":"%'~$data['city']['name']~'%"}]'}
                    {'pdoResources' | snippet : [
                        'parents' => 141,
                        'limit' => 8,
                        'where' => $where,
                        'tpl' => 'article.slide',
                        'sortby' => 'publishedon',
                        'sortdir' => 'DESC',                    
                        'includeTVs' => 'article.previewImage,article.group,photoTagColor,photoTagText,articleCity'
                    ]}
                </div>
            </div>
            <div class="slider-button-prev round js-main-articles-slider-button-prev js-hidden pointer noselect"></div>
            <div class="slider-button-next round js-main-articles-slider-button-next js-hidden pointer noselect"></div>
        </div>
    </div>

    {'homepage.subscribeSection' | chunk}
    {'homepage.tagsSection' | chunk}
    {'staticAdvantagesSection' | chunk}
    {'showAllTripsFixedBar' | chunk}

</div>