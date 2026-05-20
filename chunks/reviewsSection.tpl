<div class="reviews-section-wrapper full-width content-block-margin">
    <div class="reviews-section base-width">
        <div class="section-title
            [[!If?
               &subject=`[[+reviewsCount]]`
               &operator=`EQ`
               &operand=`0`
               &then=` no-reviews`
               &else=``
            ]]        
        ">[[*pagetitle]] - отзывы</div>
        
        [[!If?
           &subject=`[[+reviewsCount]]`
           &operator=`EQ`
           &operand=`0`
           &then=`[[$noReviewsSection]]`
           &else=`[[!ecThreadRating? &tpl=`reviews.detailedRating`]]`
        ]]
        [[!If?
           &subject=`[[+reviewsImagesSection]]`
           &operator=`EQ`
           &operand=`1`
           &then=`[[!$reviewsImageGallery]]`
           &else=``
        ]]
        
        [[!If?
           &subject=`[[+reviewsCount]]`
           &operator=`>`
           &operand=`0`
           &then=`[[!$reviewsMessagesSection? &threads=``]]`
           &else=``
        ]]
        
        <div class="hystmodal" id="review-form" aria-hidden="true">
            <div class="hystmodal__wrap">
                <div class="hystmodal__window modal-wrapper" role="dialog" aria-modal="true">
                    [[!ecForm?
                        &tplForm=`reviewsForm`
                        &tplSuccess=`reviewsFormSuccess`
                        &allowedFields=`user_name,user_email,rating,text`
                        &requiredFields=`user_name,user_email,rating,text`
                        &files=`1`
                        &antispamField=`address`
                    ]]      
                    <button data-hystclose class="hystmodal__close">Закрыть</button>
                </div>
            </div>
        </div>

        
    </div>
</div>