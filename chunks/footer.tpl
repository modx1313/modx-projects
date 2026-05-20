<footer class="footer fullscreen-width [[+additionalClasses]]">
    <div class="base-width">
        <div class="footer-main-section">
            <div class="image-section">
                <img src="/assets/img/icons/logo-large.png" alt="" class="logo">
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
            <div class="links-group links-group-clients">
                <div class="title">Клиентам</div>
                <a href="{357 | url}" class="link">Конфиденциальность</a>
                <a href="{354 | url}" class="link">Соглашение</a>
                <a href="{358 | url}" class="link">Ответы на вопросы</a>
                <a href="{359 | url}" class="link">Контакты</a>
                <a href="{5 | url}" class="link">Вкратце о нас</a>
                <a href="{998 | url}" class="link">Cookie</a>
            </div>
            <div class="links-group links-group-about">
                <div class="title">О компании</div>
                <a href="{356 | url}" class="link">Реквизиты</a>
                <a href="{355 | url}" class="link">Сотрудничество</a>
                <a href="{8 | url}" class="link">Причалы</a>
                <a href="{141 | url}" class="link">Новости</a>
                <a href="{360 | url}" class="link">Карта сайта</a>
            </div>
    
          <div class="contacts-section">
                <div class="title">Контакты</div>
                <div class="contact-block">
                    <div class="text-block">
                        <img src="/assets/img/icons/phone-icon-blue.svg" alt="телефон" class="icon">
                        <a style="color: inherit; text-decoration: none;" class="number" href="tel:[[++phone]]">[[++phone]]</a>

                    </div>
                    <div class="detail">[[++workSchedule]]</div>
                </div>
                
                <div class="contact-block">
                    <div class="text-block">
                        <img src="/assets/img/icons/email-icon-blue.svg" alt="email" class="icon">
                        <div class="text">[[++email]]</div>
                    </div>
                    <a href="mailto:[[++email]]" class="link detail">Написать на почту</a>
                </div>
                
                <div class="contact-block address-block">
                    <div class="text-block">
                        <img src="/assets/img/icons/email-icon-blue.svg" alt="email" class="icon">
                        <div class="text">[[++address]]</div>
                    </div>
                    <a href="https://yandex.ru/maps/213/moscow/house/verkhnyaya_ulitsa_3k2/Z04YcwBkQEcHQFtvfXt2d3RmYg==/?indoorLevel=1&ll=37.574961%2C55.776857&z=17.14" class="link detail">Смотреть на карте</a>
                </div>
            </div>
            <button class="base-button transparent" data-hystmodal="#header-request">Оставить заявку</button>
        </div>
    </div>

    <div class="footer-copyright-section">
        <div class="base-width">
            2015 — {'' | date : 'Y'} Riversales.ru. Речные прогулки по Москве реке в {'' | date : 'Y'} году, 
            электронные билеты со скидками на прогулки на теплоходе.
        </div>
        <div class="base-width">
            Материалы взяты из открытых источников, и размещены в целях ознакомления, а не продажи.
        </div>
    </div>
    
<!--     [[$contacts_widget]] -->
    
    
    <button class="go-to-top-btn js-go-to-top-btn js-hidden">
       <img src="/assets/img/icons/go-to-top.png" alt="кнопка перейти наверх страницы">
    </button>
</footer>


<div id="cookie_note" class="js-hidden">
    <div class='cookie-text'>
        Мы используем файлы <a class="link" href="/politika-cookie">сookies</a>! 
        Оставаясь на нашем сайте, вы соглашаетесь на их использование.
    </div>
    <button class="cookie_accept hystmodal__close"></button>
</div>
[[$hystmodal]]