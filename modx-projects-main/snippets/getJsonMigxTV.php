/**
 * @param int $tvId - id migx tv
 * @param int $resourceId
 * @return str json 
 */

try
{   
    $res = $modx->getObject(
        'modTemplateVarResource', 
        ['tmplVarId' => $tvId, 'contentId' => $resourceId]
    );
    $values = $res->get('value');
}
catch(Throwable $ex)
{
    return 'error_result';
}

return $values;