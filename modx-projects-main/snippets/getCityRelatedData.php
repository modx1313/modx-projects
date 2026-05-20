$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$parentId = $modx->resource->get('parent');

$currentPageIds = [$resourceId, $parentId];

$mskIds = [10, 149, 168, 8, 196, 197, 326, 328];
$excMskIds = [571, 576];
$mskIds = array_merge($mskIds, $excMskIds);

$spbIds = [286, 294, 297, 277, 633, 646, 635, 641];
$kznIds = [290, 295, 298, 304];
$chbIds = [406, 407, 423, 408];
$samIds = [584, 589, 600, 605];

global $city;


$resultIds = [];

$pageCity = false;

if (array_intersect($currentPageIds, $mskIds)) {
    $pageCity = 'msk';
    
} else if (array_intersect($currentPageIds, $spbIds)) {
    $pageCity = 'spb';
    
} else if (array_intersect($currentPageIds, $kznIds)) {
    $pageCity = 'kzn';

} else if (array_intersect($currentPageIds, $samIds)) {
    $pageCity = 'sam';

} else if (array_intersect($currentPageIds, $chbIds)) {
    $pageCity = 'chb';
}

if ($pageCity) {
    $city = $pageCity;
    $pdoTools->runSnippet('setCityCookie', [ 
      'city' => $city 
    ]);
}

//fix for 404 page
if ($resourceId == 176) {
    $city = $_COOKIE['city'] ?: 'msk';
}

// -- MSK --

// if (array_intersect($currentPageIds, $mskIds)) {
if ($city == 'msk') {
    
    $isExcPage = array_intersect($currentPageIds, $excMskIds);
    
    $tripsId = $isExcPage ? 571 : 10;
    $pastTripsId = $isExcPage ? 572 : 149;
    $tagsId = $isExcPage ? 576 : 168;
    $extendedTagsTv = $isExcPage ? 154 : 18;
    $typeName = $isExcPage ? 'экскурсии' : 'речные прогулки';
    
    $resultIds = [
        'name' => 'msk',
        'tripsId' => $tripsId,
        'pastTripsId' => $pastTripsId,
        'tagsId' => $tagsId,
        'piersId' => 8,
        'cityMainName' => 'Москва',
        'cityName' => 'Москвы',
        'typeName' => $typeName,
        'extendedTagsTv' => $extendedTagsTv,
        'shipsId' => 196,
        'yachtsId' => 197,
        'shipTagsId' => 326,
        'yachtTagsId' => 328
    ];
    
    return $resultIds;
}

//  -- SPB --

// if (array_intersect($currentPageIds, $spbIds)) {
if ($city == 'spb') {
    $resultIds = [
        'name' => 'spb',
        'tripsId' => 286,
        'pastTripsId' => 294,
        'tagsId' => 297,
        'piersId' => 277,
        'cityMainName' => 'Санкт-Петербург',
        'cityName' => 'Санкт-Петербурга',
        'typeName' => 'речные прогулки',
        'extendedTagsTv' => 121,
        'shipsId' => 633,
        'yachtsId' => 646,
        'shipTagsId' => 635,
        'yachtTagsId' => 641
    ];
    
    return $resultIds;
} 

//  -- KAZAN --

// if (array_intersect($currentPageIds, $kznIds)) {
if ($city == 'kzn') {
    $resultIds = [
        'name' => 'kzn',
        'tripsId' => 290,
        'pastTripsId' => 295,
        'tagsId' => 298,
        'piersId' => 304,
        'cityMainName' => 'Казань',
        'cityName' => 'Казани',
        'typeName' => 'речные прогулки',
        'extendedTagsTv' => 122,
        'shipsId' => false,
        'yachtsId' => false,
    ];
    
    return $resultIds;
} 

// -- CHEBOXARI --

// if (array_intersect($currentPageIds, $chbIds)) {
if ($city == 'chb') {
    $resultIds = [
        'name' => 'chb',
        'tripsId' => 406,
        'pastTripsId' => 407,
        'tagsId' => 423,
        'piersId' => 408,
        'cityMainName' => 'Чебоксары',
        'cityName' => 'Чебоксар',
        'typeName' => 'речные прогулки',
        'extendedTagsTv' => 141,
        'shipsId' => false,
        'yachtsId' => false,
    ];

    return $resultIds;
} 

// -- SAMARA --

// if (array_intersect($currentPageIds, $samIds)) {
if ($city == 'sam') {
    $resultIds = [
        'name' => 'sam',
        'tripsId' => 584,
        'pastTripsId' => 589,
        'tagsId' => 600,
        'piersId' => 605,
        'cityMainName' => 'Самара',
        'cityName' => 'Самары',
        'typeName' => 'речные прогулки',
        'extendedTagsTv' => 159,
        'shipsId' => false,
        'yachtsId' => false,
    ];
        
    return $resultIds;
}