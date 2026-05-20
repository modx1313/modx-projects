{var $serviceType = $ticketsServiceType ?: 'tv.ticketsServiceType' | resource}

{if $serviceType == 'teplohod.info' || !$serviceType}
    {'buyButtonTeplohod' | chunk : [
        'classes' => $classes,
        'text' => $text,
        'ticketsId' => $ticketsId
    ]}
{/if}

{if $serviceType == 'radario.ru'}
    {'buyButtonRadario' | chunk : [
        'classes' => $classes,
        'text' => $text,
        'ticketsId' => $ticketsId
    ]}
{/if}

{if $serviceType == 'незабываемая.москва' && !$hideNzMoskvaButton}
    {'buyButtonNzMoskva' | chunk : [
        'classes' => $classes,
        'text' => $text,
        'ticketsId' => $ticketsId
    ]}
{/if}
