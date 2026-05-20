$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$isOldTripsPage = $resourceId == 274 ? true : false;
$parametersResourseId = 16;
$placeholdersArr = [];
$isTagsFeed = $resourceId == 751;
$isPiersFeed = $resourceId == 753;

$parents = false;

if ($isTagsFeed) {
    $parent = 168;
} else if ($isPiersFeed) {
    $parent = 8;
} else {
    return false;
}

$idsStr = $pdoTools->runSnippet('pdoResources', [
    'parents' => $parent,
    'limit' => 0,
    'returnIds' => 1,
]);

$categoryIds = explode(',', $idsStr);

$cat = [];
$categories = [];

foreach ($categoryIds as $categoryId) {
    $filterTag = $isTagsFeed ? $categoryId : false;
    $filterPier = $isPiersFeed ? $categoryId : false;
    
    $filterDataJson = $pdoTools->runSnippet('getFilterData', array(
        'parentId' => 10,
        'limit' => 0,
        'textTag' => $filterTag,
        'pier' => $filterPier
    ));
    
    $filterData = json_decode($filterDataJson, true);
    
    $catalogItemsJson = $pdoTools->runSnippet('getResourceParams', array(
      'resourceIds' => $filterData['ids']
    ));
    
    $catalogItemsArr = json_decode($catalogItemsJson, true);
    
    $resultArr = [];
    foreach ($catalogItemsArr as $item) {
        if (!$item['id']) {
            continue;
        }
        $resultItem = [];
        
        $resultItem['id'] = $item['id'];
        $resultItem['price'] = $item['price'];
        $resultItem['pagetitle'] = $item['pagetitle'];
        $resultItem['categoryId'] = $categoryId;
        $resultArr[] = $resultItem;
    }
    
    if (!$resultArr) {
        continue;
    }
    
    $catalogItemsJson = json_encode($resultArr);
    
    $categories[] = $catalogItemsJson;
}

$placeholdersArr['categories'] = $categories;


return $placeholdersArr;