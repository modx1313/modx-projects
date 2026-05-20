<nav class="breadcrumbs-section base-width">
    {'pdoCrumbs' | snippet : [
        'showHome' => 1,
        'showAtHome' => 0,
        'hideSingle' => 1,
        'tpl' => 'breadcrumb',
        'tplHome' => 'homeTripsBreadcrumb',
        'tplCurrent' => 'breadcrumb_current'
    ]}
</nav>

{'!pdoCrumbs' | snippet : [
    'showHome' => 1,
    'exclude' => 276,
    'tplWrapper' => '@INLINE
    <script type="application/ld+json">
        {
            "@context": "http://schema.org",
            "@type": "BreadcrumbList",
            "itemListElement": [ {$output} ]
        }
    </script>
    ',
    'tplHome' => '@INLINE
        {
            "@type": "ListItem",
            "position": {$idx},
            "item": {
                "@id": "{$link}",
                "name": "{$menutitle}"
            }
        },
    ',
    'tplCurrent' => '@INLINE
        {
            "@type": "ListItem",
            "position": {$idx},
            "item": {
                "@id": "{$link}",
                "name": "{$menutitle}"
            }
        }
    ',
    'tpl' => '@INLINE
        {
            "@type": "ListItem",
            "position": {$idx},
            "item": {
                "@id": "{$link}",
                "name": "{$menutitle}"
            }
        },
    ',
]}