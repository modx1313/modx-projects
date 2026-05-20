/** @var easyComm $easyComm */

use EasyComm\EasyComm;
use EasyComm\Model\ecMessage;
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

/** @var string $threads */
$threads = $modx->getOption('threads', $scriptProperties, '');
if($threads == '*') {
    $threads = [];
}
else {
    if(empty($threads)) {
        $thread = $modx->getOption('thread', $scriptProperties, '');
        $threads = empty($thread) ? 'resource-'.$modx->resource->get('id') : '';
    }
    $threads = explode(",", $threads);
    /** @var array $threads */
    $threads = array_map('trim', $threads);
}

$q = $modx->newQuery(ecMessage::class);
$q->innerJoin(ecThread::class, 'Thread', "ecMessage.thread = Thread.id");

if(count($threads) == 1) {
    $q->where(array(
        'Thread.name' => $threads[0]
    ));
}
if(count($threads) > 1) {
    $q->where(array(
        'Thread.name:IN' => $threads
    ));
}
if(empty($showUnPublished)) {
    $q->where(array(
        'ecMessage.published' => 1
    ));
}
if(empty($showDeleted)) {
    $q->where(array(
        'ecMessage.deleted' => 0
    ));
}
if(!empty($subject)) {
    $q->where(array(
        'ecMessage.subject' => $subject
    ));
}

return $modx->getCount(ecMessage::class, $q);