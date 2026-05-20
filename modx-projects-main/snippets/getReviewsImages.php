/**
 * @param int $resourceId - id ресурса для которого получаем картинки
 * картинки отсортированы от последних к более ранним
 * 
 * @return str json с ссылками на картинки 
 */

use EasyComm\Model\ecMessage;
use EasyComm\Model\ecThread;

try {

    $criteria['files_count:>'] = 0;
    $criteria['published'] = 1;
    
    if (isset($resourceId)) {
        $criteria['`EasyComm\Model\ecThread`.`name`'] = 'resource-' . $resourceId;
    }
    
    if (isset($reviewsIdsFilter)) {
        $filterArr = explode(',', $reviewsIdsFilter);
        $criteria['`EasyComm\Model\ecThread`.`name`:IN'] = $filterArr;
    }
    
    $q = $modx->newQuery('EasyComm\Model\ecMessage');
    
    $q->leftJoin('EasyComm\Model\ecThread', 'EasyComm\Model\ecThread', '`ecMessage`.`thread` = `EasyComm\Model\ecThread`.`id`');
    $q->select($modx->getSelectColumns('EasyComm\Model\ecMessage','ecMessage','mes_', ['files']));
    $q->sortby('date','DESC');
    $q->limit(10);
    $q->where($criteria);
    
    $q->prepare();
    $q->stmt->execute();
    $c = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
    
    $r = [];
    
    foreach ($c as $v) {
        foreach ($v as $u) {
            $files = json_decode($u,true);
            
            foreach ($files as $file) {
                $r[] = $file['url'];
            }
        }
    };
    
    if (!count($r)) {
        
        return 'error_result';
    }
    
    $resultJson = json_encode($r);
    
    return $resultJson;

}

catch (Throwable $ex) {

    return 'error_result';
}