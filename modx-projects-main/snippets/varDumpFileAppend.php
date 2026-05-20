ob_start();
var_dump($var);
$output = ob_get_clean();
file_put_contents($_SERVER["DOCUMENT_ROOT"].'/core/cache/logs/error.log', $output, FILE_APPEND);