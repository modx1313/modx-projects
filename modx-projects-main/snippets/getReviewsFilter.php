$pdoTools = $modx->getService('pdoTools');

if (isset($resourceType)) {
    $isExcPage = $resourceType == 'excursions';
} else {
    $parentId = $modx->resource->get('parent');
    $isExcPage = in_array($parentId, [570]);
}

$parentFilterId = $isExcPage ? 570 : 285; 

$pageIdsStr = $pdoTools->runSnippet('pdoResources', array(
    'parents' => $parentFilterId,
    'limit' => 0,
    'returnIds' => 1
));

$pageIdsArr = explode(',', $pageIdsStr);

$resultFilter = '';
foreach ($pageIdsArr as $id) {
    $resultFilter .= "resource-$id,";
}

$resultFilter = rtrim($resultFilter, ',');

return $resultFilter;