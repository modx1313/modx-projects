<form action="#" method="post" data-form-type="question" class="question-modal">
    <div class="js-ajax-insert">
        <input type="hidden" name="url" value="[[++site_url]][[*uri]]">
        <input type="hidden" name="pagetitle" value="[[*pagetitle]]">
            
        <h2 class="section-title">Задать вопрос</h2>
    
        <div class="form-group js-form-group">
            <label class="input-label default">Ваше имя</label>
            <label class="input-label error"></label>
            <input class="input-field required" type="text" name="name" placeholder="введите ваше имя*">
            <span class="input-error" data-error="name"></span>
        </div>
    
        <div class="form-group js-form-group">
            <label class="input-label default">Ваш телефон</label>
            <label class="input-label error"></label>
            <input class="input-field required" type="text" name="phone" placeholder="введите ваш телефон*">
            <span class="input-error" data-error="name"></span>
        </div>
    
        <div class="form-group js-form-group">
            <label class="input-label default">Ваш вопрос</label>
            <label class="input-label error"></label>
            <textarea class="input-field js-question-input required" name="question" rows="6" placeholder="задайте ваш вопрос"></textarea>
            <span class="input-error" data-error="question"></span>
        </div>
        
        <div class="form-agreement-section js-form-agreement-section">
            <div class="agreement-wrapper">
                <div class="agreement-btn js-agreement-btn">
                    <img src="/assets/img/icons/checkbox-checked.png" alt="" class="checkbox-icon checked">
                    <img src="/assets/img/icons/checkbox-empty.png" alt="" class="checkbox-icon empty">
                </div>
                <div class="agreement-text">
                    Ознакомлен с <a class="link" href="/o-kompanii/politika-obrabotki-personalnykh-dannykh">Политикой конфиденциальности</a> 
                    и даю <a class="link" href="/o-kompanii/soglashenie">Согласие на обработку персональных данных</a>.
                </div>    
            </div>
            <div class="agreement-error agreement-text">
                Требуется согласие
            </div>
        </div>
        
        <button class="base-button filled js-send-form" type="submit">Задать вопрос</button>
    </div>
</form>


