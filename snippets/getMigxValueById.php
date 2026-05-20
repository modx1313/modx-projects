/**
 * @param int $paramsTvId - id migx tv
 * @param int $valueId - id нужного значения поля
 * @param int $fieldName - имя поля migx
 * 
 * @return str набор значений для TV вида списка 
 */

$paramsResourceId = 16; 

$criteria['`modTemplateVarResource`.`contentid`'] = $paramsResourceId;
$criteria['`modTemplateVarResource`.`tmplvarid`'] = $paramsTvId;

$q = $modx->newQuery('modTemplateVarResource');
$q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['value']));


$q->where($criteria);

$q->prepare();
$q->stmt->execute();
$c = $q->stmt->fetchAll(PDO::FETCH_ASSOC);

$r = [];

$val = json_decode($c[0]['value'],true);
foreach ($val as $v) {
    $id = $v['MIGX_id'];

    if ($id == $valueId) {
        $r = $v;
    }
};

$result = $r[$fieldName];

return $result;