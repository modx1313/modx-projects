$tvVarId = 11;
$resourceId = 28;

try
{
    $res = $modx->getObject(
        'modTemplateVarResource', 
        ['tmplVarId' => $tvVarId, 'contentId' => $resourceId]
    );
    
    $values = $res->get('value');
}
catch(Throwable $ex)
{
    return false;
}

var_dump($values);