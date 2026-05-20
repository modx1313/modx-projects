{var $ids = 'tv.shipInformation' | resource | split}

{var $values = 'getMigxValuesById' | snippet : [
    'parametersTvId' => 115,
    'valueIdsArr' => $ids
] | fromJSON}


<div class="important-information">
    {foreach $values as $value}
        <div class="item">{$value['text']}</div>
    {/foreach}
</div>