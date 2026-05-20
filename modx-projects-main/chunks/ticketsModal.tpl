{var $hideGiftBtn = ('tv.hideGiftBtn' | resource) == 'Y'}

<h2 class="section-title">Стоимость и категории билетов</h2>

<div class="tickets-table">
    [[getChunkCollection?
    	&tpl=`ticketItem`
    	&valuesJson=`[[*ticketsTable]]`
    ]]
</div>

{'buyButton' | chunk : [
    'classes' => 'base-button filled',
    'text' => 'Купить билеты'
    'hideNzMoskvaButton' => 1
]}

{'buyButton' | chunk : [
    'classes' => 'base-button transparent',
    'text' => 'Открыть расписание',
    'hideNzMoskvaButton' => 1

]}

{if !$hideGiftBtn}
    <button class="base-button transparent" data-hystmodal="#gifts-modal">Подарить</button>
{/if}