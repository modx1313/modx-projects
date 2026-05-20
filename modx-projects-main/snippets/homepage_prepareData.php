$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$parametersResourseId = 16;
$city = $pdoTools->runSnippet('getCityRelatedData');


$placeholdersArr = [];
$resultArr = [];

$filterDataJson = $pdoTools->runSnippet('getFilterData', array(
    'parentId' => $resourceId,
    'limit' => 9,
));

$filterData = json_decode($filterDataJson, true);
$catalogItemsJson = $pdoTools->runSnippet('getResourceParams', array(
  'resourceIds' => $filterData['ids']
));


$extendedTagsId = $city['extendedTagsTv'];
$catalogTitle = 'Каталог прогулок';
$resourceType = 'homepage';


// excursions msk
if ($resourceId == 571) {
    $catalogTitle = 'Каталог экскурсий';
    $resourceType = 'excursions';
}


$extendedTagsJson = $pdoTools->runSnippet('getResourceTV', array(
    'tvId' => $extendedTagsId,
    'resourceId' => $parametersResourseId
));

$limit = (int)$filterData['count']['limit'];
$total = (int)$filterData['count']['total'];
$showMoreItemsBtn = (($total - $limit) > 0) ? 1 : 0;


$placeholdersArr['extendedTagsJson'] = $extendedTagsJson;
$placeholdersArr['catalogItemsJson'] = $catalogItemsJson;
$placeholdersArr['durationJson'] = json_encode($filterData['filter']['duration']);
$placeholdersArr['shipsJson'] = json_encode($filterData['filter']['ships']);
$placeholdersArr['intervalJson'] = json_encode($filterData['filter']['interval']);
$placeholdersArr['minPrice'] = json_encode($filterData['filter']['minPrice']);
$placeholdersArr['maxPrice'] = json_encode($filterData['filter']['maxPrice']);
$placeholdersArr['currentCount'] = $limit;
$placeholdersArr['totalCount'] = $total;
$placeholdersArr['catalogTitle'] = $catalogTitle;
$placeholdersArr['showMoreItemsBtn'] = $showMoreItemsBtn;
$placeholdersArr['resourceType'] = $resourceType;


$textSectionImages= [
    ['image' => 'bashni-i-xramyi-kremlya-i-progulochnyie-korabli-na-moskva-reke-v-moskve.jpg'],
    ['image' => 'korabl-praga.jpeg'],
    ['image' => 'rossiya-moskva-24-maya-2021-goda-lodka-na-moskve-reke-pod-kryimskim-mostom.jpg'],
    ['image' => 'neboskrebyi-kompleksa-alyie-parusa-nad-moskvoi-rekoi-moskva.jpg'],
    ['image' => 'pamyatnik-petru-velikomu-i-progulochnyie-katera-na-moskve-reke-v-moskve-v-solnechnyii-letnii-den.jpg']
];

$placeholdersArr['textSectionImagesJson'] = json_encode($textSectionImages);

$modx->setPlaceholders($placeholdersArr);