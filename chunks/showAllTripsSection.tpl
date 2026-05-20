{var $data = 'getCityRelatedData' | snippet}

<div class="base-width show-all-trips-section">
    <div class="text">Не нашли подходящего варианта?</div>
    <a href="{$data['tripsId'] | url}" class="base-button filled">Посмотреть все {$data['typeName']} {$data['cityName']}</a>
</div>