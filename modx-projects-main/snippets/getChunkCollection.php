/**
 * @param str $tpl
 * 
 * @param str $valuesJson
 * or
 * @param str $valuesCommaSeparated
 * or
 * @param str $valuesLinesSeparated
 * or
 * @param str $valuesSemicolonSeparated
 * 
 * @param str $placeholder
 * @param int $quantity
 * @param int $migxReferenceTvId - id tv из каталога параметров для расшифровки значений
 * 
 * должна быть указана как минимум
 * одна из переменных $values* и $quantity
 * 
 * @return str html блок
 */
if (isset($vardump)) { 
    var_dump($valuesJson);
}

$pdoTools = $modx->getService('pdoTools');
if (
    !isset($valuesJson) 
    && !isset($valuesCommaSeparated) 
    && !isset($valuesLinesSeparated)
    && !isset($valuesSemicolonSeparated)
) {
    $noValues = true;
} else {
    $noValues = false;
}

if (
    !isset($quantity) 
    && !isset($valuesJson) 
    && !isset($valuesCommaSeparated)
    && !isset($valuesLinesSeparated)
    && !isset($valuesSemicolonSeparated)
) {
    return '';
}

if (isset($valuesJson)) {
    if ($valuesJson == 'error_result') {
        return '';
    }
    
    $jsonArr = json_decode($valuesJson, true);
    
    if(!isset($jsonArr)) {
        return '<div style="color:red">$jsonArr is null!</div>';
    }
    
    if(!is_array($jsonArr)) {
        return '<div style="color:red">$jsonArr is not Array - '.$jsonArr.'</div>';
    }
    
    if (isset($placeholder)) {
        foreach ($jsonArr as $value) {
            $valuesArr[][$placeholder] = $value;
        }
    } else {
        $valuesArr = $jsonArr;
    }
}

if (isset($valuesCommaSeparated)) {
    $commaArr = explode(',', $valuesCommaSeparated);
    
    if (isset($placeholder)) {
        foreach ($commaArr as $value) {
            $valuesArr[][$placeholder] = $value;
        }
    } else {
        $valuesArr = $commaArr;
    }
}

if (isset($valuesLinesSeparated)) {
    $linesArr = explode('||', $valuesLinesSeparated);
    
    if (isset($placeholder)) {
        foreach ($linesArr as $value) {
            $valuesArr[][$placeholder] = $value;
        } 
    } else {
        $valuesArr = $linesArr;
    }
}

if (isset($valuesSemicolonSeparated)) {
    $semicolonArr = explode(';', $valuesSemicolonSeparated);
    
    if (isset($placeholder)) {
        foreach ($semicolonArr as $value) {
            $valuesArr[][$placeholder] = $value;
        } 
    } else {
        $valuesArr = $semicolonArr;
    }
}

if (!isset($quantity) && $valuesArr) {
    $quantity = count($valuesArr);
}

if (isset($quantity) && isset($valuesArr)) {
    $valuesArr = array_slice($valuesArr, 0, $quantity);
}


if (isset($migxReferenceTvId)) {
    
    $json = $pdoTools->runSnippet('getMigxValuesById ', array(
      'parametersTvId' => $migxReferenceTvId,
      'valueIdsArr' => $valuesArr
    ));
    
    $valuesArr = json_decode($json, true);
}

if (!isset($tpl)) {
    $tpl = '@INLINE <div style="color:red">WRONG TPL!</div>';
}

$items = [];

try {
    if ($noValues) {
        for ($i = 1; $i <= $quantity; $i++) {
            $items[] = $pdoTools->getChunk($tpl);
        }
        
    } else {
        
        if (!$valuesArr) {
            
            return '<div style="color:red">err: NULL $valuesArr!</div>';
        }
        
        foreach ($valuesArr as $key => $value) {
            $value['key'] = $key;
    
            $items[] = $pdoTools->getChunk($tpl, $value);
        }
    }
} catch (\Throwable $th) {
    
    return 'error_getChunkCollection' . $th->getMessage();
}


$output = implode("\n", $items);
return $output;