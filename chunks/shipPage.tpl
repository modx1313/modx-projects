{var $data = 'ship.prepareData' | snippet}

<div class="ship-page">
    <h1 class="main-title base-width">[[*pagetitle]]</h1>

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
    
    {'shipMainSection' | chunk : ['features' => $data['features']]}
    
    <div class="bar-anchor-wrapper">
        <div class="anchor" id="similar-ships-anchor"></div>
    </div>    
    {'shipsSlider' | chunk : ['title' => 'Похожие теплоходы']}
    
    {var $cityData = 'getCityRelatedData' | snippet}
    {var $faqTv = $cityData['name'] == 'spb' ? 'tv.shipFaqSpb' : 'tv.shipFaq'}
    
    {'faqSection' | chunk : [
        'resourceId' => 16,
        'tvName' => $faqTv,
        'title' => 'Часто задаваемые вопросы'
    ]}
    
    {'ships.tagsSection' | chunk : [
        'tagIds' => 'tv.shipTags' | resource
    ]}
    
    {'staticAdvantagesSection' | chunk}
    
    [[$fullImageModal]]
    {'shipFixedBars' | chunk : ['type' => 'ship']}

    <div class="hystmodal" id="ship-modal-form" aria-hidden="true">
        <div class="hystmodal__wrap">
            <div class="hystmodal__window modal-wrapper large" role="dialog" aria-modal="true">
                {'shipOrderModal' | chunk : ['shipType' => 'ship']}
                <button data-hystclose class="hystmodal__close">Закрыть</button>
            </div>
        </div>
    </div>

</div>