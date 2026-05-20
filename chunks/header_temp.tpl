<header class="header">
    <!-- START organization microdata -->
    <div itemscope="" itemtype="https://schema.org/Organization">
        <meta itemprop="name" content="Riversales.ru - речные прогулки на теплоходах и катерах">
        <meta itemprop="telephone" content="+7-495-181-42-66">
        <meta itemprop="email" content="info@riversales.ru">
        <a itemprop="url" href="https://riversales.ru"></a>
        <div itemprop="address" itemscope="" itemtype="https://schema.org/PostalAddress">
            <meta itemprop="addressCountry" content="Россия">
            <meta itemprop="addressLocality" content="Москва">
            <meta itemprop="streetAddress" content="улица Верхняя, д.3, к.2">
            <meta itemprop="postalCode" content="125040">
        </div>
    </div>
    <!-- END organization microdata -->

    <div class="header-main-bar base-width">
        <a href="/" class="header-logo">
            <img src="/assets/img/main-logo.png" alt="Riversales">
        </a>
        {var $cityData = '!getCityRelatedData' | snippet}
        
        <div class="header-city-selector js-header-city-selector">
            <img src="/assets/img/icons/location-filled-icon.svg" alt="" class="location-icon">
            <div class="city js-city">{$cityData['cityMainName']}</div>
            <img src="/assets/img/icons/down-arrow-medium.svg" alt="" class="arrow-icon">
            <div class="city-selector-menu js-city-selector-menu">
                <div class="city-item js-select-city">Москва</div>
                <div class="city-item js-select-city">Санкт-Петербург</div>
                <div class="city-item js-select-city">Казань</div>
                <div class="city-item js-select-city">Самара</div>
                <div class="city-item js-select-city">Чебоксары</div>
            </div>
        </div>
        <div class="header-location">
            <img src="/assets/img/icons/location-icon-blue.svg" alt="расположение" class="location-icon">
            <div class="text">Москва</div>
            <img src="/assets/img/icons/down-arrow-small.svg" alt="изменить расположение" class="change-icon">
        </div>
        <div class="header-email-section">
            <div class="email">
                <img src="/assets/img/icons/email-icon-blue.svg" alt="email" class="icon">
                <div class="text">[[++email]]</div>
            </div>
            <a href="mailto:[[++email]]" class="compose-email">Написать на почту</a>
        </div>
        <div class="header-phone-section">
            <div class="phone">
                <img src="/assets/img/icons/phone-icon-blue.svg" alt="телефон" class="icon">
                <a class="number"href="tel:[[++phone]]">[[++phone]]</a>
            </div>
            <div class="work-schedule">[[++workSchedule]]</div>
        </div>
        <a href="tel:+7(495)181-42-66" class="header-phone-mobile-icon">
            <img src="/assets/img/icons/phone-icon-blue.svg" class="icon" alt="">
        </a>
        <div class="header-social-section">
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
        <button class="base-button transparent" data-hystmodal="#header-request">Оставить заявку</button>
        
        <img class="mobile-menu-btn js-open-mobile-menu noselect" src="/assets/img/icons/mobile-menu-icon.svg" alt="открыть меню" data-hystmodal="#mobile-menu">
    </div>
    
    <div class="hystmodal" id="mobile-menu" aria-hidden="true">
        <div class="hystmodal__wrap">
            <div class="hystmodal__window mobile-menu js-mobile-menu" role="dialog" aria-modal="true">
                [[$mobileMenu]] 
            </div>
        </div>
    </div>
    
    <div class="header-desktop-menu-section fullscreen-width">
        <div class="base-width">
            [[pdoMenu?
                &parents=`0`
                &level=`2`
                &parentClass=`parent`
                &outerClass=`header-desktop-menu`
                &rowClass=`item`
                &innerClass=`inner`
                &levelClass=`level`
                &selfClass=`self`
                &tpl=`mainMenu.item`
                &tplParentRow=`mainMenu.parentItem`
            ]]
        </div>
        
    </div>
    
    <div class="hystmodal" id="header-request" aria-hidden="true">
        <div class="hystmodal__wrap">
            <div class="hystmodal__window modal-wrapper" role="dialog" aria-modal="true">
                [[$headerRequestModal]] 
                <button data-hystclose class="hystmodal__close">Закрыть</button>
            </div>
        </div>
    </div>
</header>
