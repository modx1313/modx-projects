use EasyComm\EasyComm;
use EasyComm\Model\ecThread;
use MODX\Revolution\Services\ContainerException;
use MODX\Revolution\Services\NotFoundException;

/** @var \MODX\Revolution\modX $modx */
/** @var easyComm $easyComm */
/** @var array $scriptProperties */
try {
    $easyComm = $modx->services->get('EasyComm');
} catch (ContainerException | NotFoundException $e) {
    $modx->log(modX::LOG_LEVEL_ERROR, "[EasyComm] Can't get EasyComm service.");
    return false;
}
$easyComm->initialize($modx->context->key, $scriptProperties);

/** @var string $thread */
$thread = $modx->getOption('thread', $scriptProperties, '');
if(empty($thread)) {
    $thread = 'resource-'.$modx->resource->get('id');
}

$ratingMax = (float)$modx->getOption('ec_rating_max', null, 5);
$ratingFields = $easyComm->getEcMessageRatingFields();
$itemReviewed = $modx->getOption('itemReviewed', $scriptProperties, '');

// Initialize an empty array
$data = array(
    'rating_max' => $ratingMax,
    'itemReviewed' => $itemReviewed
);
foreach($ratingFields as $field){
    $data = array_merge($data, array(
        $field.'_wilson' => 0,
        $field.'_simple' => 0,
        $field.'_wilson_percent' => 0,
        $field.'_simple_percent' => 0
    ));
}

/** @var MODx $modx */
/** @var ecThread $thread */
$thread = $modx->getObject(ecThread::class, array('name' => $thread));
if(!empty($thread)) {
    $data = array_merge( $data, $thread->toArray());
    $votes = $thread->getVotes();
    $count = $thread->get('count');
    foreach($ratingFields as $field) {
        $data = array_merge($data, array(
            $field.'_wilson_percent' => number_format($thread->get($field.'_wilson') / $ratingMax * 100, 3, '.', ''),
            $field.'_simple_percent' => number_format($thread->get($field.'_simple') / $ratingMax * 100, 3, '.', ''),
            // TEST only
            $field.'_votes' => array(),
        ));

        $fieldVotes = array();
        foreach($votes[$field] as $k => $v) {
            $fieldVotes[$k] = array(
                'count' => $v,
                'volume' => $count ? number_format(($v / $count) * 100.0, 2, '.', '') : 0
            );
        }
        krsort($fieldVotes, SORT_NUMERIC);
        $data[$field.'_votes'] = $fieldVotes;
    }
}

$tpl = $modx->getOption('tpl', $scriptProperties, '');
$fastMode = !empty($fastMode);
$output = $easyComm->getChunk($tpl, $data, $fastMode);

$toPlaceholder = $modx->getOption('toPlaceholder', $scriptProperties, '');
if (!empty($toPlaceholder)) {
    $modx->setPlaceholder($toPlaceholder, $output);
}
else {
    return $output;
}