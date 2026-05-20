$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$parametersResourseId = 16;
$resultArr = [];

$city = $pdoTools->runSnippet('getCityRelatedData');

$oldTripsFilterDataJson = $pdoTools->runSnippet('getFilterData', array(
  'limit' => 10,
  'parentId' => $city['pastTripsId']
));

$oldTripsFilterData = json_decode($oldTripsFilterDataJson, true);

$oldTrips = $pdoTools->runSnippet('getResourceParams', array(
  'resourceIds' => $oldTripsFilterData['ids']
));

$resultArr['oldTrips'] = $oldTrips;


$tripsFilterDataJson = $pdoTools->runSnippet('getFilterData', array(
  'limit' => 10,
  'parentId' => $city['tripsId']
));

$tripsFilterData = json_decode($tripsFilterDataJson, true);

$trips = $pdoTools->runSnippet('getResourceParams', array(
  'resourceIds' => $tripsFilterData['ids']
));

$resultArr['trips'] = $trips;
$resultArr['oldTrips'] = $oldTrips;
$resultArr['city'] = $city;


return $resultArr;