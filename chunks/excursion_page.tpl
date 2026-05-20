<div class="river-trip js-page-data" data-id=[[*id]] itemscope itemtype="http://schema.org/ImageObject">
    <h1 class="main-title base-width"><span itemprop="description">[[*pagetitle]]</span></h1>
    
    <div class="top-rating-section base-width">
        <div class="stars">
            [[!getRatingStars? &rating=`[[+ratingMain]]`]]
        </div>
        <div class="number">
            [[+ratingMain]]
        </div>
    </div>
    
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
    