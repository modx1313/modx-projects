{var $carText = 'getMigxValueById' | snippet : [
    'paramsTvId' => 77, 
    'valueId' => $_modx->resource.pierCarMapText, 
    'fieldName' => 'name'
]}
{var $busText = 'getMigxValueById' | snippet : [
    'paramsTvId' => 77, 
    'valueId' => $_modx->resource.pierBusMapText, 
    'fieldName' => 'name'
]}
{var $subwayText = 'getMigxValueById' | snippet : [
    'paramsTvId' => 77, 
    'valueId' => $_modx->resource.pierSubwayMapText, 
    'fieldName' => 'name'
]}



<h2 class="section-title base-width">Как добраться до причала</h2>
   
<div class="advanced-route-section base-width content-block-margin">
    {var $sections = [
        [
            'name' => 'car',
            'mapTv' => $_modx->resource.pierCarMap,
            'textTv' => $carText,
            'title' => 'На машине',
            'icon' => '/assets/img/icons/car-icon.svg',
            'iconActive' => '/assets/img/icons/car-icon-white.svg'
        ],
        [
            'name' => 'bus',
            'mapTv' => $_modx->resource.pierBusMap,
            'textTv' => $busText,
            'title' => 'На автобусе',
            'icon' => '/assets/img/icons/bus-icon.svg',
            'iconActive' => '/assets/img/icons/bus-icon-white.svg'
        ],
        [
            'name' => 'subway',
            'mapTv' => $_modx->resource.pierSubwayMap,
            'textTv' => $subwayText,
            'title' => 'На метро',
            'icon' => '/assets/img/icons/subway-icon.svg',
            'iconActive' => '/assets/img/icons/subway-icon-white.svg'
        ]
    ]}
    
    
    <div class="desktop js-map-section">
        <div class="buttons-section">
            {foreach $sections as $key => $section}
                {var $active = ($key === 0) ? 'active' : ''}
                
                <div class="button js-switch-maps pointer noselect {$active}" data-show-button="desktop-map" always-visible data-type="{$section['name']}">
                    <img src="{$section['icon']}" alt="" class="icon inactive">
                    <img src="{$section['iconActive']}" alt="" class="icon active">
                    <div class="title">{$section['title']}</div>
                </div>
            {/foreach}
        </div>
        
        <div class="map-section js-hidden" data-hideable-block="desktop-map">
            {foreach $sections as $key => $section}
                {var $active = ($key === 0) ? 'active' : ''}

                <div class="js-map-block map-block {$active}" data-type="{$section['name']}">
                    <div class="map">{$section['mapTv']}</div>
                    <div class="text">{$section['textTv']}</div>
                </div>
            {/foreach}
        </div>
        <div class="toggle-button show" data-show-button="desktop-map">Показать карту<img class="toggle-button-show-img" src="/assets/img/icons/toggle-button-show.png" alt="показать"></div>
        <div class="toggle-button js-hidden hide" data-hide-button="desktop-map">Скрыть карту<img class="toggle-button-hide-img" src="/assets/img/icons/toggle-button-hide.png" alt="скрыть"></div>
    </div>
    
    <div class="mobile js-map-section">
        {foreach $sections as $key => $section}
            <div class="section">
                {var $active = ($key === 0) ? 'active' : ''}
                
                <div class="button js-switch-maps pointer noselect" data-type="{$section['name']}">
                    <img src="{$section['icon']}" alt="" class="icon inactive">
                    <img src="{$section['iconActive']}" alt="" class="icon active">
                    <div class="title">{$section['title']}</div>
                </div>
                <div class="js-map-block map-block" data-type="{$section['name']}">
                    <div class="map-section" data-hideable-block="mobile-map">
                        <div class="map">{$section['mapTv']}</div>
                        <div class="text">{$section['textTv']}</div>
                    </div>
                    <div class="toggle-button show js-hidden" data-show-button="mobile-map">Показать карту</div>
                    <div class="toggle-button hide" data-hide-button="mobile-map">Скрыть карту</div>
                </div>
            </div>
        {/foreach}
    </div>
</div>