$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$parametersResourseId = 16;
$resultArr = [];

$cityRelatedData = $pdoTools->runSnippet('getCityRelatedData');
$tripParentId = $cityRelatedData['tripsId'];
$pastTripsParentId = $cityRelatedData['pastTripsId'];

$tripsFilterDataJson = $pdoTools->runSnippet('getFilterData', array(
  'limit' => 6,
  'pier' => $resourceId,
  'parentId' => $tripParentId
));

$tripsFilterData = json_decode($tripsFilterDataJson, true);

$tripsItemsJson = $pdoTools->runSnippet('getResourceParams', array(
  'resourceIds' => $tripsFilterData['ids']
));

$oldTripsFilterDataJson = $pdoTools->runSnippet('getFilterData', array(
  'limit' => 10,
  'pier' => $resourceId,
  'parentId' => $pastTripsParentId
));

$oldTripsFilterData = json_decode($oldTripsFilterDataJson, true);

$oldTripsSection = $oldTripsFilterData['ids'] ? true : false;

if ($oldTripsSection) {
    $oldTripsItemsJson = $pdoTools->runSnippet('getResourceParams', array(
      'resourceIds' => $oldTripsFilterData['ids']
    ));
}


$featuresJson = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 74,
  'resourceId' => $resourceId
));


$limit = (int)$tripsFilterData['count']['limit'];
$total = (int)$tripsFilterData['count']['total'];
$showMoreItemsBtn = (($total - $limit) > 0) ? 1 : 0;

$resultArr['tripsItemsJson'] = $tripsItemsJson;
$resultArr['oldTripsSection'] = $oldTripsSection;
$resultArr['oldTripsItemsJson'] = $oldTripsItemsJson;
$resultArr['currentCount'] = $limit;
$resultArr['totalCount'] = $total;
$resultArr['showMoreItemsBtn'] = $showMoreItemsBtn;
$resultArr['features'] = json_decode($featuresJson, true);
$resultArr['cityRelatedData'] = $cityRelatedData;

return $resultArr;