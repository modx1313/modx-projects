{var $img = '/assets/resourceimages/'~$id~'/'~$mainImage}
{var $isPast = 'getIsPast' | snippet : ['parent' => $parent]}

<div class="catalog-item">
    <a href="[[+uri]]" class="catalog-item__media-link">
        <div class="image">
            <img
                src=""
                data-src="{$img | pthumb : 'w=450&h=300&zc=1'}?v1"
                alt="[[+alt]]"
                class="lazyload"
            />
            {if $photoTagText || $discountPercent}
                <div class="catalog-item__badges">
                    {if $photoTagText}
                        <div class="tag" style="background-color: [[+photoTagColor]]">{$photoTagText}</div>
                    {/if}
                    {if $discountPercent}
                        <div class="catalog-item__discount-badge">-{$discountPercent}%</div>
                    {/if}
                </div>
            {/if}
            {var $hideRatingClass = intval($rating) ? '' : 'hide'}
            <div class="catalog-item__rating-badge {$hideRatingClass}">
                <span class="catalog-item__rating-value">{$rating}</span>
                <span class="catalog-item__rating-star" aria-hidden="true">
                    <svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M6.564 1.402L5.07 4.43 1.75 4.913l2.407 2.346-.568 3.31L6.564 9.47l3.975 1.099-.568-3.31 2.407-2.346-3.32-.483L6.564 1.402z" fill="#FFC107"/>
                    </svg>
                </span>
            </div>
        </div>
    </a>

    <div class="catalog-item__body">
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
            <div class="catalog-item__info-wrapper">
                <div class="item">
                    <img class="icon" src="/assets/img/icons/timer-icon.svg" alt="продолжительность">
                    <div class="text">[[+duration]]</div>
                </div>
                <div class="item">
                    <img class="icon" src="/assets/img/icons/metro-icon.svg" alt="место отправления">
                    <div class="text">[[+metro]]</div>
                </div>
            </div>
            <div class="item">
                <img class="icon" src="/assets/img/icons/location-icon-lines.svg" alt="Причал">
                <div class="text">{$tripPiers | resource : 'pagetitle'}</div>
            </div>
        </div>

        <div class="advantages">
            [[getChunkCollection?
                &tpl=`riverTrip.previewItemAdvantage`
                &valuesLinesSeparated=`[[+previewAdvantages]]`
                &migxReferenceTvId=`24`
                &quantity=`8`
            ]]
        </div>

        {var $isTeplohodInfoService = $ticketsServiceType == 'teplohod.info'}

        {if !$isPast && $isTeplohodInfoService && $teplohodServiceId}
            <div class="teplohod-widget-nearest">
                <div class="name">Ближайшие рейсы</div>
                <div data-bind="teplohod-widget-nearest" data-widget_id="12468" data-event_id="{$teplohodServiceId}" data-date="nearest" data-limit="5" class="widget-loaded">
                    <div class="nearest-widget-empty"></div>
                </div>
            </div>
        {/if}

        <div class="catalog-item__price-wrapper">
            <div class="price">
                <div class="base">
                    <span class="price-prefix">от</span>{$price} <span class="ruble">₽</span>
                </div>
                {if $discountPrice}
                    <div class="discount">
                        {$discountPrice} <span class="ruble">₽</span>
                    </div>
                {/if}
            </div>
        </div>
    </div>

    <div class="buttons">
        <a href="[[+uri]]" class="base-button transparent">Подробнее</a>

        {if is_null($ticketsServiceType)}
            {var $ticketsId = $teplohodServiceId}
            {set $ticketsServiceType = 'teplohod.info'}
        {/if}
        {if $ticketsServiceType == 'teplohod.info'}
            {var $ticketsId = $teplohodServiceId}
        {/if}
        {if $ticketsServiceType == 'radario.ru'}
            {var $ticketsId = $radarioServiceId}
        {/if}
        {if $ticketsServiceType == 'незабываемая.москва'}
            {var $ticketsId = $nzMoskvaServiceId}
        {/if}

        {if !$isPast}
            {'buyButton' | chunk : [
                'classes' => 'base-button filled',
                'text' => 'Купить билеты',
                'ticketsId' => $ticketsId,
                'ticketsServiceType' => $ticketsServiceType
            ]}
        {else}
            <div class="base-button filled">Распродано</div>
        {/if}
    </div>
</div>
