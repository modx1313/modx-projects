$pdoTools = $modx->getService('pdoTools');
$resourceId = $modx->resource->get('id'); 
$page = $modx->getObject('modResource', $resourceId);

$placeholdersArr['reviewsImagesSection'] = 0;

$reviewsImagesJson = $pdoTools->runSnippet('getReviewsImages', array(
  'resourceId' => $resourceId
));

$reviewsCount = $pdoTools->runSnippet('ecMessagesCount', array(
  'threads' => 'resource-'.$resourceId 
));

$reviewsCount = isset($reviewsCount) ? $reviewsCount : 0;

$placeholdersArr['reviewsCount'] = $reviewsCount;

if ($reviewsImagesJson != 'error_result') {
    $placeholdersArr['reviewsImagesSection'] = 1;
    $placeholdersArr['reviewsImagesJson'] = $reviewsImagesJson;
}

$ratingJson = $pdoTools->runSnippet('getResourceTV', array(
  'tvId' => 47,
  'resourceId' => $resourceId
));

$rating = json_decode($ratingJson, true);
$ratingValue = isset($rating[0]) ? $rating[0] : '';
$placeholdersArr['ratingMain'] = $ratingValue;
$placeholdersArr['ratingMainInt'] = intval($ratingValue);


$modx->setPlaceholders($placeholdersArr);