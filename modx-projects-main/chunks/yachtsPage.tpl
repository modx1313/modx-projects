{var $data = 'yachts.prepareData' | snippet}

<div class="yachts-page">
    <h1 class="main-title base-width">{'tv.shipsTitle' | resource}</h1>

    <div class="base-width">
        <div class="icons-filter-options">
            {foreach $data['filterArr'] as $item}
                <div class="item js-apply-ship-filter" data-filter-type="tags" data-filter-value="{$item['id']}">
                    <img src="{$item['image']}" alt="" class="icon">
                    <div class="text">{$item['text']}</div>
                </div>
            {/foreach}
        </div>
    </div>
    
     <div class="base-width content-block-margin">
        <div class="catalog-search">
            <div class="search-wrapper js-search-block">
                <input type="text" class="input-field js-ship-search-input" name="search" type="text" placeholder="Введите название яхты">
                <img class="icon search pointer noselect js-apply-ship-filter" data-filter-type="search" src="/assets/img/icons/search-icon.svg" alt="">
                <img class="icon cancel pointer noselect js-apply-ship-filter" data-filter-type="cancelSearch" src="/assets/img/icons/close-icon.svg" alt="">
            </div>
            <div class="sort-wrapper">
                <button class="base-button active js-apply-ship-filter" data-filter-type="sort" data-sort="menuindex">По популярности</button>
                <button class="base-button js-apply-ship-filter" data-filter-type="sort" data-sort="shipPrice">По стоимости</button>
            </div>
        </div>
    </div>
    
    
    {'shipsCatalog' | chunk : [
        'type' => 'yacht',
        'title' => 'Яхты'
    ]}
 
    {'shipsMainForm' | chunk : [
        'type' => 'yacht',
        'title' => 'Подбор яхты'
    ]}
    
    {'pageTextSection' | chunk : [
        'images' => 'tv.additionalImageGallery' | resource,
        'title' => 'tv.shipsTextTitle' | resource,
        'text' => 'tv.shipsText' | resource
    ]}
    
    {'ships.tagsSection' | chunk}
    
    {'staticAdvantagesSection' | chunk}
    

    <div class="hystmodal" id="ship-modal-form" aria-hidden="true">
        <div class="hystmodal__wrap">
            <div class="hystmodal__window modal-wrapper large" role="dialog" aria-modal="true">
                {'shipOrderModal' | chunk : ['shipType' => 'yacht']}
                <button data-hystclose class="hystmodal__close">Закрыть</button>
            </div>
        </div>
    </div>

</div>