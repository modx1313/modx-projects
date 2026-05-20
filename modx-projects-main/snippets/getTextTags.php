$pdoTools = $modx->getService('pdoTools');
$parent = $modx->resource->get('parent');

$cityData = $pdoTools->runSnippet('getCityRelatedData');
$tagParent = $cityData['tagsId'];

$result = '@SELECT `pagetitle`,`id` FROM `[[+PREFIX]]site_content` WHERE `published`=1 AND `deleted`=0 AND `parent`=' . $tagParent;

return $result;