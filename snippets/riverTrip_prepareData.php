$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id');
$parametersResourseId = 16;
$isExcPage = in_array($modx->resource->get('parent'), [571]);

$placeholdersArr = [];
$placeholdersArr['advantagesSection'] = 0;
$placeholdersArr['deficienciesSection'] = 0;
$placeholdersArr['importantInformationSection'] = 0;
$placeholdersArr['mealOptionsSection'] = 0;
$placeholdersArr['faqSection'] = 0;
$placeholdersArr['textTagsSection'] = 0;
$placeholdersArr['mealMenuSection'] = 0;

$advantagesJson = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 28,
  'resourceId' => $resourceId
));

$deficienciesJson = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 162,
  'resourceId' => $resourceId
));

$importantInformationJson = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 32,
  'resourceId' => $resourceId
));

$mealMenuJson = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 165,
  'resourceId' => $resourceId
));

$mealOptionsJson = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 37,
  'resourceId' => $resourceId
));

$faqJson = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 39,
  'resourceId' => $parametersResourseId
));

$similarEventsTvId = $isExcPage ? 156 : 15;
$similarEventsIds = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => $similarEventsTvId,
  'resourceId' => $resourceId
));

if ($advantagesJson != 'error_result') {
    $placeholdersArr['advantagesSection'] = 1;
    $placeholdersArr['advantagesJson'] = $advantagesJson;
}

if ($deficienciesJson != 'error_result') {
    $placeholdersArr['deficienciesSection'] = 1;
    $placeholdersArr['deficienciesJson'] = $deficienciesJson;
}

if ($importantInformationJson != 'error_result') {
    $placeholdersArr['importantInformationSection'] = 1;
    $placeholdersArr['importantInformationJson'] = $importantInformationJson;
}

if ($mealMenuJson != 'error_result') {
    $placeholdersArr['mealMenuSection'] = 1;
    $placeholdersArr['mealMenuJson'] = $mealMenuJson;
}

if ($mealOptionsJson != 'error_result') {
    $placeholdersArr['mealOptionsSection'] = 1;
    $placeholdersArr['mealOptionsJson'] = $mealOptionsJson;
}

if ($faqJson != 'error_result') {
    $placeholdersArr['faqSection'] = 1;
    $placeholdersArr['faqJson'] = $faqJson;
}

if ($similarEventsIds != 'error_result') {
    $riverTripSliderJson = $pdoTools->runSnippet('getResourceParams', array(
      'resourceIds' => $similarEventsIds
    ));

    $placeholdersArr['similarEventsSection'] = 1;
    $placeholdersArr['riverTripSliderJson'] = $riverTripSliderJson;
}


$parametersPage = $modx->getObject('modResource', $parametersResourseId);
$placeholdersArr['ticketsReturnText'] = $parametersPage->getTVValue('ticketsReturn');

$modx->setPlaceholders($placeholdersArr);