use EasyComm\EasyComm;
use EasyComm\Model\ecMessage;
use EasyComm\Model\ecThread;
use EasyComm\Model\ecVote;
use MODX\Revolution\modChunk;
use MODX\Revolution\modResource;
use MODX\Revolution\Services\ContainerException;
use MODX\Revolution\Services\NotFoundException;
use ModxPro\PdoTools\Fetch;

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

/** @var ModxPro\PdoTools\Fetch $pdoFetch */
try {
    $pdoFetch = $modx->services->get(Fetch::class);
} catch (ContainerException | NotFoundException $e) {
    $modx->log(modX::LOG_LEVEL_ERROR, "[EasyComm] Can't get pdoFetch service.");
    return false;
}

$outputSeparator = $modx->getOption('outputSeparator', $scriptProperties, "\n");

/** @var bool $votingEnable Голосование включено */
$votingEnable = (bool)$modx->getOption('votingEnable', $scriptProperties, false);
if($votingEnable) {
    $votingAllowGuest = (bool)$modx->getOption('votingAllowGuest', $scriptProperties, false);
    $votingConsiderIP = (bool)$modx->getOption('votingConsiderIP', $scriptProperties, false);
    // Сохраняем в сессию необходимые параметры для работы голосования
    $propertiesKey = md5(serialize($scriptProperties));
    $_SESSION['easyComm']['ecMessages'][$propertiesKey] = ['votingEnable' => $votingEnable, 'votingAllowGuest' => $votingAllowGuest, 'votingConsiderIP' => $votingConsiderIP];
}

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

// Query conditions
$select = [
    ecMessage::class => $modx->getSelectColumns(ecMessage::class, 'ecMessage'),
    ecThread::class => $modx->getSelectColumns(ecThread::class, 'Thread', 'thread_'),
];
$innerJoin = [ecThread::class => ['alias' => 'Thread', 'on' => "`ecMessage`.`thread` = `Thread`.`id`"]];
$leftJoin = [];

if(!empty($resourceFields)) {
    $resourceFields = array_merge(['id', 'pagetitle'], explode(",", $resourceFields));
    $resourceFields = array_map("trim", $resourceFields);

    $select[modResource::class] = $modx->getSelectColumns(modResource::class, 'Resource', 'resource_', $resourceFields);
    $leftJoin[modResource::class] = ['alias' => 'Resource', 'on' => "`Thread`.`resource` = `Resource`.`id`"];
}

// Получаем информацию о "своем" голосе для вывода
if($votingEnable) {
    $ip = $easyComm->getClientIp();
    $session = session_id();
    $userId = $modx->user->get('id');
    if(!empty($userId)) {
        $select[ecVote::class] = "`Vote`.`value` as `vote`";
        $leftJoin[ecVote::class] = ['alias' => 'Vote', 'on' => "`ecMessage`.`id` = `Vote`.`message` AND `Vote`.`createdby` = $userId"];
    }
    else if($votingAllowGuest) {
        $select[ecVote::class] = "`Vote`.`value` as `vote`";
        if($votingConsiderIP) {
            $leftJoin[ecVote::class] = ['alias' => 'Vote', 'on' => "`ecMessage`.`id` = `Vote`.`message` AND `Vote`.`createdby` = 0 AND (`Vote`.`session` = '$session' OR `Vote`.`ip` = '$ip')"];
        }
        else {
            $leftJoin[ecVote::class] = ['alias' => 'Vote', 'on' => "`ecMessage`.`id` = `Vote`.`message` AND `Vote`.`createdby` = 0 AND `Vote`.`session` = '$session'"];
        }

    }
}

$where = array();
if(count($threads) == 1) {
    $where['Thread.name'] = $threads[0];
}
if(count($threads) > 1) {
    $where['Thread.name:IN'] = $threads;
}

// Filter by message ids
$messages = $modx->getOption('messages', $scriptProperties, '');
if(!empty($messages)) {
    $messages = explode(",", $messages);
    $messages = array_map("trim", $messages);
    $messages = array_map("intval", $messages);
    if(!empty($messages)) {
        $where['ecMessage.id:IN'] = $messages;
    }
}

if(empty($showUnPublished)) {
    $where['ecMessage.published'] = 1;
}

if(empty($showDeleted)) {
    $where['ecMessage.deleted'] = 0;
}

if(!empty($subject)) {
    $where['ecMessage.subject'] = $subject;
}

$user = intval($modx->getOption('user', $scriptProperties, 0));
if(!empty($user)) {
    $where[$class.'.createdby'] = $user;
}

// Add custom parameters
foreach (array('where','leftJoin','innerJoin','select','groupby') as $v) {
    if (!empty($scriptProperties[$v])) {
        $tmp = $scriptProperties[$v];
        if (!is_array($tmp)) {
            $tmp = json_decode($tmp, true);
        }
        if (is_array($tmp)) {
            $$v = array_merge($$v, $tmp);
        }
    }
    unset($scriptProperties[$v]);
}

// Default parameters
$default = array(
    'class' => ecMessage::class,
    //'loadModels' => 'easyComm',
    'disableConditions' => true,
    'where' => $where,
    'select' => $select,
    'innerJoin' => $innerJoin,
    'leftJoin' => $leftJoin,
    'groupby' => 'ecMessage.id',
    'return' => 'data',
);

// Merge all properties and run!
$pdoFetch->setConfig(array_merge($default, $scriptProperties), false);

$rows = $pdoFetch->run();

/** @var $tmpChunk modChunk */
$tmpChunk = $modx->newObject(modChunk::class, array('name' => "tmp-".uniqid()));
$tmpChunk->setCacheable(false);
$gravatarDefault = $tmpChunk->process(null, $modx->getOption('ec_gravatar_default'));

$gravatarSize = $modx->getOption('ec_gravatar_size', null, 50);

$output = array();
$idx = $pdoFetch->idx;
foreach($rows as $row) {
    $row['idx'] = $idx++;
    $row['properties_key'] = isset($propertiesKey) ? $propertiesKey : "";
    $row['voting_enable'] = $votingEnable;
    $row['voting_can_vote'] = $votingEnable && (($modx->user->get('id') > 0) || $votingAllowGuest);
    $row['text_raw'] = $row['text'];
    $row['text'] = nl2br($row['text']);
    $row['reply_text_raw'] = $row['reply_text'];
    $row['reply_text'] = nl2br($row['reply_text']);

    $row['gravatar'] = $gravatarDefault;
    if(!empty($row['user_email'])) {
        $row['gravatar'] = 'https://www.gravatar.com/avatar/'.md5(strtolower($row['user_email'])).'?s='.$gravatarSize;
        if(!empty($gravatarDefault)) {
            $row['gravatar'] .= '&d='.urlencode($gravatarDefault);
        }
    }

    $row['votes_rating_percent'] = number_format($row['votes_rating'] * 100, 3, '.', '');

    $tpl = $pdoFetch->defineChunk($row);
    if (empty($tpl)) {
        $output[] = '<pre>'.$pdoFetch->getChunk('', $row).'</pre>';
    }
    else {
        $output[] = $pdoFetch->getChunk($tpl, $row);
    }
}
$log = '';
if ($modx->user->hasSessionContext('mgr') && !empty($showLog)) {
    $log .= '<pre class="pdoResourcesLog">' . print_r($pdoFetch->getTime(), 1) . '</pre>';
}

// Return output
if (!empty($toSeparatePlaceholders)) {
    $output['log'] = $log;
    $modx->setPlaceholders($output, $toSeparatePlaceholders);
}
else {
    if(empty($output) && !empty($tplEmpty)) {
        $output = $pdoFetch->getChunk($tplEmpty);
    }
    else {
        $output = implode($outputSeparator, $output);
    }
    $output .= $log;
    if (!empty($tplWrapper) && (!empty($wrapIfEmpty) || !empty($output))) {
        $data = array('output' => $output);
        if( (count($threads) == 1) && ($threadObj = $modx->getObject(ecThread::class, array('name' => $threads[0]))) ) {
            $data = array_merge($data, $threadObj->toArray());
            $ratingMax = (float)$modx->getOption('ec_rating_max', null, 5);
            $ratingFields = $easyComm->getEcMessageRatingFields();
            foreach($ratingFields as $field) {
                $data = array_merge($data, array(
                    $field.'_wilson_percent' => number_format($threadObj->get($field.'_wilson') / $ratingMax * 100, 3, '.', ''),
                    $field.'_simple_percent' => number_format($threadObj->get($field.'_simple') / $ratingMax * 100, 3, '.', ''),
                ));
            }
        }
        $output = $pdoFetch->getChunk($tplWrapper, $data);
    }
    if (!empty($toPlaceholder)) {
        $modx->setPlaceholder($toPlaceholder, $output);
    }
    else {
        return $output;
    }
}