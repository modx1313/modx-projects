<div class="reviews-form">
    <form class="form well ec-form" method="post" role="form" id="ec-form-{$fid}" data-fid="{$fid}" action="" {if $files}formenctype="multipart/form-data"{/if}>
        <input type="hidden" name="thread" value="{$thread}">
        <input type="hidden" name="MAX_FILE_SIZE" value="{'upload_maxsize'|option}">
    
        <h2 class="section-title">{'ec_fe_message_add' | lexicon}</h2>
    
        <div class="form-group">
            <label for="ec-user_name-{$fid}" class="control-label input-label">Ваше имя</label>
            <input type="text" name="user_name" class="form-control input-field" id="ec-user_name-{$fid}" value="" placeholder="введите ваше имя" />
            <span class="ec-error input-error help-block" id="ec-user_name-error-{$fid}">Укажите имя</span>
        </div>
    
        <div class="form-group">
            <label for="ec-user_email-{$fid}" class="control-label input-label">{'ec_fe_message_user_email' | lexicon}</label>
            <input type="text" name="user_email" class="form-control input-field" id="ec-user_email-{$fid}" value="" placeholder="введите ваш email" />
            <span class="ec-error input-error help-block" id="ec-user_email-error-{$fid}"></span>
        </div>
    
        <div class="form-group ec-antispam">
            <label for="ec-{$antispam_field}-{$fid}" class="control-label">{'ec_fe_message_antismap' | lexicon}</label>
            <input type="text" name="{$antispam_field}" class="form-control" id="ec-{$antispam_field}-{$fid}" value="" />
        </div>

        <div class="form-group">
            <label for="ec-rating-{$fid}" class="control-label input-label">{'ec_fe_message_rating' | lexicon}</label>
            <input type="hidden" name="rating" id="ec-rating-{$fid}" value="" />
            <div class="ec-rating ec-clearfix" data-storage-id="ec-rating-{$fid}">
                <div class="ec-rating-stars stars">
                    <span data-rating="1" data-description="Плохо"></span>
                    <span data-rating="2" data-description="Не очень"></span>
                    <span data-rating="3" data-description="Средне"></span>
                    <span data-rating="4" data-description="Хорошо"></span>
                    <span data-rating="5" data-description="Отлично!"></span>
                </div>
                <div class="ec-rating-description stars-description">Пожалуйста, оцените по 5 бальной шкале</div>
            </div>
            <span class="ec-error input-error help-block" id="ec-rating-error-{$fid}"></span>
        </div>
    
        <div class="form-group">
            <label for="ec-text-{$fid}" class="control-label input-label">{'ec_fe_message_text' | lexicon}</label>
            <textarea name="text" class="form-control input-field" rows="5" id="ec-text-{$fid}" placeholder="введите текст отзыва"></textarea>
            <span class="ec-error input-error help-block" id="ec-text-error-{$fid}"></span>
        </div>
    
        <div class="form-group">
            <label for="ec-files-[[+fid]]" class="control-label input-label">{'ec_fe_message_files' | lexicon}</label>
            <input type="file" name="files[]" id="ec-files-[[+fid]]" multiple="multiple" >
            <span class="ec-error help-block" id="ec-files-error-[[+fid]]"></span>
            
            <script src="/assets/js/input-file.min.js"></script>
            <script>
        		new InputFile({
        		    buttonText: 'Выберите фотографии',
        		    hint: 'или перетащите их сюда',
        		    message: 'фото выбрано'
        		});
        	</script>
        </div>
        
        <div class="personal-data">Нажимая на кнопку "Отправить", вы соглашаетесь с <a href="/o-kompanii/politika-obrabotki-personalnykh-dannykh">Политикой конфиденциальности</a></div>
    
        <div class="form-actions">
            <input type="submit" class="btn btn-primary base-button modal pointer norepeat" name="send" value="{'ec_fe_send' | lexicon}" />
        </div>
    </form>
    <div id="ec-form-success-{$fid}"></div>

</div>