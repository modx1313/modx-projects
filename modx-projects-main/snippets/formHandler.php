/**
 * @param $formId
 * @param $formTpl
 * 
 * необязательные:
 * @param $successTpl
 * @param $clearForm - 0 / 1 , default = 1;
 * @param $emailFrom - по умолчанию из настройки emailsender
 * @param $requiredFields - обязательные для заполнения поля (name тэга input) через запятую
 * @param $formDescription - название/описание формы (будет выведено в уведомлении об отправленной заявке)
 * 
 * @param $emailTo
 * @param $emailTpl
 * @param $telegramTo - id телеграм-группы
 * @param $telegramTpl
 * 
 **/
 
if (!isset($formId)) {
 return 'no formId';
}

if (isset($_SESSION['formHandler'][$formId])) {
 return 'formId "'.$formId.'" already used';
}

if (!isset($formTpl)) {
 return 'no formTpl';
}

if (isset($requiredFields)) {
    $arr = explode(',', $requiredFields);
    $requiredFieldsArr = [];
    
    foreach ($arr as $val) {
        $requiredFieldsArr[] = trim($val);
    }
    
} else {
    $requiredFieldsArr = false;
}

$emailSender = $modx->getOption('emailsender');

global $formHandler;

$formHandler[$formid]['formTpl'] = $formTpl;
$formHandler[$formid]['successTpl'] = isset($successTpl) ? $successTpl : false;
$formHandler[$formid]['clearForm'] = isset($clearForm) ? $clearForm : 1;
$formHandler[$formid]['emailFrom'] = isset($emailFrom) ? $emailFrom : $emailSender;
$formHandler[$formid]['requiredFields'] = $requiredFieldsArr;
$formHandler[$formid]['emailTo'] = isset($emailTo) ? $emailTo : false;
$formHandler[$formid]['emailTpl'] = isset($emailTpl) ? $emailTpl : false;
$formHandler[$formid]['telegramTo'] = isset($telegramTo) ? $telegramTo : false;
$formHandler[$formid]['telegramTpl'] = isset($telegramTpl) ? $telegramTpl : false;
$formHandler[$formid]['formDescription'] = isset($formDescription) ? $formDescription : false;



// $_SESSION['formHandler'][$formid]['formTpl'] = $formTpl;
// $_SESSION['formHandler'][$formid]['successTpl'] = isset($successTpl) ? $successTpl : false;
// $_SESSION['formHandler'][$formid]['clearForm'] = isset($clearForm) ? $clearForm : 1;
// $_SESSION['formHandler'][$formid]['emailFrom'] = isset($emailFrom) ? $emailFrom : $emailSender;
// $_SESSION['formHandler'][$formid]['requiredFields'] = $requiredFieldsArr;
// $_SESSION['formHandler'][$formid]['emailTo'] = isset($emailTo) ? $emailTo : false;
// $_SESSION['formHandler'][$formid]['emailTpl'] = isset($emailTpl) ? $emailTpl : false;
// $_SESSION['formHandler'][$formid]['telegramTo'] = isset($telegramTo) ? $telegramTo : false;
// $_SESSION['formHandler'][$formid]['telegramTpl'] = isset($telegramTpl) ? $telegramTpl : false;
// $_SESSION['formHandler'][$formid]['formDescription'] = isset($formDescription) ? $formDescription : false;

$pdoTools = $modx->getService('pdoTools');
$form = $pdoTools->getChunk($formTpl, array());

return $form;