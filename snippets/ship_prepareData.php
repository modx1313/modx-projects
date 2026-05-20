$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$parametersResourseId = 16;
$resultArr = [];


$featuresJson = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 113,
  'resourceId' => $resourceId
));

$featuresCrossJson = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 170,
  'resourceId' => $resourceId
));

$shipTrips = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 169,
  'resourceId' => $resourceId
));

$shipName = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 172,
  'resourceId' => $resourceId
));

$shipTripsArr = json_decode($shipTrips, true);

$tripsIds = [];
$oldTripsIds = [];

foreach ($shipTripsArr as $id) {
    $res = $modx->getObject('modResource', $id);
    if (!$res) {
        continue;
    }
    $parent = $res->get('parent');
    
    if (in_array($parent, [10, 286, 290, 406, 584])) {
        $tripsIds[] = $id;
    } else {
        $oldTripsIds[] = $id;
    }
}


$catalogItemsJson = $pdoTools->runSnippet('getResourceParams', array(
  'resourceIds' => $tripsIds 
));


$resultArr['catalogItemsJson'] = $catalogItemsJson;

$resultArr['oldTripsSection'] = 0;

if ($oldTripsIds) {
    $oldItemsJson = $pdoTools->runSnippet('getResourceParams', array(
      'resourceIds' => $oldTripsIds 
    ));
    
    $resultArr['oldTripsSection'] = 1;
    $resultArr['riverTripSliderJson'] = $oldItemsJson;
}

if ($featuresCrossJson && $featuresCrossJson != 'error_result') {
    $resultArr['featuresCross'] = json_decode($featuresCrossJson, true);
}

// ob_start();
// var_dump(json_decode($shipName)[0]);
// $output = ob_get_clean();
// file_put_contents($_SERVER['DOCUMENT_ROOT'].'/debug.log', $output, FILE_APPEND);

$resultArr['features'] = json_decode($featuresJson, true);
$resultArr['shipName'] = json_decode($shipName, true)[0];

return $resultArr;