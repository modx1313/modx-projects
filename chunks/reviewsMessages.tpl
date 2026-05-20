<div id="ec-{$thread_name}-message-{$id}" class="item js-review-item">
    <div class="info-section">
        <div class="icon">[[+user_name:limit=`1`]]</div>
        <div class="info-wrapper">
            <div class="name">{$user_name}</div>
            <div class="date-wrapper">
                <div class="date">{$date | date_format:"%e %b. %Y"} г.</div>
                <div class="trip-name"> • [[getResourceTV? &tvId=`43` &resourceId=`{$thread_resource}` &needRawValue=`1`]]</div>
            </div>
        </div>

    </div>
    
    <div class="stars">
        <span class="rating-{$rating}"></span>
    </div>
    
    <div class="text">{$text}</div>

    {if $files}
        <div class="images js-reviews-message-images-slider noselect pointer" data-id="{$id}">
            <div class="swiper-wrapper">
                {foreach $files as $file}
                    <a href="{$file['url'] | pthumb : 'w=1200&h=800&zc=1'}" class="glightbox swiper-slide" data-gallery="review-message-gallery-{$id}">
                        <img data-src="{$file['url'] | pthumb : 'w=100&h=100&zc=1'}" data-full-img="{$file['url']}" alt="" class="image lazyload">
                    </a>
                {/foreach}
            </div>
        </div>
    {/if}
</div>
