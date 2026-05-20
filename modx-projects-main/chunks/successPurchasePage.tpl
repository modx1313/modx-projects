{var $data = 'yachts.prepareData' | snippet}

<div class="success-page base-width">
    <h1 class="main-title">Уважаемый клиент!</h1>
    
    <div class="main-text">
        Благодарим Вас за покупку билетов на нашем сайте. На Вашу 
        электронную почту, указанную на этапе оплаты, отправлено письмо 
        с электронным билетом от адресата 
        <a href="mailto:sale@teplohod.info" class="compose-email">sale@teplohod.info</a> 
        Письмо может приходить с небольшой задержкой, а также попадать в папку “Спам” 
        или “Рассылки”. Если вы его не получили, необходимо обратиться 
        за помощью к сотрудникам нашей компании.
    </div>
    
    <div class="alert-block">
        <img src="/assets/img/icons/alert-icon.svg" alt="" class="icon">
        <div class="text">
            Убедительная просьба приходить на причал минимум за 20 минут 
            до отправления. Билет можно предъявить в электронном или 
            распечатанном виде
        </div>
    </div>

    <h2 class="promocode-title">Промокод на скидку с пожеланиями</h2>
    
    <div class="promocode-text">
        Желаем Вам отличной поездки и хорошего настроения, 
        а также дарим промокод на следующую покупку. Рекомендуем 
        сделать скриншот, чтобы не потерять его!
    </div>
    
    <div class="promocode">{'tv.article.promocode' | resource}</div>
    
    <div class="line"></div>
    
    <h2 class="contact-title">
        По всем вопросам обращайтесь к нашим специалистам
    </h2>
    
    <div class="contacts-section">
        
        <div class="contacts-wrapper">
            <div class="header-phone-section">
                <div class="phone">
                    <img src="/assets/img/icons/phone-icon-blue.svg" alt="телефон" class="icon">
                    <div class="number">[[++phone]]</div>
                </div>
                <div class="work-schedule">[[++workSchedule]]</div>
            </div>
            
            <div class="header-social-section flex-wrapper">
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
        
        <a href="/" class="base-button transparent">Вернуться на страницу речных прогулок Москвы</a>
    </div>
</div>

{'homepage.subscribeSection' | chunk}