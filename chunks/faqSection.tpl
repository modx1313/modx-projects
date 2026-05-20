{var $values = $resourceId | resource : $tvName | fromJSON}

<div class="bar-anchor-wrapper">
    <div class="anchor" id="faq-anchor"></div>
</div>

<div class="base-width content-block-margin faq-block">
    <h2 class="section-title">{$title}</h2>
    {foreach $values as $value}
        <div class="additional-section js-river-trip-additional-section">
            <div class="title-block js-river-trip-additional-section-toggle pointer noselect">
                <div class="subsection-title">{$value['question']}</div>
                <img src="/assets/img/icons/down-arrow-medium.svg" alt="раскрыть секцию" class="expand-button">
                <img src="/assets/img/icons/up-arrow-medium.svg" alt="свернуть секцию" class="collapse-button">
            </div>
            <div class="main-block js-can-hide js-hidden">
                <div class="answer">{$value['answer']}</div>
            </div>
        </div>
    {/foreach}
    <button class="base-button filled" data-hystmodal="#question-modal">Задать вопрос</button>
</div>