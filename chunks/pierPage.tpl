{var $data = 'pier.prepareData' | snippet}

<div class="pier-page homepage">
    <h1 class="main-title base-width">[[*pagetitle]]</h1>

    <div class="gallery-section base-width">
        [[$imageGallery]]
    </div>
    
    <div class="base-width content-block-margin">
        {'description_block' | chunk : [
            'text' => 'content' | resource,
            'limit' => 420
        ]}
    </div>
    
    <h2 class="section-title base-width">Прогулки с этого причала</h2>
    
    {if $data['totalCount']}
        <div 
            class="catalog-section base-width js-catalog-section" 
            data-parent-id="{$data['cityRelatedData']['tripsId']}" 
            data-pier-id="[[*id]]" 
            data-current-count="{$data['currentCount']}" 
            data-total-count="{$data['totalCount']}"
        >
            <div class="js-ajax-insert wrapper">
                {'getChunkCollection' | snippet : [
                    'tpl' => 'catalogItem',
                    'valuesJson' => $data['tripsItemsJson']
                ]}
            </div>
            {if $data['showMoreItemsBtn'] == '1'}
                <button class="show-more-btn base-button transparent js-show-more-catalog-items">Показать еще</button>
                <img src="/assets/img/icons/circle-dots.gif" alt="" class="loading-items js-loading-items js-hidden">
            {/if}
        </div>
    {else}
        <div class="base-width content-block-margin no-items-text">
            В данный момент актуальных прогулок с данного причала нет
        </div>
    {/if}
    
    {if $data['oldTripsSection']}
        {'riverTrip.slider' | chunk : [
            'title' => 'Прошедшие прогулки',
            'riverTripSliderJson' => $data['oldTripsItemsJson'],
            'classModifier' => '2'
        ]}
    {/if}
    
    {'advancedRouteSection' | chunk}
    
    
    <div class="base-width content-block-margin">
        <h2 class="section-title">Особенности причала</h2>

        {'featuresSection' | chunk : [
           'title' => '',
           'items' => $data['features']
        ]}
    </div>
    
    {'homepage.subscribeSection' | chunk}
    {'homepage.tagsSection' | chunk}
    {'staticAdvantagesSection' | chunk}
    {'showAllTripsFixedBar' | chunk}

    {'fullImageModal' | chunk}

</div>