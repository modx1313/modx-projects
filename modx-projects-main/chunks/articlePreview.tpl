<a href="{$id | url}" class="item swiper-slide">
    <img sr="[[+tv.article.previewImage]]" data-src="[[pthumb? &input=`[[+tv.article.previewImage]]` &options=`w=500&h=356&zc=1`]]" class="image lazyload" alt="">
    <div class="info-section">
        <div class="title-wrapper">
            <div class="title">[[+pagetitle]]</div>
            <div class="date">{$publishedon | date : "d.m.Y"}</div>
        </div>
        <div class="annotation">[[+introtext]]</div>
        <div class="link-wrapper">
            <span class="link pointer noselect hover">Подробнее</span>
        </div>
    </div>
</a>