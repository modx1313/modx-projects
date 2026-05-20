{var $contactsArr = [
    [
        'title' => 'Адрес',
        'img' => '/assets/img/icons/location-icon-transparent.svg',
        'value' => $_modx->config.address
    ],
    [
        'title' => 'Телефон',
        'img' => '/assets/img/icons/phone-icon-blue.svg',
        'value' => $_modx->config.phone
    ],
    [
        'title' => 'Email',
        'img' => '/assets/img/icons/email-icon-blue.svg',
        'value' => $_modx->config.email
    ]
]}

<div class="homepage contacts-page">
    <h1 class="base-width main-title content-block-margin">
        Контакты
    </h1>
    <div class="contacts-block base-width">
        <div class="contacts-item">
            <div class="schedule">
                <div class="row">
                    <img src="/assets/img/icons/time-filled-icon.svg" alt="" class="icon">
                    <div class="title">
                        Режим работы:
                    </div>
                </div>
                <div class="value">
                    {$_modx->config.workSchedule}
                </div>
            </div>
        </div>
        
        {foreach $contactsArr as $contact}
        <div class="contacts-item">
            <div class="schedule">
                <div class="row">
                    <img src="{$contact['img']}" alt="" class="icon">
                    <div class="title">{$contact['title']}:</div>
                </div>
                <div class="value">{$contact['value']}</div>
            </div>
        </div>
        {/foreach}
            
        <div class="contacts-item">
            <div class="social-wrapper">
                <a target="_blanc" href="[[++max]]" class="telgram">
                    <img src="/assets/img/icons/MAX.svg" alt="написать в MAX">
                </a>
                <a target="_blanc" href="[[++telegram]]" class="telgram">
                    <img src="/assets/img/icons/telegram-icon.svg" alt="написать в telegram">
                </a>
                <a target="_blanc" href="[[++vk]]" class="telgram">
                    <img src="/assets/img/icons/vk-icon.svg" alt="написать в вконтакте">
                </a>
            </div>
        </div>
    </div>
    
    <div class="map-block base-width content-block-margin">
        <div class="map-wrapper">
            {'tv.contactsMap' | resource}
        </div>
    </div>

    <div class="contacts-block base-width content-block-margin requisites">
        <div class="contacts-item">
            <form class="contacts-form" action="#" method="post" data-form-type="header-request">
                <div class="js-ajax-insert">
                    <input type="hidden" name="url" value="[[++site_url]][[*uri]]">
                    <input type="hidden" name="pagetitle" value="[[*pagetitle]]">
                        
                    <h2 class="section-title">Закажите консультацию прямо сейчас</h2>
                    
                    <div class="subtitle">Заполните форму и мы свяжемся с вами</div>
                
                    <div class="form-group js-form-group">
                        <label class="input-label default">Ваше имя</label>
                        <label class="input-label error"></label>
                        <input class="input-field required" type="text" name="name" placeholder="введите ваше имя">
                        <span class="input-error" data-error="name"></span>
                    </div>
                
                    <div class="form-group js-form-group">
                        <label class="input-label default">Ваш телефон</label>
                        <label class="input-label error"></label>
                        <input class="input-field required" type="text" name="phone" placeholder="введите ваш телефон">
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
                    
                    <button class="base-button transparent js-send-form" type="submit">Консультация</button>
                </div>
            </form>
        </div>
        <div class="contacts-item">
            <div class="title">
                Реквизиты:
            </div>
            <div class="value">
                <p>Индивидуальный предприниматель Яворский Павел Игоревич&nbsp;</p>
                <p>ИНН 774348986591</p>
                <p>ОГРН 322774600264082</p>
                <p>АО “Альфа Банк” г.Москва</p>
                <p>БИК 044525593</p>
                <p>Корреспондентский счет 30101810200000000593</p>
                <p>Расчетный счет 40802810502790005420</p>
                <p>Тел. 8(495)169-56-86</p>
                <p>Почта pavel@riversales.ru</p>
            </div>
        </div>
    </div>
    {'homepage.subscribeSection' | chunk}
</div>
