{var $cityData = 'getCityRelatedData' | snippet}

{
    "@type": "ListItem",
    "position": 1,
    "name": "Речные прогулки {$cityData['cityName']}",
    "item": "{$cityData['tripsId'] | url}"
},