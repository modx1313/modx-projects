/**
 * @param int $limit
 * @param int $offset
 * @param int $parentId
 * 
 * @param str $priceLow
 * @param str $priceHigh
 * @param str $tag
 * @param str $ships
 * @param str $duration
 * @param str $interval
 * @param str $textTag
 * @param str $pier
 * 
 * @return str json array [
 *      ids => [ids array], 
 *      count => [
 *          limit => int, 
 *          offset => int,
 *          total => int
 *      ],
 *      filter => [    
 *          minPrice => int,
 *          maxPrice => int,
 *          tag => [id, name],
 *          duration => [id, name],
 *          interval => [id, name]
 *      ]
 *  ]
 */

try {
    $pdoTools = $modx->getService('pdoTools');
    
    $filter = [
        'tag' => (isset($tag)) ? $tag : false,
        'priceLow' => (isset($priceLow)) ? $priceLow : false,
        'priceHigh' => (isset($priceHigh)) ? $priceHigh : false,
        'ships' => (isset($ships)) ? $ships : false,
        'duration' => (isset($duration)) ? $duration : false,
        'interval' => (isset($interval)) ? $interval : false,
        'textTag' => (isset($textTag)) ? $textTag : false,
        'pier' => (isset($pier)) ? $pier : false
    ];
    
    $limit = isset($limit) ? $limit : 0;
    $offset = isset($offset) ? $offset : 0;
    $parentId = isset($parentId) ? $parentId : 10;
    
    $tagsTvId = 20;
    $priceTvId = 50;
    $shipsTvId = 27;
    $durationTvId = 55;
    $intervalTvId = 56;
    $textTagTvId = 62;
    $pierTvId = 84;
    
    $tagsCollectionTvId = 18;
    if ($parentId == 286) {
        $tagsCollectionTvId = 121;
    }

    if ($parentId == 290) {
        $tagsCollectionTvId = 122;
    }
    
    $shipsCollectionTvId = 21;
    $durationCollectionTvId = 53;
    $intervalCollectionTvId = 54;
    
    $idArr = isset($idArr) ? $idArr : [];
    
    // EXTENDED TAGS FILTER
    
    if ($filter['tag']) {
    
        $criteria['tmplvarid'] = $tagsTvId;
    
        if ($idArr) {
            $criteria['contentid:IN'] = $idArr;
        }
    
        $q = $modx->newQuery('modTemplateVarResource');
        $q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['contentid','value']));
        $q->where($criteria);
        $q->prepare();
        $q->stmt->execute();
        $tagsSqlArr = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
    
        if (!$tagsSqlArr) {
            return 'empty_result';
        }
    
        $idArr = [];
        foreach ($tagsSqlArr as $v) {
            $valArr = explode('||', $v['value']);
            if (in_array($filter['tag'], $valArr)) {
                $idArr[] = $v['contentid'];
            }
        }
        
        if (!$idArr) {
            return 'empty_result';
        }
    }
    
    // TEXT TAGS FILTER

    if ($filter['textTag']) {
        $criteria['tmplvarid'] = $textTagTvId;
    
        if ($idArr) {
            $criteria['contentid:IN'] = $idArr;
        }
    
        $q = $modx->newQuery('modTemplateVarResource');
        $q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['contentid','value']));
        $q->where($criteria);
        $q->prepare();
        $q->stmt->execute();
        $textTagsSqlArr = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
    
        if (!$textTagsSqlArr) {
            return 'empty_result';
        }
    
        $idArr = [];
        foreach ($textTagsSqlArr as $v) {
            $valArr = explode('||', $v['value']);
            if (in_array($filter['textTag'], $valArr)) {
                $idArr[] = $v['contentid'];
            }
        }
        
        if (!$idArr) {
            return 'empty_result';
        }
    }
    
    // PIERS FILTER

    if ($filter['pier']) {
        $criteria['tmplvarid'] = $pierTvId;
    
        if ($idArr) {
            $criteria['contentid:IN'] = $idArr;
        }
    
        $q = $modx->newQuery('modTemplateVarResource');
        $q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['contentid','value']));
        $q->where($criteria);
        $q->prepare();
        $q->stmt->execute();
        $piersSqlArr = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
    
        if (!$piersSqlArr) {
            return 'empty_result';
        }
    
        $idArr = [];
        foreach ($piersSqlArr as $v) {
            $valArr = explode('||', $v['value']);
            if (in_array($filter['pier'], $valArr)) {
                $idArr[] = $v['contentid'];
            }
        }
        
        if (!$idArr) {
            return 'empty_result';
        }
    }
    
    
    // PRICE FILTER
    
    if ($filter['priceLow'] || $filter['priceHigh']) {
    
        $criteria['tmplvarid'] = $priceTvId;
        
        if ($idArr) {
            $criteria['contentid:IN'] = $idArr;
        }
    
        $q = $modx->newQuery('modTemplateVarResource');
        $q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['contentid','value']));
        $q->where($criteria);
        $q->prepare();
        $q->stmt->execute();
        $priceSqlArr = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
    
        if (!$priceSqlArr) {
            return 'empty_result';
        }
        
        $priceLow = $priceLow ?: 0;
        $priceHigh = $priceHigh ?: 1000000;
    
        $priceLow = (int)$priceLow;
        $priceHigh = (int)$priceHigh;

        $idArr = [];
        foreach ($priceSqlArr as $v) {
            $priceInt = (int)$v['value'];
 
            if ($priceInt >= $priceLow && $priceInt <= $priceHigh) {
                $idArr[] = $v['contentid'];
            }
        }
        
        if (!$idArr) {
            return 'empty_result';
        }
    }
    
    
    // SHIPS FILTER
    
    if ($filter['ships']) {
    
        $criteria['tmplvarid'] = $shipsTvId;
    
        if ($idArr) {
            $criteria['contentid:IN'] = $idArr;
        }
    
        $q = $modx->newQuery('modTemplateVarResource');
        $q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['contentid','value']));
        $q->where($criteria);
        $q->prepare();
        $q->stmt->execute();
        $shipsSqlArr = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
    
        if (!$shipsSqlArr) {
            return 'empty_result';
        }
    
        $idArr = [];
        foreach ($shipsSqlArr as $v) {
            $valArr = explode('||', $v['value']);
            if (in_array($filter['ships'], $valArr)) {
                $idArr[] = $v['contentid'];
            }
        }
        
        if (!$idArr) {
            return 'empty_result';
        }
    }
    
    // DURATION FILTER
    
    if ($filter['duration']) {
    
        $criteria['tmplvarid'] = $durationTvId;
    
        if ($idArr) {
            $criteria['contentid:IN'] = $idArr;
        }
    
        $q = $modx->newQuery('modTemplateVarResource');
        $q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['contentid','value']));
        $q->where($criteria);
        $q->prepare();
        $q->stmt->execute();
        $durationSqlArr = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
    
        if (!$durationSqlArr) {
            return 'empty_result';
        }
    
        $idArr = [];
        foreach ($durationSqlArr as $v) {
            $valArr = explode('||', $v['value']);
            if (in_array($filter['duration'], $valArr)) {
                $idArr[] = $v['contentid'];
            }
        }
        
        if (!$idArr) {
            return 'empty_result';
        }
    }
    
    // INTERVAL FILTER
    
    if ($filter['interval']) {
    
        $criteria['tmplvarid'] = $intervalTvId;
    
        if ($idArr) {
            $criteria['contentid:IN'] = $idArr;
        }
    
        $q = $modx->newQuery('modTemplateVarResource');
        $q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['contentid','value']));
        $q->where($criteria);
        $q->prepare();
        $q->stmt->execute();
        $intervalSqlArr = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
    
        if (!$intervalSqlArr) {
            return 'empty_result';
        }
    
        $idArr = [];
        foreach ($intervalSqlArr as $v) {
            $valArr = explode('||', $v['value']);
            if (in_array($filter['interval'], $valArr)) {
                $idArr[] = $v['contentid'];
            }
        }
        
        if (!$idArr) {
            return 'empty_result';
        }
    }
    
    // SORT BY MENUINDEX
    
    $criteria = [];
    $criteria['parent'] = $parentId;
    $criteria['published'] = 1;
    $criteria['deleted'] = 0;
    $criteria['isfolder'] = 0;


    if ($idArr) {
        $criteria['id:IN'] = $idArr;
    }
    
    $idArr = [];
    
    $q = $modx->newQuery('modResource');
    $q->select($modx->getSelectColumns('modResource','modResource','', ['id', 'menuindex']));
    $q->where($criteria);
    $q->sortby('menuindex','ASC');
    $q->limit($limit, $offset);
    $q->prepare();
    $q->stmt->execute();
    $res = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (!$res) {
        return 'empty_result';
    }
    
    foreach ($res as $v) {
        $idArr[] = $v['id'];
    }

    if (!$limit && !$offset) {
        $totalCount = count($idArr);
        $fullIdArr = $idArr;
    } else {
        $q = $modx->newQuery('modResource');
        $q->select($modx->getSelectColumns('modResource','modResource','', ['id', 'menuindex']));
        $q->where($criteria);
        $q->sortby('menuindex','ASC');
        $q->prepare();
        $q->stmt->execute();
        $res = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
        
        foreach ($res as $v) {
            $fullIdArr[] = $v['id'];
        }   
        
        $totalCount = count($fullIdArr);
    }

    
    // GET PRICES

    $criteria = [];
    $criteria['tmplvarid'] = $priceTvId;
    
    if ($fullIdArr) {
        $criteria['contentid:IN'] = $fullIdArr;
    }

    $q = $modx->newQuery('modTemplateVarResource');
    $q->select($modx->getSelectColumns('modTemplateVarResource','modTemplateVarResource','', ['contentid','value']));
    $q->where($criteria);
    $q->prepare();
    $q->stmt->execute();
    $priceSqlArr = $q->stmt->fetchAll(PDO::FETCH_ASSOC);

    if (!$priceSqlArr) {
        return 'empty_result';
    }

    $priceArr = [];
    foreach ($priceSqlArr as $v) {
        $priceArr[] = (int)$v['value'];
    }
    
    // GET OTHER FILTERS

    $durationArr = $pdoTools->runSnippet('getFilterValues', [
        'tvId' => $durationTvId, 
        'fullIdArr' => $fullIdArr, 
        'collectionTvId' => $durationCollectionTvId
    ]);
    
    $modx->runSnippet('varDumpFileAppend', ['var' => $durationArr]);
    $shipsArr = $pdoTools->runSnippet('getFilterValues', [
        'tvId' => $shipsTvId, 
        'fullIdArr' => $fullIdArr, 
        'collectionTvId' => $shipsCollectionTvId
    ]);
    
    $intervalArr = $pdoTools->runSnippet('getFilterValues', [
        'tvId' => $intervalTvId, 
        'fullIdArr' => $fullIdArr, 
        'collectionTvId' => $intervalCollectionTvId
    ]);

    // RESULT
    
    $result = [];
    
    $result['ids'] = $idArr ?: 'empty_result';
    $result['count']['total'] = $totalCount;
    $result['count']['limit'] = $limit;
    $result['count']['offset'] = $offset;
    $result['filter']['minPrice'] = min($priceArr);
    $result['filter']['maxPrice'] = max($priceArr);
    $result['filter']['duration'] = $durationArr;
    $result['filter']['ships'] = $shipsArr;
    $result['filter']['interval'] = $intervalArr;
    
    $json = json_encode($result);
    
    return $json;

} catch (\Throwable $th) {
    $error = $th->getMessage();
    
    return $error;
}