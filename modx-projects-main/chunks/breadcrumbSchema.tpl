{var $title = $id == 10 ? 'Главная' : $menutitle}
{var $position = $idx + 1}

{if !in_array($id, [276])}
    {
        "@type": "ListItem",
        "position": {$position},
        "name": "{$title}",
        "item": "{$link}"
    }
{/if}