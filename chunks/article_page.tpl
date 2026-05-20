{var $data = 'article.prepareData' | snippet}


<div class="article-page homepage">
    
    <div class="base-width">
        <div class="banner-section thin">
            <img src="[[pthumb? &input=`[[*article.mainBanner]]` &options=`w=1140&h=243&zc=1`]]" class="image" alt="">
            <div class="inner-wrapper">
                <h1 class="title">[[*pagetitle]]</h1>
                <div class="subtitle">[[*article.bannerText]]</div>
            </div>
        </div>
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
        <div class="article-author-block">
            <div class="article-author-wrapper">
                <img src="/assets/img/author.png" alt="">
                <div class="author-text">
                    <div class="author-name">Тимур Орлов</div>
                    <div class="author-job">Главный редактор</div>
                </div>
            </div>
            
            <div class="article-date">Обновлена {$_modx->resource.publishedon | date : "d.m.Y"}</div>
        </div>
    </div>


    <div class="base-width article-index-wrapper">
        <div class="article-index">
            <h2 class="section-title">Содержание статьи</h2>
            <div class="article-index__list">
               {'getChunkCollection' | snippet : [
                'tpl' => 'article.indexItem',
                'valuesJson' => $data['contentTitles']
            ]} 
            </div>
        </div>
    </div>
    
    
    <div class="base-width article-body main-text-content content-block-margin">
        {$data['anchoredContent']}
    </div>
    
    
    {if $data['hasTextImage'] == '1'}
        <div class="text-image-wrapper base-width content-block-margin">
            <img  
                data-src="[[pthumb? &input=`[[*article.textImage]]` &options=`w=1340&h=452&zc=1`]]"
                alt="" class="lazyload text-image"
            />
        </div>
    {/if}
    
    
    {if $_modx->resource['article.textQuote']}
        <div class="base-width text-quote-wrapper">
            <div class="text-quote">
                {$_modx->resource['article.textQuote']}
                <img src="/assets/img/icons/start-quotes-icon.svg" alt="" class="start-quotes icon">
                <img src="/assets/img/icons/end-quotes-icon.svg" alt="" class="end-quotes icon">
            </div>
        </div>
    {/if}
    
    
    {if $_modx->resource['article.textList']}
        <div class="base-width text-list content-block-margin">
            {'getChunkCollection' | snippet : [
                'tpl' => 'article.listItem',
                'valuesJson' => $_modx->resource['article.textList']
            ]}
        </div>
    {/if}
    
    
    {if $_modx->resource['article.promocode']}
        <div class="base-width promocode-section-wrapper content-block-margin">
            <div class="promocode-section">
                <div class="text">
                    Благодарим Вас за прочтение статьи и дарим промокод на дополнительную 
                    скидку при заказе билетов на нашем сайте. Поторопитесь совершить покупку, 
                    пока он еще активен!
                </div>
                <div class="promocode-wrapper">
                    <div class="name">Промокод:</div>
                    <div class="promocode">{$_modx->resource['article.promocode']}</div>
                </div>
            </div>
        </div>
    {/if}
    
    
    {if $_modx->resource['article.riverTrips'] && $_modx->resource['sliderType'] == 'trips'}
        {'riverTrip.slider' | chunk : [
            'title' => 'Подборка речных прогулок',
            'riverTripSliderJson' => $data['riverTripSliderJson']
        ]}
    {/if}
    
    {if $_modx->resource['article.ships'] && $_modx->resource['sliderType'] == 'ships'}
        {'shipsSlider' | chunk : [
            'title' => 'Подборка теплоходов',
            'tvName' => 'tv.article.ships'
        ]}
    {/if}
    
    {if $_modx->resource['article.yachts'] && $_modx->resource['sliderType'] == 'yachts'}
        {'shipsSlider' | chunk : [
            'title' => 'Подборка яхт',
            'tvName' => 'tv.article.yachts'
        ]}
    {/if}
    
    {if $_modx->resource['article.articles']}
        <div class="articles-slider-wrapper base-width content-block-margin">
            <div class="section-title">Другие новости</div>
            <div class="swiper-container">
                <div class="articles-slider js-main-articles-swiper">
                    <div class="swiper-wrapper">
                        {'pdoResources' | snippet : [
                            'parents' => 141,
                            'resources' => $_modx->resource['article.articles'],
                            'tpl' => 'article.slide',
                            'includeTVs' => 'article.previewImage,article.group,photoTagColor,photoTagText'
                        ]}
                    </div>
                </div>
                <div class="slider-button-prev round js-main-articles-slider-button-prev js-hidden pointer noselect"></div>
                <div class="slider-button-next round js-main-articles-slider-button-next js-hidden pointer noselect"></div>
            </div>
        </div>
    {/if}
    
    [[$homepage.subscribeSection]]

    <div class="main-social-section base-width content-block-margin">
        <div class="title">Мы в соцсетях</div>
        <div class="icons-wrapper">
            <a target="_blanc" href="[[++max]]" class="telgram">
                <img src="/assets/img/icons/MAX.svg" alt="написать в MAX">
            </a>
            <a target="_blanc" href="[[++telegram]]" class="telgram">
                <img src="/assets/img/icons/telegram-icon.svg" alt="написать в telegram">
            </a>
            <a target="_blanc" href="[[++vk]]" class="telgram">
                <img src="/assets/img/icons/vk-icon.svg" alt="написать в вконтакте">
            </a>
        </div>
    </div>
    
    [[$articleFixedBars]]
    [[$fullImageModal]]
    <script type="application/ld+json">
    {
      "@context": "https://schema.org/",
      "@type": "Article",
      "name": "[[*pagetitle]]",
      "description": "[[*article.bannerText]]",
      "contentReferenceTime": "[[*publishedon]]"
    }
    </script>
</div>