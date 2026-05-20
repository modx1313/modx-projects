<form action="#" method="post" data-form-type="header-request">
    <div class="js-ajax-insert">
        <input type="hidden" name="url" value="[[++site_url]][[*uri]]">
        <input type="hidden" name="pagetitle" value="[[*pagetitle]]">
            
        <h2 class="section-title">Оставить заявку</h2>
    
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
            <label class="input-label default">Интересующая услуга</label>
            <label class="input-label error"></label>
            <input class="input-field js-input" type="hidden" name="service" value="Речные прогулки">
            <div class="input-list-wrapper">
                <div class="input-field list js-input-list">
                    <div class="title js-open-input-list pointer noselect">
                        <div class="text js-title">Речные прогулки</div>
                        <img src="/assets/img/icons/down-arrow-medium.svg" alt="раскрыть список" class="expand-button">
                        <img src="/assets/img/icons/up-arrow-medium.svg" alt="свернуть список" class="collapse-button">
                    </div>
                    <div class="values">
                        <div class="row js-select-input-list">Речные прогулки</div>
                        <div class="row js-select-input-list">Аренда теплоходов</div>
                        <div class="row js-select-input-list">Аренда яхт</div>
                    </div>
                </div>
            </div>
            <span class="input-error" data-error="name"></span>
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
        
        <button class="base-button filled js-send-form" type="submit">Отправить заявку</button>
    </div>
</form>


