{var $title = 'getSectionTitle' | snippet : ['type' => $type]}

<div class="additional-section js-river-trip-additional-section 
    [[If?
        &subject=`[[+opened]]`
        &operator=`EQ`
        &operand=`1`
        &then=`js-opened`
        &else=``
    ]]
">
    <div class="title-block js-river-trip-additional-section-toggle pointer noselect">
        <div class="
            subsection-title 
            [[If?
                &subject=`[[+type]]`
                &operator=`EQ`
                &operand=`Важная информация`
                &then=`highlight-red`
                &else=``
            ]]
        ">
            [[getSectionTitle?&type=`[[+type]]`]]
        </div>
        <img src="/assets/img/icons/down-arrow-medium.svg" alt="раскрыть секцию" class="expand-button">
        <img src="/assets/img/icons/up-arrow-medium.svg" alt="свернуть секцию" class="collapse-button">
    </div>
    <div class="main-block js-can-hide
        [[If?
            &subject=`[[+opened]]`
            &operator=`EQ`
            &operand=`1`
            &then=``
            &else=`js-hidden`
        ]]
    ">
        
        [[If?
            &subject=`[[+type]]`
            &operator=`EQ`
            &operand=`Важная информация`
            &then=`[[$riverTrip.importantInformation]]`
            &else=``
        ]]
        
        [[If?
            &subject=`[[+type]]`
            &operator=`EQ`
            &operand=`Меню на борту теплохода`
            &then=`[[$riverTrip.mealmenu]]`
            &else=``
        ]]
        
        [[If?
            &subject=`[[+type]]`
            &operator=`EQ`
            &operand=`Дополнительная информация`
            &then=`[[$ship.importantInformation]]`
            &else=``
        ]]
        
        [[If?
            &subject=`[[+type]]`
            &operator=`EQ`
            &operand=`Меню питания, включенное в стоимость`
            &then=`[[$riverTrip.mealOptions]]`
            &else=``
        ]]
        
        [[If?
            &subject=`[[+type]]`
            &operator=`EQ`
            &operand=`Маршрут`
            &then=`[[$riverTrip.route]]`
            &else=``
        ]]
                
        [[If?
            &subject=`[[+type]]`
            &operator=`EQ`
            &operand=`Расположение`
            &then=`[[$riverTrip.location]]`
            &else=``
        ]]
        
        [[If?
            &subject=`[[+type]]`
            &operator=`EQ`
            &operand=`Возврат билетов`
            &then=`[[$riverTrip.ticketsReturn]]`
            &else=``
        ]]
        
        [[If?
            &subject=`[[+type]]`
            &operator=`EQ`
            &operand=`Часто задаваемые вопросы`
            &then=`[[$riverTrip.faq]]`
            &else=``
        ]]
        
    </div>
</div>