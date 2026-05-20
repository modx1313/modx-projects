/**
 * @param int $tvId - id migx tv
 * @param str $fieldName - какое поле выводить в результате
 * 
 * @return str набор значений для TV вида списка 
 */
 
$parametersResourceId = 16; 

$pdoTools = $modx->getService('pdoTools');
 
$valuesJson = $pdoTools->runSnippet('getJsonMigxTV', array(
   'tvId' => $tvId,
   'resourceId' => $parametersResourceId
));

$valuesArr = json_decode($valuesJson, $parametersResourceId);

$output = '';

foreach ($valuesArr as $value) {
    $output .= $value[$fieldName] . '==' . $value['MIGX_id'] . '||';
}

$trimmedOutput = trim($output, '||');

return $trimmedOutput;