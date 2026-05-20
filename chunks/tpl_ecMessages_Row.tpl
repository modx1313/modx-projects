<div id="ec-{$thread_name}-message-{$id}" class="ec-message">
    <div class="ec-message__meta ec-clearfix">
        <span class="ec-message__author">{$user_name}</span>
        <span class="ec-message__date">{$date | dateAgo}</span>
        {if $voting_enable}
        {set $voting_button_classes = $voting_can_vote ? 'js-ec-vote-button enabled' : ''}
        <div class="ec-message__votes ec-clearfix" data-message-id="{$id}" data-properties-key="{$properties_key}">
            <div class="ec-message__votes-item">
                <a href="javascript:void(0)" class="{$voting_button_classes} ec-message__votes-button ec-message__votes-button-like {if $vote==1}active{/if}" data-value="1">
                    {$likes}
                </a>
            </div>
            <div class="ec-message__votes-item">
                <a href="javascript:void(0)" class="{$voting_button_classes} ec-message__votes-button ec-message__votes-button-dislike {if $vote==-1}active{/if}" data-value="-1">
                    {$dislikes}
                </a>
            </div>
            <div class="ec-message__votes-bar"><span class="js-ec-vote-bar" style="width: {$votes_rating_percent}%"></span></div>
        </div>
        {/if}
    </div>
    <div class="ec-stars">
        <span class="rating-{$rating}"></span>
    </div>
    <p>{$text}</p>
    {if $reply_text}
    <div class="ec-message__reply">
        {if $reply_author}
        <p><strong>{$reply_author}</strong></p>
        {/if}
        <p>{$reply_text}</p>
    </div>
    {/if}
    {if $files}
        <div class="ec-message__files">
            {foreach $files as $file}
                <div class="ec-message__files-item">
                    <a href="{$file['url']}" target="_blank">{$file['name_original']}</a>
                </div>
            {/foreach}
        </div>
    {/if}
</div>
