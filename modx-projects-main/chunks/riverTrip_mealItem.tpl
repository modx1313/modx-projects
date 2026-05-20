<div class="meal-item">
    <div class="type">[[+mealType]]:</div>
    <div class="details">
            [[getChunkCollection?
            	&tpl=`@INLINE <div>{{+value}}</div>`
            	&valuesSemicolonSeparated=`[[+mealDetails]]`
            	&placeholder=`value`
            ]]
    </div>
</div>