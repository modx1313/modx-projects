$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$parametersResourseId = 16;
$currentUrl = $_SERVER['REQUEST_URI'];

$resultArr = [];

$contentHtml = $modx->resource->get('content');

$dom = new DOMDocument('1.0', 'UTF-8');
@$dom->loadHTML("\xEF\xBB\xBF" . $contentHtml, LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
$h2Arr = $dom->getElementsByTagName('h2');

$contentTitles = [];

$i = 1;

foreach ($h2Arr as $h2) {
    
    $id = "index-item-" . $i;
    $contentTitles[$i]['title'] = '<a href="'.$currentUrl.'#'.$id.'">';
    $contentTitles[$i]['title'] .= $i.'. <span>'.$h2->textContent.'</span>';
    $contentTitles[$i]['title'] .= '</a>';
    $h2->setAttribute("id", $id);

    $i++;
}

$anchoredContentHtml = $dom->saveHTML();

$hasTextImage = $modx->resource->get('article.textImage') ? '1' : '0';

$riverTripIds = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 72,
  'resourceId' => $resourceId
));

if ($riverTripIds != 'error_result') {
    $riverTripSliderJson = $pdoTools->runSnippet('getResourceParams', array(
      'resourceIds' => $riverTripIds
    ));

    $resultArr['riverTripSliderJson'] = $riverTripSliderJson;
}

$resultArr['contentTitles'] = json_encode($contentTitles);
$resultArr['anchoredContent'] = $anchoredContentHtml;
$resultArr['hasTextImage'] = $hasTextImage;

return $resultArr;