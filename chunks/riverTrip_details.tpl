{var $ships = 'tv.ships' | resource}
{var $parentId = 'parent' | resource}
{var $hideRoute = 'tv.hideRoute' | resource}
{var $ticketsServiceType = 'tv.ticketsServiceType' | resource}
{var $isTeplohodInfoService = $ticketsServiceType == 'teplohod.info'}
{var $teplohodServiceId = 'tv.teplohodServiceId' | resource}
{var $isPast = in_array($parentId, [149, 294, 295, 407, 589])}

{var $isExcPage = in_array($parentId, [571])}
{var $departureText = $isExcPage ? 'Место начала' : 'Причал отправления'}
{var $arrivalText = $isExcPage ? 'Место окончания' : 'Причал прибытия'}

<div class="details-section">
    {'description_block' | chunk : [
        'text' => $_modx->resource.content
    ]}
    
    <div class="summary">
        <div class="row">
            <div class="name-wrapper">
                <img src="/assets/img/icons/location-icon-lines.svg" alt="" class="icon">
                <div class="name">{$departureText}</div>
            </div>
            <div class="value">[[*routeStart]]</div>
        </div>
        <div class="row">
            <div class="name-wrapper">
                <img src="/assets/img/icons/location-icon-lines.svg" alt="" class="icon">
                <div class="name">{$arrivalText}</div>
            </div>
            <div class="value">[[*routeEnd]]</div>
        </div>
        <div class="row">
            <div class="name-wrapper">
                <img src="/assets/img/icons/time-icon.svg" alt="" class="icon">
                <div class="name">Продолжительность</div>
            </div>
            <div class="value">[[*duration]]</div>
        </div>
        {if !$isPast && $isTeplohodInfoService && $teplohodServiceId}
            <div class="row">
                <div class="teplohod-widget-nearest">
                    <div class="name">Ближайшие рейсы</div>
                    <div data-bind="teplohod-widget-nearest" data-widget_id="12468" data-event_id="{$teplohodServiceId}" data-date="nearest" data-limit="5" class="widget-loaded">
                        <div class="nearest-widget-empty"></div>
                    </div>
                </div>
            </div>
        {/if}
        <div class="row">
            <div class="name-wrapper">
                <img src="/assets/img/icons/schedule-icon.svg" alt="" class="icon">
                <div class="name">Расписание</div>
            </div>
            <div class="value">[[*tripSchedule]]</div>
        </div>
        {if $ships}
            <div class="row">
                <div class="name-wrapper">
                    <img src="/assets/img/icons/ship-icon-filled.svg" alt="" class="icon">
                    <div class="name">Теплоходы</div>
                </div>
                <div class="value">
                    {'getMigxValuesById' | snippet : [
                        'parametersTvId' => 21,
                        'valueIdsArr' => 'tv.ships' | resource,
                        'fieldName' => 'name'
                    ]}
                </div>
            </div>
        {/if}
    </div>
    
    
    <div class="anchor-wrapper">
        <div class="anchor" id="advantages-anchor"></div>
    </div>
    [[!If?
       &subject=`[[+advantagesSection]]`
       &operator=`EQ`
       &operand=`1`
       &then=`[[$riverTrip.advantagesSection]]`
       &else=``
    ]]
    
    <div class="anchor-wrapper">
        <div class="anchor" id="meal-anchor"></div>
    </div>
    [[If?
       &subject=`[[+mealOptionsSection]]`
       &operator=`EQ`
       &operand=`1`
       &then=`[[$riverTrip.additionalSection? &type=`Меню питания, включенное в стоимость`]]`
       &else=``
    ]]
    
    <div class="anchor-wrapper">
        <div class="anchor" id="route-anchor"></div>
    </div>
    {if $hideRoute != 'yes'}
        {'riverTrip.additionalSection' | chunk : [
            'type' => 'Маршрут',
            'opened' => 1
        ]}
    {/if}
    
    <div class="anchor-wrapper">
        <div class="anchor" id="info-anchor"></div>
    </div>

    [[If?
       &subject=`[[+importantInformationSection]]`
       &operator=`EQ`
       &operand=`1`
       &then=`[[$riverTrip.additionalSection? &type=`Важная информация` &opened=`1`]]`
       &else=``
    ]]
    
    {var $archiveTripParents = [149, 294, 295, 407, 589]}
    {var $isArchiveTrip = in_array($_modx->resource.teplohodServiceId, $archiveTripParents)} 
    {if $_modx->resource.ticketsServiceType == 'teplohod.info' && $_modx->resource.teplohodServiceId && !$isArchiveTrip}
        <script defer src="https://api.teplohod.info/v1/widget/widget.js"></script>
        <div data-lang="ru-RU" data-id="12458" data-event-id="{$_modx->resource.teplohodServiceId}" class="teplohod-info-wrapper"></div>
    {/if}

    <div class="anchor-wrapper">
        <div class="anchor" id="mealmenu-anchor"></div>
    </div>
    
    [[If?
       &subject=`[[+mealMenuSection]]`
       &operator=`EQ`
       &operand=`1`
       &then=`[[$riverTrip.additionalSection? &type=`Меню на борту теплохода`]]`
       &else=``
    ]]

    <div class="anchor-wrapper">
        <div class="anchor" id="location-anchor"></div>
    </div>
    [[$riverTrip.additionalSection? &type=`Расположение`]]
    
    <div class="anchor-wrapper">
        <div class="anchor" id="refund-anchor"></div>
    </div>
    [[$riverTrip.additionalSection? &type=`Возврат билетов`]]
    
    <div class="anchor-wrapper">
        <div class="anchor" id="questions-anchor"></div>
    </div>
    {if !$isExcPage}
        [[$riverTrip.additionalSection? &type=`Часто задаваемые вопросы`]]
    {/if}
</div>