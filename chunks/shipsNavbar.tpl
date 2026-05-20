{var $menutitle = 'menutitle' | resource}
{var $pagetitle = 'pagetitle' | resource}
{var $parentId = 'parent' | resource}
{var $shipType = $parentId == 326 ? 'ship' : 'yacht'}
{var $shipParentId = $shipType == 'ship' ? 196 : 197}
{var $shipParentTitle = $shipType == 'ship' ? 'Аренда теплоходов' : 'Аренда яхт'}

{var $title = $menutitle ?: $pagetitle}

<nav class="breadcrumbs-section base-width">
    <li class="breadcrumb-item not-active">
        <a href="/">
            <span>Главная</span>
        </a>
        <img src="/assets/img/icons/right-arrow-small.svg" alt="">
    </li>
    <li class="breadcrumb-item not-active">
        <a href="{$shipParentId | url}">
            <span>{$shipParentTitle}</span>
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
            "name": "Главная",
            "item": "https://riversales.ru/"
        },
        {
            "@type": "ListItem",
            "position": 2,
            "name": "{$shipParentTitle}",
            "item": "{$shipParentId | url}"
        },
        {
            "@type": "ListItem",
            "position": 3,
            "name": "{$title}",
            "item": "{$_modx->resource.id | url}"
        }
    ]
}
</script>