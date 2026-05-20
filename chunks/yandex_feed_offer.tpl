{var $imageSrc = 'getImageList' | snippet : [
    'tvname' => 'imageGallery',
    'docid' => $id,
    'tpl' => 'image_value',
    'limit' => 1
]}

{var $offerPrice = $price ? $price : $tv_price}
{var $offerCategory = $categoryId ? $categoryId : 10}

<offer id="{$id}">
	<url>{$id | url}</url>
	<price>{$offerPrice}</price>
	<currencyId>RUR</currencyId>
	<categoryId>{$offerCategory}</categoryId>
	<picture>https://riversales.ru/{$imageSrc}</picture>
	<delivery>false</delivery>
	<model>[[+id]]</model>
	<name>[[+pagetitle]]</name>
	<description>{$id | resource : 'description'}</description>
</offer>