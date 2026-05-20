function sanitize($string) {
    $result = preg_replace("/[^\p{L}0-9\s.?!\:\;\-\_\(\)\+\\/'\"\@]/u", "", $string);

    return $result;
}

$urlQuery = isset($_GET) ? sanitize($_GET) : [];


return $urlQuery;