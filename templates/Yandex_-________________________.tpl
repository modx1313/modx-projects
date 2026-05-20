<?xml version="1.0" encoding="UTF-8"?>
{var $time = time()}
<yml_catalog date="{$time | date_format:"%Y-%m-%d %H:%M"}" >
	<shop>
		<name>[[++site_name]]</name>
		<company>ИП Яворский Павел Игоревич</company>
		<url>[[++site_url]]</url>
		<currencies>
			<currency id="RUR" rate="1"/>
		</currencies>
		<categories>
    		<category id="10">Речные прогулки по Москве-реке</category>
		</categories>
		<offers>
            {'pdoResources' | snippet : [ 
                'parents' => 10,
                'depth' => 1,
                'limit' => 0, 
                'tpl' => 'yandex_feed_offer',
                'includeTVs' => 'price',
                'tvPrefix' => 'tv_',
            ]}
		</offers>
	</shop>
</yml_catalog>