/**
 * @param int $parametersTvId - id migx tv
 * @param arr $valueIdsArr - массив с id нужного значения поля
 *
 * @param str $fieldName - опциональный, имя migx поля для вывода
 * 
 * @return str набор значений для TV вида списка 
 */

if (!isset($valueIdsArr)){
    $valueIdsArr = json_decode($valueIdsJson, true);
}

if (!is_array($valueIdsArr)) {
    $valueIdsArr = explode(',', $valueIdsArr);
}

$parametersResourceId = 16; 

$criteria['`modTemplateVarResource`.`contentid`'] = $parametersResourceId;
$criteria['`modTemplateVarResource`.`tmplvarid`'] = $parametersTvId;

$q = $modx->newQuery('modTemplateVarResource');
$q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['value']));


$q->where($criteria);

$q->prepare();
$q->stmt->execute();
$c = $q->stmt->fetchAll(PDO::FETCH_ASSOC);

$r = [];

$val = json_decode($c[0]['value'],true);

if (!isset($fieldName)) {
    foreach ($val as $v) {
        $id = $v['MIGX_id'];
    
        if (in_array($id, $valueIdsArr)) {
            $r[] = $v;
        }
    }
} else {
    foreach ($val as $v) {
        $id = $v['MIGX_id'];
    
        if (in_array($id, $valueIdsArr)) {
            $r[] = $v[$fieldName];
        }
    }
    
    $r = implode(', ', $r);
    $r = trim($r);
    
    return $r;
}

$resultJson = json_encode($r);

return $resultJson;