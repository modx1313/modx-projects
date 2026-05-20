{var $data = 'shipTags.prepareData' | snippet}


<div class="homepage tagpage js-page-data" data-id="homepage">
    
    <div class="base-width content-block-margin">
        <a href="[[~[[*id]]]]#catalog-anchor" class="banner-section">
            <img src="[[pthumb? &input=`[[*tags.banner]]` &options=`w=1140&h=392&zc=1`]]" class="image" alt="">
            <div class="inner-wrapper">
                <div class="text">[[*tags.bannerText]]</div>
                <div class="base-button filled">{$data['bannerTitle']}</div>
            </div>
        </a>
    </div>
    
    <div class="anchor-wrapper">
        <div class="anchor" id="catalog-anchor"></div>
    </div>
    
    <h1 class="section-title base-width content-block-margin">[[*pagetitle]]</h1>
  
  
    {if $data['shipsIds'] != 'error_result'}
        {'shipsCatalog' | chunk : [
            'type' => $data['shipType'],
            'title' => '',
            'shipsIds' => $data['shipsIds'],
            'total' => $data['shipsTotal']
        ]}
    {else}
        <div class="base-width content-block-margin no-items-text">
            В данный момент актуальных прогулок по данному тегу нет
        </div>
    {/if}
    
    [[$tags.textSection]]
    [[$ships.tagsSection]]
    [[$staticAdvantagesSection]]
    
    <div class="fixed-bar bottom" data-hystfixed>
        {'showAllShipsSection' | chunk : [
            'shipText' => $data['shipText'],
            'shipsParent' => $data['shipsParent']
        ]}
    </div>

    [[$fullImageModal]]
</div>