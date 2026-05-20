$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$parentId = $modx->resource->get('parent');

$pastTripsIds = [149, 294, 295];

$isPast = 0;

if (in_array($parentId, $pastTripsIds)) {
    $isPast = 1; 
} 

return $isPast;