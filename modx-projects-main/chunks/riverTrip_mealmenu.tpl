
{var $mealMenuJson = 'getResourceTV' | snippet : [
  'tvId' => 165,
  'resourceId' => 'id' | resource
]}

{if $mealMenuJson && $mealMenuJson != 'error_result'}
    <div class="important-information">
        {'getChunkCollection' | snippet : [
            'tpl' => 'riverTrip.mealmenuItem',
            'valuesJson' => $mealMenuJson
        ]}
    </div>
{/if}