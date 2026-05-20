{var $title = $id == 10 ? 'Главная' : $menutitle}
{var $position = $idx + 1}

{if !in_array($id, [276])}
    <li class="breadcrumb-item not-active">
        <a href="[[+link]]">
            <span>{$title}</span>
        </a>
        <img src="/assets/img/icons/right-arrow-small.svg" alt="">
    </li>
{/if}