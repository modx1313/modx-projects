{var $imagesArr = is_array($images) ? $images : $images | fromJSON}
{var $resourceId = 'id' | resource}
<div class="hystmodal" id="{$galleryId}" aria-hidden="true">
    <div class="hystmodal__wrap full-image-modal-wrapper">
        <div class="hystmodal__window modal-gallery" role="dialog" aria-modal="true">
            <button data-hystclose class="hystmodal__close">Закрыть</button>
            <div class="js-modal-gallery-swiper modal-gallery-slider" data-gallery-id="{$galleryId}">
                <div class="swiper-wrapper">
                    {foreach $imagesArr as $image}
                        {var $src = '/assets/resourceimages/' ~ $resourceId ~ '/' ~ $image['image']}
                        <div class="swiper-slide modal-gallery-slide">
                            <img data-src="{$src | pthumb: 'w=1400&h=800&zc=1'}" alt="" class="modal-gallery-image lazyload">
                        </div>
                    {/foreach}                        
                </div>
            </div>
        </div>
    </div>
</div>