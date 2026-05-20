/**
 * @param int $tvId
 * @param arr $fullIdArr
 * @param int $collectionTvId
 * 
 * @return ids array || 'empty_result'
 */


$modx=new modX();
$modx->initialize('web');
$pdoTools = $modx->getService('pdoTools');

$criteria = [];
$criteria['tmplvarid'] = $tvId;

if ($fullIdArr) {
    $criteria['contentid:IN'] = $fullIdArr;
}

$q = $modx->newQuery('modTemplateVarResource');
$q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['contentid','value']));
$q->where($criteria);
$q->prepare();
$q->stmt->execute();
$sqlArr = $q->stmt->fetchAll(PDO::FETCH_ASSOC);

if (!$sqlArr) {
    return 'empty_result';
}

$resArr= [];

foreach ($sqlArr as $v) {
    $valsArr= explode('||', $v['value']);
    $resArr = array_merge($resArr, $valsArr);
}

$resArr = array_unique($resArr);

$json = $pdoTools->runSnippet('getMigxValuesById ', array(
  'parametersTvId' => $collectionTvId,
  'valueIdsArr' => $resArr
));

$resArr = json_decode($json, true);

return $resArr;