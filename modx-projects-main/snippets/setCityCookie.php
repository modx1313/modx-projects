// input var - $city

if (!$city) {
    return;
}

$days = 300;
$expires = time() + 60 * 60 * 24 * $days;

setcookie(
    "city", 
    $city, 
    $expires,
    '/',
    '',
    true
);