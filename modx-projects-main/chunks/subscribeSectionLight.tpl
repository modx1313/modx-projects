<div class="subscribe-section-wrapper base-width"  data-form-type="subscribe">
    <div class="subscribe-section-light">
        <h3 class="title">Подписаться на рассылку</h3>

        <form action="#" method="post" data-form-type="subscribe">
            <div class="js-ajax-insert">
                <input type="hidden" name="url" value="[[++site_url]][[*uri]]">
                <input type="hidden" name="pagetitle" value="[[*pagetitle]]">
                    
                <div class="form-group js-form-group">
                    
                    <label class="input-label error"></label>
                    <input class="input-field required" type="email" name="email" placeholder="Ваш email">
    
                    <button class="base-button filled js-send-form">Подписаться</button>
                </div>
                
            </div>
            <div class="form-agreement-section js-form-agreement-section">
                <div class="agreement-wrapper">
                    <div class="agreement-btn js-agreement-btn">
                        <img src="/assets/img/icons/checkbox-checked-white.png" alt="" class="checkbox-icon checked">
                        <img src="/assets/img/icons/checkbox-empty-white.png" alt="" class="checkbox-icon empty">
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
        </form>
    </div>
</div>
