/**
 * @param str $tvName
 * 
 * @return str tv id
 */
 
try
{
    $res = $modx->getObject(
        'modTemplateVar', 
        ['name' => $tvName]
    );
    
    $id = $res->get('id');
}
catch(Throwable $ex)
{
    $error = $ex->getMessage();
    return 'error_result';
}

return $id;