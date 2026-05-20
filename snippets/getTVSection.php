/**
 * @param str $tvName
 * @param str $tplName
 * @param int $resourceId
 * @return str html блок
 */
 

if (!$tplName || !$tvName || !$resourceId) {
    return '';
}

$pdoTools = $modx->getService('pdoTools');
 
$tvId = $pdoTools->runSnippet('getTVIdByName', array(
   'tvName' => $tvName
));

$valuesJson = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => $tvId,
  'resourceId' => $resourceId
));

if ($valuesJson == 'error_result') {
    return '';
}

$valuesArr = json_decode($valuesJson, true);
// return var_dump($valuesArr);


$placeholdersArr = [];

$result = $pdoTools->getChunk($tplName, array(
    'valuesJson' => $valuesJson
));

return $result;

// $valueArr = json_decode($valueJson, true);

// if (count($valueArr) == 1) {
//     $result = $pdoTools->getChunk($tplName, array(
//         'tvValue' => $valueArr[0],
//     ));
    
// } else {
//     $result = $pdoTools->runSnippet('getChunkCollection', array(
//         'valueArr' => $valueArr,
//         'tplName' => $tplName
//     ));
// }

// return $result;