{var $city = 'getCityRelatedData' | snippet}

<div class="tags-section base-width content-block-margin">
    {'pdoResources' | snippet : [
        'limit' => 0,
        'tpl' => 'riverTrip.tagItem',
        'parents' => $city['tagsId']
    ]}
</div>