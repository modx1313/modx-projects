{var $archiveParentsIds = [149, 294, 295]}

<div class="river-trip-slider-item swiper-slide">
    <a href="[[+uri]]">
        <div class="image">
            <img data-src="[[pthumb? &input=`/assets/resourceimages/[[+id]]/[[+mainImage]]` &options=`w=300&h=204&zc=1`]]" alt="[[+alt]]" class="lazyload"/>
            <div class="tag" style="background-color: [[+photoTagColor]]">[[+photoTagText]]</div>
        </div>
    </a>
    <a href="[[+uri]]">
        <div class="title">
            [[If?
               &subject=`[[+shortTitle]]`
               &operator=`EQ`
               &operand=``
               &then=`[[+pagetitle]]`
               &else=`[[+shortTitle]]`
            ]]
        </div>
    </a>
    <div class="info">
        <div class="item">
            <img class="icon" src="/assets/img/icons/timer-icon.svg" alt="продолжительность">
            <div class="text">[[+duration]]</div>
        </div>
        <div class="item">
            <img class="icon" src="/assets/img/icons/metro-icon.svg" alt="место отправления">
            <div class="text">[[+metro]]</div>
        </div>
    </div>
    <div class="rating">
        {if $rating && $rating != '0,0'}
            [[!getRatingStars? &rating=`[[+rating]]`]]
            <div class="number">
                [[+rating]]
            </div>
        {/if}
    </div>
    <div class="advantages">
        [[getChunkCollection?
        	&tpl=`riverTrip.previewItemAdvantage`
        	&valuesLinesSeparated=`[[+previewAdvantages]]`
        	&migxReferenceTvId=`24`
        	&quantity=`4`
        ]]
    </div>
    <div class="price">
        <div class="base">
            <span class="price-prefix">от</span>[[+price]] ₽
        </div>
        <div class="discount">
            [[+discountPrice]] ₽
        </div>
        <div class="percent">
            -[[+discountPercent]]%
        </div>
    </div>
    <div class="buttons">
        <a href="[[+uri]]" class="base-button transparent">Подробнее</a>
        {if !in_array($parent, $archiveParentsIds)}
            {if $ticketsServiceType == 'teplohod.info'}
                {var $ticketsId = $teplohodServiceId}
            {/if}
            {if $ticketsServiceType == 'radario.ru'}
                {var $ticketsId = $radarioServiceId}
            {/if}
            {if $ticketsServiceType == 'незабываемая.москва'}
                {var $ticketsId = $nzMoskvaServiceId}
            {/if}
        
            {'buyButton' | chunk : [
                'classes' => 'base-button filled',
                'ticketsId' => $ticketsId,
                'text' => 'Купить билеты',
                'ticketsServiceType' => $ticketsServiceType,
            ]}
        {else}
            <div class="base-button filled inactive">
                Распродано
            </div>
        {/if}
    </div>
</div>