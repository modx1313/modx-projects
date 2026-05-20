const PAST_CATALOGS = [149, 294, 295, 407, 589];

if (!$parent) {
    return false;
}

$result = in_array($parent, PAST_CATALOGS);

return $result;