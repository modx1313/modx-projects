
{var $importantInformationJson = 'getResourceTV' | snippet : [
  'tvId' => 32,
  'resourceId' => 'id' | resource
]}

<div class="important-information">
    {'getChunkCollection' | snippet : [
        'tpl' => 'riverTrip.importantInformationItem',
        'valuesJson' => $importantInformationJson
    ]}

</div>