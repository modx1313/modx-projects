{var $lastChar = $_last == 1 ? '' : ','}
{var $isPast = 'getTripStatus' | snippet}
{var $availability = "https://schema.org/InStock"}

{if $isPast}
    {set $availability = "https://schema.org/SoldOut"}
{/if}

{
    "@type": "Offer",
    "name": "{$category}",
    "price": "{$discountPrice}",
    "priceCurrency": "RUB",
    "availability": "{$availability}"
}{$lastChar}