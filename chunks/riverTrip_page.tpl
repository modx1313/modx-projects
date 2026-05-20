<div class="river-trip js-page-data" data-id=[[*id]] itemscope itemtype="http://schema.org/ImageObject">
    <h1 class="main-title base-width"><span itemprop="description">[[*pagetitle]]</span></h1>
    [[If?
       &subject=`[[+ratingMainInt]]`
       &operator=`greater`
       &operand=`0`
       &then=`[[$rating_stars_main]]`
       &else=``
    ]]

    <div class="gallery-section base-width">
        [[$imageGallery]]
    </div>
    
    <div class="base-width share-section">
        <div class="wrapper">
            <div class="share-btn noselect pointer hover">
                <img class="icon" src="/assets/img/icons/share-icon.svg" alt="">
                <div class="text">Поделиться</div>
            </div>
            <div class="menu">
                <div class="item pointer noselect js-copy-to-clipboard" data-url="[[++site_url]][[*uri]]">Cкопировать ссылку</div>
                <button
                    class="vkontakte item pointer noselect"
                    onClick='window.open("https://vk.com/share.php?url=[[++site_url]][[*uri]]","sharer","status=0,toolbar=0,width=650,height=500");'
                    title="Поделиться Вконтакте">Вконтакте
                </button>
                <button
                    class="telegram item pointer noselect"
                    onClick='window.open("https://telegram.me/share/url?url=[[++site_url]][[*uri]]","sharer","status=0,toolbar=0,width=650,height=500");'
                    title="Поделиться в Telegram">Telegram
                </button>
                <button
                    class="telegram item pointer noselect"
                    onClick='window.open("[[++max]]","sharer","status=0,toolbar=0,width=650,height=500");'
                    title="Поделиться в MAX">MAX
                </button>
            </div>
        </div>
    </div>
    
    <div class="main-section base-width">
        [[$riverTrip.details]]        
        [[$riverTrip.tickets]]
    </div>
    
    [[If?
       &subject=`[[+similarEventsSection]]`
       &operator=`EQ`
       &operand=`1`
       &then=`[[$riverTrip.slider? &title=`Похожие туры`]]`
       &else=``
    ]]
    
    [[!$reviewsSection]]
    [[$riverTrip.tagsSection]]
    [[$staticAdvantagesSection]]

    [[$fullImageModal]]
    [[$riverTrip.fixedBars]]

</div>

<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "Event",
    "name": "{$_modx->resource.pagetitle}",
    "description": "{$_modx->resource.description}",
    "startDate": "{'now' | date: 'Y-m-d'}T12:00:00+03:00",
    "organizer": {
        "@type": "Organization",
        "name": "Riversales",
        "url": "https://riversales.ru"
    },
    "location": {
        "@type": "Place",
        "name": "{$_modx->resource.routeStart}"
    },
    "image": [
        {'getImageList' | snippet : [
            'tvname' => 'imageGallery',
            'tpl' => 'imageLink'
        ]}
    ],
    "offers": [
        {'getImageList' | snippet : [
            'tvname' => 'ticketsTable',
            'tpl' => 'ticketOffer'
        ]}
    ]
}
</script>


<script type="application/ld+json">

{var $isPast = 'getTripStatus' | snippet}
{var $availability = "https://schema.org/InStock"}

{if $isPast}
    {set $availability = "https://schema.org/SoldOut"}
{/if}

{
    "@context": "https://schema.org",
    "@type": "Product",
    "name": "{$_modx->resource.pagetitle}",
    "image": [
        {'getImageList' | snippet : [
            'tvname' => 'imageGallery',
            'tpl' => 'imageLink'
        ]}
    ],
    "offers": {
        "@type": "Offer",
        "price": "{$_modx->resource.price}",
        "priceCurrency": "RUB",
        "availability": "{$availability}"
    }
}
</script>
    