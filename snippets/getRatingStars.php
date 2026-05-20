/**
 * @param str $rating
 *
 * return int width percent
 */

$pdoTools = $modx->getService('pdoTools');
 
try {

    $rating = $rating ?: 0;
    $rating = str_replace(',', '.', $rating);
    $rating = (float)$rating;
    $ratingSimplePercent = ($rating / 5) * 100;
    
    $output = $pdoTools->getChunk('ratingStars', array(
      'ratingSimplePercent' => $ratingSimplePercent
   
    ));
    
    return $output;

} catch (Throwable $th) {
    $err = $th->getMessage();
    
    return '';
}