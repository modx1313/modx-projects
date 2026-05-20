{if !$disabled}
    <div class="swiper-slide item noselect hover pointer js-apply-filter js-filter-toggle" data-value-id="[[+MIGX_id]]">
        <img data-src="[[pthumb? &input=`/assets/img/[[+image]]` &options=`w=313&h=183&zc=1`]]" alt="" class="image lazyload">
        <div class="line"></div>
        <div class="text">[[+name]]</div>
    </div>
{/if}