<h3>
  [[+description]]
</h3>
<br>

<div>
  <b>Страница:</b> <a href="[[+url]]">[[+pagetitle]]</a>
</div>
<br>

{if $name}
    <div>
      <b>Имя:</b> [[+name]]
    </div>
{/if}

{if $email}
    <div>
      <b>Email:</b> [[+email]] 
    </div>
{/if}

{if $phone}
    <div>
      <b>Телефон:</b> [[+phone]]
    </div>
{/if}

{if $service}
    <div>
      <b>Услуга:</b> [[+service]]
    </div>
{/if}

{if $shipName}
    <div>
      <b>Название корабля:</b> [[+shipName]]
    </div>
{/if}

{if $date}
    <div>
      <b>Дата мероприятия:</b> [[+date]]
    </div>
{/if}

{if $guests}
    <div>
      <b>Количетсво гостей:</b> [[+guests]]
    </div>
{/if}

{if $eventType}
    <div>
      <b>Вид мероприятия:</b> [[+eventType]]
    </div>
{/if}

{if $hours}
    <div>
      <b>Количество часов:</b> [[+hours]]
    </div>
{/if}

{if $place}
    <div>
      <b>Район плавания:</b> [[+place]]
    </div>
{/if}

{if $price}
    <div>
      <b>Стоимость аренды:</b> [[+price]]
    </div>
{/if}

{if $foodType}
    <div>
      <b>Вид питания:</b> [[+foodType]]
    </div>
{/if}

{if $comment}
    <div>
      <b>Дополнительные комментарии:</b> [[+comment]]
    </div>
{/if}

{if $question}
    <div>
      <b>Вопрос:</b> [[+question]]
    </div>
{/if}

<br>

<div>
  Оставлена {'' | date :"d.m.Y в H:i"}
</div>


