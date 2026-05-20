{var $title = $id == 10 ? 'Главная' : $menutitle}

{if !in_array($id, [276])}
    <li class="breadcrumb-item active">
        <a href="[[+link]]">
            <span>{$title}</span>
        </a>
    </li>
{/if}