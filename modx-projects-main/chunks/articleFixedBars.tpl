{var $text = 'getMigxValuesById' | snippet : [
    'parametersTvId' => 147,
    'valueIdsArr' => 'tv.fixedBarLink' | resource,
    'fieldName' => 'text'
]}
{var $link = 'getMigxValuesById' | snippet : [
    'parametersTvId' => 147,
    'valueIdsArr' => 'tv.fixedBarLink' | resource,
    'fieldName' => 'link'
]}

<div class="fixed-bar bottom article" data-hystfixed>
    <div class="wrapper base-width">
        <div class="text">
            Желаете разнообразить досуг?
        </div>

        <a class="base-button filled" href="{$link}">
            {$text}
        </a>
    </div>
</div>