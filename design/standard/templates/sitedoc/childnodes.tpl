{def $node_list = fetch( 'content', 'list', hash( 'parent_node_id', $top.node_id,
                                                  'sort_by', $top.sort_array ))
    $namespace=concat('ns_', $top.node_id)
}
<ul>
{foreach $node_list as $item}
    <li><span>{$item.name|wash}</span> <a href="#class_{$item.class_identifier|wash}">[{$item.class_name|wash}]</a>
    {if $item.children_count}{include uri="design:sitedoc/childnodes.tpl" name=$namespace top=$item}{/if}
    </li>
{/foreach}
</ul>
{undef}

