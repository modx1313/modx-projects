{var $data = '!yandexFeed.prepareData' | snippet}
{var $categoriesParent = $_modx->resource.id == 751 ? 168 : 8}

<?xml version="1.0" encoding="UTF-8"?>
<yml_catalog date="{$time | date_format:"%Y-%m-%d %H:%M"}" >
	<shop>
		<name>[[++site_name]]</name>
		<company>ИП Яворский Павел Игоревич</company>
		<url>[[++site_url]]</url>
		<currencies>
			<currency id="RUR" rate="1"/>
		</currencies>
		<categories>
            {'pdoResources' | snippet : [ 
                'parents' => $categoriesParent,
                'depth' => 1,
                'limit' => 0, 
                'tpl' => 'yandex_feed_category',
            ]}
        </categories>
		<offers>
            {foreach $data['categories'] as $category}
                {'getChunkCollection' | snippet : [
                    'tpl' => 'yandex_feed_offer',
                    'valuesJson' => $category
                ]}
            {/foreach}
		</offers>
	</shop>
</yml_catalog>