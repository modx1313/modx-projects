$pdoTools = $modx->getService('pdoTools');
$parametersResourseId = 16; 

$reviewsFilter = $pdoTools->runSnippet('getReviewsFilter');

$placeholdersArr['reviewsImagesSection'] = 0;
$reviewsImagesJson = $pdoTools->runSnippet('getReviewsImages', array(
    'reviewsIdsFilter' => $reviewsFilter
));

$reviewsJson = $pdoTools->runSnippet('getAllReviewsRating', array(
    'reviewsIdsFilter' => $reviewsFilter
));


if ($reviewsImagesJson != 'error_result') {
    $placeholdersArr['reviewsImagesSection'] = 1;
    $placeholdersArr['reviewsImagesJson'] = $reviewsImagesJson;
}

if ($reviewsJson != 'error_result') {
    $reviewsArr = json_decode($reviewsJson, true);
    
    foreach ($reviewsArr as $k => $v) {
        $placeholdersArr['reviews_'.$k] = json_encode($v);
    }
}

$placeholdersArr['reviewsFilter'] = $reviewsFilter;

$modx->setPlaceholders($placeholdersArr);