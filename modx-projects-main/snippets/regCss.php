$css = $modx->getOption('css', $scriptProperties, '');
// Получаем путь к папке и очищаем от лишних слэшей
$basePath = ltrim($modx->getOption('assets_css_path', null, 'assets/css/mk2/'), '/');
$dirPath = MODX_BASE_PATH . $basePath;

// Функция для регистрации одного файла (вынесли старую логику сюда)
$registerFile = function($relativeFilePath) use ($modx) {
    $fullPath = $relativeFilePath;
    $key = 'registered_css_' . md5($fullPath);
    
    if (!$modx->getPlaceholder($key)) {
        $realPath = MODX_BASE_PATH . $fullPath;
        if (file_exists($realPath)) {
            clearstatcache(true, $realPath);
            $version = filemtime($realPath);
            $url = '/' . $fullPath . '?v=' . $version;
            $modx->regClientCSS($url);
        }
        $modx->setPlaceholder($key, true);
    }
};

// ЕСЛИ ПЕРЕДАН КОНКРЕТНЫЙ ФАЙЛ (старый режим работы)
if ($css) {
    $css = ltrim($css, '/');
    $registerFile($basePath . $css);
    return '';
}

// ЕСЛИ ФАЙЛ НЕ ПЕРЕДАН — СКАНИРУЕМ ВСЮ ПАПКУ
if (is_dir($dirPath)) {
    // Сканируем папку и фильтруем только .css файлы
    $files = scandir($dirPath);
    foreach ($files as $file) {
        if (pathinfo($file, PATHINFO_EXTENSION) === 'css') {
            $registerFile($basePath . $file);
        }
    }
} else {
    $modx->log(modX::LOG_LEVEL_ERROR, '[regCss] Папка не найдена: ' . $dirPath);
}

return '';