$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$parametersResourseId = 16;
$resultArr = [];

$filterArr = [
    [
        'id' => 'opt01',
        'text' => 'Яхты до 15 персон',
        'image' => '/assets/img/icons/ship-filter-1.svg'
    ],
    [
        'id' => 'opt02',
        'text' => 'Яхты свыше 15 персон',
        'image' => '/assets/img/icons/ship-filter-2.svg'
    ],
    [
        'id' => 'opt03',
        'text' => 'Парусные яхты',
        'image' => '/assets/img/icons/yacht-filter-1.svg'
    ],    
    [
        'id' => 'opt04',
        'text' => 'Катера с капитаном',
        'image' => '/assets/img/icons/yacht-filter-2.svg'
    ],
    [
        'id' => 'opt05',
        'text' => 'Катера без капитана',
        'image' => '/assets/img/icons/yacht-filter-3.svg'
    ],
];


$resultArr['filterArr'] = $filterArr;

return $resultArr;