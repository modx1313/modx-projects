{var $cityData = 'getCityRelatedData' | snippet}
{var $url = $cityData['tripsId'] | url}

<div class="fixed-bar bottom">
    <div class="base-width show-all-trips-section">
        <div class="text">Не нашли подходящего варианта?</div>
        <a href="{$url}" class="base-button filled">Посмотреть все {$cityData['typeName']} {$cityData['cityName']}</a>
    </div>
</div>