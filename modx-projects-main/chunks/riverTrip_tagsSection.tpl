{var $tags = 'tv.trip.textTags' | resource}

{if $tags}
    <div class="tags-section base-width content-block-margin">
        [[pdoResources?
            &parents=`0`
            &limit=`0`
        	&tpl=`riverTrip.tagItem`
        	&resources=`[[*trip.textTags]]`
        ]]
    </div>
{/if}