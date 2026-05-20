{var $city = 'getCityRelatedData' | snippet}
{var $places = [
    'msk' => ['Москва', 'Московская область', 'Не важно'],
    'spb' => ['Финский залив', 'Нева', 'Не важно'],
]}


<div class="base-width content-block-margin">
    <form action="#" method="post" data-form-type="ship-request" class="ships-main-form">
        <div class="js-ajax-insert">
    
            <input type="hidden" name="url" value="[[++site_url]][[*uri]]">
            <input type="hidden" name="pagetitle" value="[[*pagetitle]]">
            
            <div class="title-wrapper">
                <img src="/assets/img/icons/ship-icon-white.svg" alt="" class="icon">
                <h2 class="section-title">{$title}</h2>
            </div>
            
            <div class="input-wrapper">
                <div class="inputs-group">
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
                        <label class="input-label default">Количество гостей</label>
                        <label class="input-label error"></label>
                        <input class="input-field required" type="text" name="guests" placeholder="введите кол-во гостей*">
                        <span class="input-error" data-error="name"></span>
                    </div>
                    
                    <div class="form-group js-form-group">
                        <label class="input-label default">Количество часов</label>
                        <label class="input-label error"></label>
                        <input class="input-field required" type="text" name="hours" placeholder="введите кол-во часов*">
                        <span class="input-error" data-error="name"></span>
                    </div>
                </div>
            </div>
            
            <div class="input-wrapper js-form-group">
                <div class="label">Район плавания</div>
                <div class="radio-input-wrapper">
                    {foreach $places[$city['name']] as $place}
                        <div class="radio-group">
                            <input type="radio" id="{$place}" name="place" value="{$place}"/>
                            <label for="{$place}">{$place}</label>
                        </div>
                    {/foreach}
                </div>
            </div>
            
            <div class="input-wrapper js-form-group">
                <div class="label">Стоимость аренды</div>
                <div class="radio-input-wrapper full-width">
                    <div class="radio-group">
                        <input type="radio" id="empty-price-input" name="price" value="Не имеет значения"/>
                        <label for="empty-price-input">Не имеет значения</label>
                    </div>
                    <div class="radio-group">
                        <input type="radio" id="first-price-input"name="price" value="До 6 000 ₽/час"/>
                        <label for="first-price-input">До 6 000 ₽/час</label>
                    </div>
                    <div class="radio-group">
                        <input type="radio" id="second-price-input" name="price" value="До 10 000 ₽/час"/>
                        <label for="second-price-input">До 10 000 ₽/час</label>
                    </div>
                    <div class="radio-group">
                        <input type="radio" id="third-price-input"name="price" value="До 25 000 ₽/час"/>
                        <label for="third-price-input">До 25 000 ₽/час</label>
                    </div>
                    <div class="radio-group">
                        <input type="radio" id="fourth-price-input" name="price" value="До 150 000 ₽/час"/>
                        <label for="fourth-price-input">До 150 000 ₽/час</label>
                    </div>
                    <div class="radio-group">
                        <input type="radio" id="fifth-price-input"name="price" value="Свыше"/>
                        <label for="fifth-price-input">Свыше</label>
                    </div>
                </div>
            </div>

            
            {if $type == 'ship'}
                <div class="input-wrapper js-form-group">
                    <div class="label">Вид питания</div>
                    <div class="radio-input-wrapper">
                        <div class="radio-group">
                            <input type="radio" id="banquet-input" name="foodType" value="Банкет"/>
                            <label for="banquet-input">Банкет</label>
                        </div>
                        <div class="radio-group">
                            <input type="radio" id="buffet-input"name="foodType" value="Фуршет"/>
                            <label for="buffet-input">Фуршет</label>
                        </div>
                    </div>
                </div>
            {/if}
            
            <div class="textarea-wrapper">
                <div class="form-group js-form-group">
                    <label class="input-label default">Дополнительные комментарии/услуги</label>
                    <label class="input-label error"></label>
                    <textarea class="input-field js-comment-input" name="comment" rows="6" placeholder="укажите дополнительную информацию"></textarea>
                    <span class="input-error" data-error="name"></span>
                </div>
            </div>
            <div class="ships-main-form__bottom">
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
                
                <div class="buttons-group">
                    <button class="base-button transparent js-reset-form" type="button">Сбросить значения</button>
                    <button class="base-button filled js-send-form" type="submit">Подобрать</button>
                </div>
            </div>

        </div>
    </form>
</div>


