{var $parent = 'parent' | resource}
{var $id = 'id' | resource}
{var $city = 'getCityRelatedData' | snippet}

{var $shipType = array_intersect([$id, $parent], [196, 633, 326, 635]) ? 'ship' : 'yacht'}
{var $tagParent = $shipType == 'ship' ? $city['shipTagsId'] : $city['yachtTagsId']}

<div class="base-width content-block-margin">
    <div class="tags-section">
        {'pdoResources' | snippet : [
            'limit' => 0,
            'tpl' => 'riverTrip.tagItem',
            'resources' => $tagIds,
            'parents' => $tagParent
        ]}
    </div>
</div>
