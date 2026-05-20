<form action="#" method="post" data-form-type="ship-request">
    <div class="js-ajax-insert">
        <input type="hidden" name="url" value="[[++site_url]][[*uri]]">
        <input type="hidden" name="pagetitle" value="[[*pagetitle]]">
            
        <h2 class="section-title">Оставить заявку</h2>
        <div class="resource-name js-resource-name"></div>
    
        <div class="subtitle-block">
            <img src="/assets/img/icons/contacts-icon.svg" alt="" class="icon">
            <div class="text">Контактная информация</div>
        </div>    
        
        <div class="inputs-group">
            <div class="form-group js-form-group">
                <label class="input-label default">Ваше имя</label>
                <label class="input-label error"></label>
                <input class="input-field required" type="text" name="name" placeholder="введите ваше имя*">
                <span class="input-error" data-error="name"></span>
            </div>
        
            <div class="form-group js-form-group">
                <label class="input-label default">Ваш телефон*</label>
                <label class="input-label error"></label>
                <input class="input-field required" type="text" name="phone" placeholder="введите ваш телефон*">
                <span class="input-error" data-error="name"></span>
            </div>
        </div>
        
        <div class="form-group js-form-group">
            <label class="input-label default">Ваша электронная почта</label>
            <label class="input-label error"></label>
            <input class="input-field" type="email" name="email" placeholder="введите ваш email">
            <span class="input-error" data-error="name"></span>
        </div>
        
        <div class="subtitle-block">
            <img src="/assets/img/icons/ship-icon-filled.svg" alt="" class="icon">
            <div class="text">Детали аренды</div>
        </div>    
    
    
        <div class="inputs-group">
            <div class="form-group js-form-group">
                <label class="input-label default">Дата мероприятия</label>
                <label class="input-label error"></label>
                <input class="input-field required" type="date" name="date" placeholder="выберите дату">
                <span class="input-error" data-error="name"></span>
            </div>
        
            <div class="form-group js-form-group">
                <label class="input-label default">Количество гостей</label>
                <label class="input-label error"></label>
                <input class="input-field" type="text" name="guests" placeholder="введите кол-во гостей">
                <span class="input-error" data-error="name"></span>
            </div>
        </div>
    
        <div class="inputs-group">
            <div class="form-group js-form-group">
                <label class="input-label default">Вид мероприятия</label>
                <label class="input-label error"></label>
                <input class="input-field js-input" type="hidden" name="eventType" value="---">
                <div class="input-list-wrapper">
                    <div class="input-field list js-input-list">
                        <div class="title js-open-input-list pointer noselect">
                            <div class="text js-title">--------</div>
                            <img src="/assets/img/icons/down-arrow-medium.svg" alt="раскрыть список" class="expand-button">
                            <img src="/assets/img/icons/up-arrow-medium.svg" alt="свернуть список" class="collapse-button">
                        </div>
                        <div class="values">
                            <div class="row js-select-input-list pointer">Вечеринка</div>
                            <div class="row js-select-input-list pointer">Корпоратив</div>
                            <div class="row js-select-input-list pointer">Свадьба</div>
                            <div class="row js-select-input-list pointer">Выпускной</div>
                            <div class="row js-select-input-list pointer">Деловое мероприятие</div>
                            <div class="row js-select-input-list pointer">Другое</div>
                        </div>
                    </div>
                </div>
                <span class="input-error" data-error="name"></span>
            </div>
        
            <div class="form-group js-form-group">
                <label class="input-label default">Количество часов</label>
                <label class="input-label error"></label>
                <input class="input-field" type="text" name="hours" placeholder="введите кол-во часов">
                <span class="input-error" data-error="name"></span>
            </div>
        </div>
        
        {if $shipType == 'ship'}
            <div class="radio-input-wrapper js-form-group">
                <div class="label">Вид питания</div>
                <div class="radio-group">
                    <input type="radio" id="banquet-input" name="foodType" value="Банкет"/>
                    <label for="banquet-input">Банкет</label>
                </div>
                <div class="radio-group">
                    <input type="radio" id="buffet-input"name="foodType" value="Фуршет"/>
                    <label for="buffet-input">Фуршет</label>
                </div>
            </div>
        {/if}
        
        <div class="form-group js-form-group">
            <label class="input-label default">Дополнительные комментарии/услуги</label>
            <label class="input-label error"></label>
            <textarea class="input-field js-comment-input" name="comment" rows="6" placeholder="укажите дополнительную информацию"></textarea>
            <span class="input-error" data-error="name"></span>
        </div>
        
        <div class="inputs-group button">
            <button class="base-button filled js-send-form" type="submit">Отправить заявку</button>
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
    </div>
</form>


