$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$parametersResourceId = 16;
$parametersResource = $modx->getObject('modResource', $parametersResourceId);
$articleGroupsJson = $parametersResource->getTVValue('articlesGroupsCollection');
$articleGroups = json_decode($articleGroupsJson, true);

$resultArr = [];

foreach($articleGroups as $group) {
    $id = $group['MIGX_id'];
    $name = $group['name'];
    
    $articleIds = $pdoTools->runSnippet('pdoResources', [
        'parents' => 141,
        'tvFilters' => 'article.group==' . $id,
        'returnIds' => 1,
        'limit' => 0
    ]);
    
    $count = count(explode(',', $articleIds));
    
    $resultArr['articleGroups'][$id]['id'] = $id;
    $resultArr['articleGroups'][$id]['name'] = $name;
    $resultArr['articleGroups'][$id]['count'] = $count;

}

$resultArr['dump'] = $articleGroups;
return $resultArr;