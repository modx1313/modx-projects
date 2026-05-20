/**
 * @param str $resourceIds
 * 
 * @return str json
 */
$pdoTools = $modx->getService('pdoTools');

$idArr = is_string($resourceIds) ? json_decode($resourceIds, true) : $resourceIds;

$criteria['`modTemplateVarResource`.`contentid`:IN'] = $idArr;

$q = $modx->newQuery('modTemplateVarResource');

$q->leftJoin('modTemplateVar', 'modTemplateVar', 'modTemplateVarResource.tmplvarid = modTemplateVar.id');
$q->leftJoin('modResource', 'modResource', 'modTemplateVarResource.contentid = modResource.id');

$q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['contentid','tmplvarid','value']));
$q->select($modx->getSelectColumns('modTemplateVar','modTemplateVar','', ['name']));
$q->select($modx->getSelectColumns('modResource','modResource','', ['pagetitle', 'uri', 'parent', 'menuindex']));
$q->sortby('menuindex','ASC');

$q->where($criteria);

$q->prepare();
$q->stmt->execute();
$c = $q->stmt->fetchAll(PDO::FETCH_ASSOC);

$r = [];

foreach ($c as $v) {
    $resId = $v['contentid'];
    $tvId = $v['tmplvarid'];
    $tvName = $v['name'];
    $tvVal = $v['value'];
    $uri = $v['uri'];
    $pagetitle = $v['pagetitle'];
    $parent = $v['parent'];
    

    if (in_array($resId, $idArr)) {
        
        $r[$resId][$tvName] = $tvVal;
        $r[$resId]['uri'] = $uri;
        $r[$resId]['pagetitle'] = $pagetitle;
        $r[$resId]['id'] = $resId;
        $r[$resId]['parent'] = $parent;
        
        if($tvName == 'imageGallery'){
            try {
                $imagesArr = json_decode($tvVal, true);
                $r[$resId]['mainImage'] = $imagesArr[0]['image'];
                
            } catch (\Throwable $th) {
                $err = $th->getMessage();
                $r[$resId]['mainImage'] = $err;
            }
        }
        
        if($tvName == 'photoTagColor'){
            try {
                
                $tempArr[0] = $tvVal;
                $colorJson = $pdoTools->runSnippet('getMigxValuesById ', array(
                  'parametersTvId' => 48,
                  'valueIdsArr' => $tempArr
                ));
                
                $colorArr = json_decode($colorJson, true);
                
                $r[$resId]['photoTagColor'] = $colorArr[0]['color'];
                
            } catch (\Throwable $th) {
                $err = $th->getMessage();
                $r[$resId]['photoTagColor'] = $err;
            }
        
        }

    }
};

$json = json_encode($r);

return $json;