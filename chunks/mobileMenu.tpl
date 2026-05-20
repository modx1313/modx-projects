<div class="wrapper">
    <button class="menu-item close-btn js-mobile-menu-close-btn" data-hystclose>Закрыть<img src="/assets/img/icons/close.png" alt="закрыть" class="close-btn-img"></button>
    <button class="menu-item close-btn js-mobile-menu-back-btn js-mobile-menu-btn js-hidden">Назад</button>
    <div class="resources js-resources-mobile-menu">
        [[pdoMenu?
            &parents=`0`
            &level=`2`
            &parentClass=`parent js-mobile-menu-parent js-mobile-menu-btn`
            &outerClass=`resources-menu`
            &rowClass=`item`
            &innerClass=`inner js-hidden js-mobile-menu-inner`
            &levelClass=`level`
            &selfClass=`self`
            &tpl=`mainMenu.item`
            &tplParentRow=`mainMenu.parentItem`
        ]]
    </div>
    <div class="menu-item info-block phone">
        <img src="/assets/img/icons/phone-icon-blue.svg" alt="телефон" class="icon">
        <div class="text">[[++phone]]</div>
    </div>
    <div class="menu-item info-block phone">
        <img src="/assets/img/icons/email-icon-blue.svg" alt="email" class="icon">
        <div class="text">[[++email]]</div>
    </div>
    <div class="menu-item info-block location js-hidden">
            <img src="/assets/img/icons/location-icon-blue.svg" alt="расположение" class="location-icon">
            <div class="text">Москва</div>
            <img src="/assets/img/icons/down-arrow-small.svg" alt="изменить расположение" class="change-icon">
    </div>
    <div class="menu-item social">
        <a target="_blanc" href="[[++max]]" class="telgram item">
            <img src="/assets/img/icons/MAX.svg" alt="написать в MAX">
        </a>
        <a target="_blanc" href="[[++telegram]]" class="telgram item">
            <img src="/assets/img/icons/telegram-icon.svg" alt="написать в telegram">
        </a>
        <a target="_blanc" href="[[++vk]]" class="telgram item">
            <img src="/assets/img/icons/vk-icon.svg" alt="написать в вконтакте">
        </a>
    </div>
    <button class="base-button transparent" data-hystmodal="#header-request">Оставить заявку</button>
    
</div>