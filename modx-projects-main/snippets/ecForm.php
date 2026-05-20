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

$tplForm = $modx->getOption('tplForm', $scriptProperties, 'tpl.ecForm');
$threadName = $modx->getOption('thread', $scriptProperties, '');
if(empty($threadName)) {
    $threadName = 'resource-'.$modx->resource->get('id');
    $scriptProperties['thread'] = $threadName;
}



$formId = $modx->getOption('formId', $scriptProperties, '');
if(empty($formId)) {
    $formId = $threadName;
    $scriptProperties['formId'] = $formId;
}


// Create ecThread object if it doesn't exist
/** @var ecThread $ecThread */
if (!$ecThread = $modx->getObject(ecThread::class, ['name' => $threadName])) {
    $ecThread = $modx->newObject(ecThread::class);
    $ecThread->fromArray([
        'resource' => $modx->resource->id,
        'name' => $threadName,
        'title' => $modx->getOption('threadTitle', $scriptProperties, ''),
    ]);
}

$ecThread->set('properties', $scriptProperties);
$ecThread->save();

$data = [
    'fid' => $formId,
    'thread' => $ecThread->get('name'),
    'antispam_field' => $modx->getOption('antispamField', $scriptProperties)
];

if ($modx->user->hasSessionContext($modx->context->get('key'))) {
    $profile = $modx->user->getOne('Profile');
    $data['user_name'] = $profile->get('fullname');
    if(empty($data['user_name'])) {
        $data['user_name'] = $modx->user->get('username');
    }
    $data['user_email'] = $profile->get('email');
}

$data['files'] = $modx->getOption('files', $scriptProperties, 0);
$data['file_types'] = $modx->getOption('fileTypes', $scriptProperties, 0);
$data['file_size'] = $modx->getOption('fileSize', $scriptProperties, 0);
$data['files_count'] = $modx->getOption('filesCount', $scriptProperties, 0);

if($modx->getOption('ec_captcha_enable')) {
    $tplFormReCaptcha = $modx->getOption('tplFormReCaptcha', $scriptProperties, 'tpl.ecForm.ReCaptcha');
    $data['recaptcha'] = $easyComm->getChunk($tplFormReCaptcha, $data);
}

return $easyComm->getChunk($tplForm, $data);