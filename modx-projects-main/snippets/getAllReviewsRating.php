/**
 * @param str $reviewsIdsFilter - id ресурсов для подсчета рейтинга разделенные через запятую вида "resource-1, ..."
 * 
 * @return str json с готовыми параметрами для шаблона расширенного рейтинга
 */

use EasyComm\Model\ecMessage;

try {

    $criteria['published'] = 1;
    $criteria['deleted'] = 0;
    
    if (isset($reviewsIdsFilter)) {
        $filterArr = explode(',', $reviewsIdsFilter);
        $criteria['`EasyComm\Model\ecThread`.`name`:IN'] = $filterArr;
    }

    $q = $modx->newQuery('EasyComm\Model\ecMessage');
    $q->leftJoin('EasyComm\Model\ecThread', 'EasyComm\Model\ecThread', '`ecMessage`.`thread` = `EasyComm\Model\ecThread`.`id`');
    $q->select($modx->getSelectColumns('EasyComm\Model\ecMessage','ecMessage','', ['rating']));
    $q->where($criteria);
    
    $q->prepare();
    $q->stmt->execute();
    $c = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $result = [];
    
        
    $counts = [
        '5' => 0,
        '4' => 0,
        '3' => 0,
        '2' => 0,
        '1' => 0
    ];
    
    $allRatings = [];
    $sum = 0;
    
    $totalCount = count($c);

    foreach ($c as $v) {
        $counts[$v['rating']]++;
        $allRatings[] = $v['rating'];
        $sum += $v['rating']; 
    };
    
    
    foreach ($counts as $k => $v) {
        $result['rating_votes'][$k]['count'] = $v;
        $result['rating_votes'][$k]['volume'] = round(($v / $totalCount) * 100);
    }
    
    $result['rating_simple'] = round($sum / $totalCount, 1);
    $result['rating_simple_percent'] = round(($result['rating_simple'] / 5) * 100) ;
    $result['rating_max'] = 5;
    $result['count'] = $totalCount;
    
    $resultJson = json_encode($result);
    
    return $resultJson;
}

catch (Throwable $ex) {

    return 'error_result';
}