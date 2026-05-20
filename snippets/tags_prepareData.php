$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$pastTripsIds = [274, 731, 732, 794, 795];
$isOldTripsPage = in_array($resourceId, $pastTripsIds) ? true : false;
$parametersResourseId = 16;
$placeholdersArr = [];
$placeholdersArr['oldTripsSection'] = 0;

$city = $pdoTools->runSnippet('getCityRelatedData');

$parentId = $isOldTripsPage ? $city['pastTripsId'] : $city['tripsId'];

$filterDataJson = $pdoTools->runSnippet('getFilterData', array(
    'parentId' => $parentId,
    'limit' => 9,
    'textTag' => $resourceId
));

$filterData = json_decode($filterDataJson, true);

$catalogItemsJson = $pdoTools->runSnippet('getResourceParams', array(
  'resourceIds' => $filterData['ids']
));

$oldTripsFilterDataJson = $pdoTools->runSnippet('getFilterData', array(
  'limit' => 10,
  'textTag' => $resourceId,
  'parentId' => $city['pastTripsId']
));

$oldTripsFilterData = json_decode($oldTripsFilterDataJson, true);


if ($oldTripsFilterData['ids'] && !$isOldTripsPage) {
    $riverTripSliderJson = $pdoTools->runSnippet('getResourceParams', array(
      'resourceIds' => $oldTripsFilterData['ids']
    ));

    $placeholdersArr['oldTripsSection'] = 1;
    $placeholdersArr['riverTripSliderJson'] = $riverTripSliderJson;
}


$isExcPage = in_array($modx->resource->get('parent'), [576]);
$placeholdersArr['buttonText'] = $isExcPage ? 'Выбрать экскурсию' : 'Выбрать прогулку';

$extendedTagsId = $city['extendedTagsTv'];

// ob_start();
// var_dump($city);
// $output = ob_get_clean();
// file_put_contents($_SERVER['DOCUMENT_ROOT'].'/../debug.log', $output, FILE_APPEND);

$extendedTagsJson = $pdoTools->runSnippet('getResourceTV', array(
    'tvId' => $extendedTagsId,
    'resourceId' => $parametersResourseId
));


$limit = (int)$filterData['count']['limit'];
$total = (int)$filterData['count']['total'];
$showMoreItemsBtn = (($total - $limit) > 0) ? 1 : 0;


$placeholdersArr['extendedTagsJson'] = $extendedTagsJson;
$placeholdersArr['catalogItemsJson'] = $catalogItemsJson;
$placeholdersArr['durationJson'] = json_encode($filterData['filter']['duration']);
$placeholdersArr['shipsJson'] = json_encode($filterData['filter']['ships']);
$placeholdersArr['intervalJson'] = json_encode($filterData['filter']['interval']);
$placeholdersArr['minPrice'] = json_encode($filterData['filter']['minPrice']);
$placeholdersArr['maxPrice'] = json_encode($filterData['filter']['maxPrice']);
$placeholdersArr['currentCount'] = $limit;
$placeholdersArr['totalCount'] = $total;
$placeholdersArr['parentId'] = $parentId;
$placeholdersArr['showMoreItemsBtn'] = $showMoreItemsBtn;


$modx->setPlaceholders($placeholdersArr);

return $placeholdersArr;