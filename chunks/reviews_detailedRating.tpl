<div class="rating js-detailed-rating" data-reviews-count="[[+count]]">
    <div class="main-block">
        <div class="details">
            <div class="number">
                {set $rating_simple = floatval($rating_simple)}
                {$rating_simple | number : 1 : ',' : ' '}
            </div>
            <div class="stars-wrapper">
                <div class="stars-block">
                    <div class="stars" title="{$rating_simple}" itemscope itemtype="http://schema.org/Rating">
                        <meta itemprop="name" content="{($itemReviewed ?: $_modx->resource['pagetitle']) | e}" />
                        <meta itemprop="ratingValue" content="{$rating_simple}" />
                        <meta itemprop="bestRating" content="{$rating_max}" />
                        <meta itemprop="worstRating" content="1" />
                        <span style="width: {$rating_simple_percent}%"></span>
                    </div>
                </div>
                <div class="description">
                    [[+count]] проверенных [[!getWordByNum? &words=`отзыв, отзыва, отзывов` &num=`[[+count]]`]] клиентов
                </div>    
            </div>
        </div>
        <button class="base-button filled pointer noselect desktop"  data-hystmodal="#review-form">Опубликовать отзыв</button>
    </div>
    <div class="lines-wrapper">
        <div class="lines-block">
            <div class="js-hidden">
                {if is_string($rating_votes)}
                    {$rating_votes = json_decode($rating_votes, true)}
                {/if}
            </div>
            {foreach $rating_votes as $rate => $line}
                <div class="item">
                    <div class="number">
                        <div class="text">{$rate}</div>
                        <img class="icon" src="/assets/img/icons/yellow-star-icon.svg" alt="">
                    </div>
                    <div class="progress">
                        <div class="empty"></div>
                        <div class="filled" style="width:{$line['volume']}%"></div>
                    </div>
                    <div class="count">{$line['count'] | number}</div>
                </div>
            {/foreach}
        </div>
    </div>
    <button class="base-button filled pointer noselect mobile"  data-hystmodal="#review-form">Опубликовать отзыв</button>
</div>
