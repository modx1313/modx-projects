<div class="route-section">
    <div class="route-list">
        <div class="start-block">
            <div class="title">Вы начинаете</div>
            <div class="pier">
                <img class="icon" src="/assets/img/icons/location-icon-lines.svg" alt="">
                <div class="text">[[*routeStart]]</div>
            </div>
        </div>
        <div class="points-block">
            [[getChunkCollection?
            	&tpl=`@CODE <div class="item">[[+routePoint]]</div>`
            	&placeholder=`routePoint`
            	&valuesCommaSeparated=[[*routePoints]]
            ]]
            
        </div>
        <div class="end-block">
            <div class="title">Вы вернетесь</div>
            <div class="pier">
                <img class="icon" src="/assets/img/icons/location-icon-lines.svg" alt="">
                <div class="text">[[*routeEnd]]</div>
            </div>
        </div>
    </div>
    <div class="map-widget">
        [[*routeYaMaps]]
    </div>
</div>