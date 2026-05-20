{if $tvName}
    {var $ships = $tvName | resource}
{else}
    {var $ships = 'tv.similarShips' | resource}
{/if}

{var $isCatalogPage = $_modx->resource.parent == 754}
{var $template = $isCatalogPage ? 'shipCatalog.slide' : 'ship.slide'}

{if $ships}
    <div class="base-width content-block-margin">
        <div class="section-title">{$title}</div>
        <div class="swiper-container">
            <div class="ships-slider js-ships-swiper">
                <div class="swiper-wrapper">
                    {'pdoResources' | snippet : [
                        'parents' => '196,197,633,646,754',
                        'resources' => $ships,
                        'tpl' => $template,
                        'includeTVs' => 'shipCapacity,shipBanquetPrice,shipBuffetPrice,shipPrice,previewImage,photoTagColor,photoTagText,shipStatus,availableTripsForShip'
                    ]}
                </div>
            </div>
            <div class="slider-button-prev round js-ships-slider-button-prev js-hidden pointer noselect"></div>
            <div class="slider-button-next round js-ships-slider-button-next js-hidden pointer noselect"></div>
        </div>
    </div>
{/if}