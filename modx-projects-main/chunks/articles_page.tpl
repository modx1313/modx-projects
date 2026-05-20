{var $data = 'articles.prepareData' | snippet}


<div class="articles-page">
    
    <div class="base-width">
        <div class="banner-section thin">
            <img src="[[pthumb? &input=`[[*article.mainBanner]]` &options=`w=1340&h=263&zc=1`]]" class="image" alt="">
        </div>
    </div>
    
    <h1 class="main-title base-width">{'tv.articles.title' | resource}</h1>

    <div class="description base-width">{'introtext' | resource}</div>
    
    <div class="social-section simple base-width">
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

    {'subscribeSectionLight' | chunk}
    
    {'articleGroups' | chunk : [
        'groups' => $data['articleGroups'],
        'view' => 'desktop',
        'limit' => 6
    ]}
    
    {'articleGroups' | chunk : [
        'groups' => $data['articleGroups'],
        'view' => 'mobile',
        'limit' => 2
    ]}
    
    [[$fullImageModal]]
</div>