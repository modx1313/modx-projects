{var $menutitle = 'menutitle' | resource}
{var $pagetitle = 'pagetitle' | resource}
{var $cityData = 'getCityRelatedData' | snippet}

{var $title = $menutitle ?: $pagetitle}

<nav class="breadcrumbs-section base-width">
    <li class="breadcrumb-item not-active">
        <a href="{$cityData['tripsId'] | url}">
            <span>{ucfirst($cityData['typeName'])} {$cityData['cityName']}</span>
        </a>
        <img src="/assets/img/icons/right-arrow-small.svg" alt="">
    </li>
    <li class="breadcrumb-item active">
        <div>
            <span>{$title}</span>
        </div>
    </li>
</nav>

<script type="application/ld+json">
{
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
        {
            "@type": "ListItem",
            "position": 1,
            "name": "{ucfirst($cityData['typeName'])} {$cityData['cityName']}",
            "item": "{$cityData['tripsId'] | url}"
        },
        {
            "@type": "ListItem",
            "position": 2,
            "name": "{$title}",
            "item": "{$_modx->resource.id | url}"
        }
    ]
}
</script>