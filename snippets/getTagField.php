/**
* @param str $input - массив данных в json
* @param str $options - имя нужного поля
* 
* @return str значение нужного поля
*/
 
$valuesArr = json_decode($input, true);
$result = $valuesArr[0][$options];

return $result;