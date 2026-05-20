<!doctype html>
<html lang="ru" prefix="og: //ogp.me/ns#">

[[$head]]

<body>
    [[riverTrip.prepareData]]
    [[!riverTrip.prepareUncachedData]]
    
    [[$header]]
    [[$tripNavbar]]
    <main class="main-content">
        [[$riverTrip.page]]
    </main>
    [[$footer? &additionalClasses=`river-trip`]]
    [[$scripts]]
</body>
</html>