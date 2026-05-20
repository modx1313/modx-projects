<div class="reviews-section base-width content-block-margin">
    <div class="section-title">Отзывы</div>
    
    [[!$reviews.detailedRating? 
        &rating_simple=`[[+reviews_rating_simple]]`
        &rating_simple_percent=`[[+reviews_rating_simple_percent]]`
        &rating_max=`[[+reviews_rating_max]]`
        &rating_votes=`[[+reviews_rating_votes]]`
        &count=`[[+reviews_count]]`
    ]]
    
    [[!$reviewsImageGallery]]

    [[!$reviewsMessagesSection? &threads=`[[+reviewsFilter]]`]]
    
    <div class="hystmodal" id="review-form" aria-hidden="true">
        <div class="hystmodal__wrap">
            <div class="hystmodal__window modal-wrapper" role="dialog" aria-modal="true">
                [[!ecForm?
                    &tplForm=`reviewsForm`
                    &tplSuccess=`reviewsFormSuccess`
                    &allowedFields=`user_name,user_email,rating,text`
                    &requiredFields=`user_name,user_email,rating,text`
                    &files=`1`
                ]]      
                <button data-hystclose class="hystmodal__close">Закрыть</button>
            </div>
        </div>
    </div>

    
</div>
