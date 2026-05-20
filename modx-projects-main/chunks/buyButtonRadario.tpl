{var $ticketsServiceId = $ticketsId ?: 'tv.radarioServiceId' | resource}

<vendor {$classes} id="radario{$ticketsServiceId}" radario-button data-radario-id="{$ticketsServiceId}">
    <script>
        radario.Widgets.Afisha({
             "params":{
                "eventType":"schedule",
                "textBtnColor":"#FFFFFF",
                "accentColor":"rgba(35, 119, 163, 1)"
             },
             "buttonText":"{$text}",
             "standalone":false,
             "createButton":true,
             "key":"{$ticketsServiceId}"
        })
    </script>
</vendor>
