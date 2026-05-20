$pdoTools = $modx->getService('pdoTools');
$parent = $modx->resource->get('parent');
$cityData = $pdoTools->runSnippet('getCityRelatedData');

$tvId = $cityData['extendedTagsTv'];

$result = $pdoTools->runSnippet('getTVOptionsFromMigxTV', [
    "tvId" => $tvId,
    "fieldName" => "name"
]);

return $result;