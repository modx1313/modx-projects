/**
 * @param $words str варианты слов через запятую - (позиция, позиции, позиций)
 * @param $num int число
 * 
 * @return str подходящее слово
 */

if (!isset($num)) {
    return '$num not set (sn_id75)';
}

$num = (int)$num;

$wordsArr = explode(',', $words);

$word = $wordsArr[2];
if (strpos($num, '-') !== false) {
	return $word;
}

if($num % 10 == 1) $word = $wordsArr[0];
if($num % 10 >= 2 && $num % 10 <= 4) $word = $wordsArr[1];
if($num % 100 >= 11 && $num % 100 <= 14) $word = $wordsArr[2];
return $word;