$result = $type;
$isExcPage = in_array($modx->resource->get('parent'), [571]);

if ($type == 'Маршрут' && $isExcPage) {
    $result = 'Достопримечательности на маршруте';
}

return $result;