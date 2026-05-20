$pdoTools = $modx->getService('pdoTools');
$pdoFetch = $modx->getService('pdoFetch');
$resourceId = $modx->resource->get('id');
$parentId = $modx->resource->get('parent');
$parametersResourseId = 16;
$resultArr = [];

$shipType = $parentId == 326 ? 'ship' : 'yacht';


if ($shipType == 'ship') {
    $shipsParent = 196;
    $tagTvName = 'shipTags';
    
    $resultArr['catalogTitle'] = 'Теплоходы';
    $resultArr['bannerTitle'] = 'Выбрать теплоход';
    $resultArr['shipType'] = 'ship';
    $resultArr['shipText'] = 'теплоходы';
    $resultArr['shipsParent'] = $shipsParent;

} else {
    $shipsParent = 197;
    $tagTvName = 'yachtTags';
    $resultArr['catalogTitle'] = 'Яхты';
    $resultArr['bannerTitle'] = 'Выбрать яхту';
    $resultArr['shipType'] = 'yacht';
    $resultArr['shipText'] = 'яхты';
    $resultArr['shipsParent'] = $shipsParent;
}


$shipsArr = $pdoFetch->getCollection('modResource', [
    'published' => true,
    'deleted' => false
  ], 
  [
    'parents' => $shipsParent,
    'includeTVs' => $tagTvName,
    'sortby' => 'menuindex',
    'sortdir' => 'asc',
    'limit' => 0,
  ]
);

$shipsIds = [];
foreach ($shipsArr as $ship) {
    $tags = explode('||', $ship[$tagTvName]);

    if (in_array($resourceId, $tags)) {
        $shipsIds[] = $ship['id'];
    }
}
$resultArr['shipsTotal'] = count($shipsIds);
$resultArr['shipsIds'] = implode(',', $shipsIds);

return $resultArr;