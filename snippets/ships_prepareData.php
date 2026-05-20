$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$parametersResourseId = 16;
$resultArr = [];

$filterArr = [
    [
        'id' => 'opt01',
        'text' => 'До 30 гостей',
        'image' => '/assets/img/icons/ship-filter-1.svg'
    ],
    [
        'id' => 'opt02',
        'text' => 'До 70 гостей',
        'image' => '/assets/img/icons/ship-filter-2.svg'
    ],
    [
        'id' => 'opt03',
        'text' => 'До 150 гостей',
        'image' => '/assets/img/icons/ship-filter-3.svg'
    ],    
    [
        'id' => 'opt04',
        'text' => 'Свыше 150 гостей',
        'image' => '/assets/img/icons/ship-filter-4.svg'
    ],
    [
        'id' => 'opt05',
        'text' => 'Панорамные',
        'image' => '/assets/img/icons/ship-filter-5.svg'
    ],
];


$resultArr['filterArr'] = $filterArr;

return $resultArr;