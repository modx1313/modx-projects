/**
 * @param int $tvId
 * @param int $resourceId
 * 
 * @param int $needRawValue - без конвертации в json, необязательный
 * 
 * @return str успех = массив значений в json, ошибка = 'error_result'
 */

try
{
    $res = $modx->getObject(
        'modTemplateVarResource', 
        ['tmplvarid' => $tvId, 'contentid' => $resourceId]
    );
    
    $values = $res->get('value');
    
    $varRes = $modx->getObject(
        'modTemplateVar', 
        ['id' => $tvId]
    );
    
    $varElements = $varRes->get('elements');
    $varType = $varRes->get('type');

    $needMigxValues = false;
    
    if (stripos($varElements, 'getTVOptionsFromMigxTV') !== false) {
        $needMigxValues = true;
        $pattern = '/[^0-9]/';
        $parametersTvId = preg_replace($pattern, "", $varElements);
    }
    
    $needMigxJson = ($varType == 'migx') ? true : false;
    
    $valuesArr = explode("||", $values);
    $jsonResult = '';

    if ($needMigxValues) {
        $pdoTools = $modx->getService('pdoTools');
        $jsonResult = $pdoTools->runSnippet('getMigxValuesById',array(
            'parametersTvId' => $parametersTvId,
            'valueIdsArr' => $valuesArr
        ));
        
    } else if ($needMigxJson) {
        $jsonResult = $values;
        
    } else if (isset($needRawValue)) {
        $jsonResult = $valuesArr[0];
        
    } else {
        $jsonResult = json_encode($valuesArr);
    }
    
    return $jsonResult;    
}
catch(Throwable $ex)
{
    $error = $ex->getMessage();
    
    return 'error_result';
}