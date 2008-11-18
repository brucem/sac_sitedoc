<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{$site.http_equiv.Content-language|wash}" lang="{$site.http_equiv.Content-language|wash}">

    <head>
        <title>SiteDoc</title>

        <style type="text/css">
        {foreach ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ) as $css_file}
            @import url({concat( 'stylesheets/',$css_file )|ezdesign});
        {/foreach}
        </style>

    </head>
    <body id="sitedoc">

{def $indexpage = ezini( 'NodeSettings', 'RootNode', 'content.ini' ) 
     $indexnode = fetch( 'content', 'node', hash( 'node_id', $indexpage ) ) 
}
<h1>SiteDoc</h1>

<h2>SiteMap</h2>
<ul class="sitemap">
    <li class="{$indexnode.class_identifier|wash}"><span>{$indexnode.name|wash}</span> <a href="#class_{$indexnode.class_identifier|wash}">[{$indexnode.class_name|wash}]</a>
    {if $indexnode.children_count|gt(0)}{include uri="design:sitedoc/childnodes.tpl" top=$indexnode}{/if}
    </li>
</ul>

<h2>Classes</h2>
{def $class_list = fetch('class', 'list', hash())}
{foreach $class_list as $class}
  <h3>{$class.name|wash}</h3>
  <dl>
        <dt>Object Count</dt>
        <dd>{$class.object_count|wash}</dd>
        <dt>Container</dt>
        <dd>{$class.is_container|choose('No', 'Yes')}</dd>
        <dt>Object Name Pattern</dt>
        <dd>{$class.contentobject_name|wash}</dd>
   </dl>

        <table class="AttributeList">
        <thead>
            <tr>
                <th>Name</th>
                <th>Identifer</th>
                <th>DataType</th>
                <th>Required</th>
                <th>Searchable</th>
                <th>Info Collector</th>
                <th>Translatable</th>
                {* <th>Attributes</th> *}
            </tr>
            </thead>
            <tbody>
            {foreach $class.data_map as $attribute}
                <tr{if $attribute.is_required} class="required" {/if}>
                    <th>{$attribute.name|wash}</th>
                    <td>{$attribute.identifier|wash}</td>
                    <td>{$attribute.data_type_string|wash}</td>
                    <td>{$attribute.is_required|choose('No', 'Yes')}</td>
                    <td>{$attribute.is_searchable|choose('No', 'Yes')}</td>
                    <td>{$attribute.is_information_collector|choose('No', 'Yes')}</td>
                    <td>{$attribute.can_translate|choose('No', 'Yes')}</td>
                    {* <td>{class_attribute_view_gui class_attribute=$attribute}</td> *}
                </tr>
            {/foreach}
            </tbody>
        </table>
{/foreach}

{foreach ezini( 'JavaScriptSettings', 'JavaScriptList', 'design.ini' ) as $js_file}
<script language="JavaScript" type="text/javascript" src={concat( 'javascript/',$js_file )|ezdesign}></script>
{/foreach}
{literal}
<script type="text/javascript">
  $(document).ready(function(){
      $("ul.sitemap").treeview({
           collapsed: true,
           persist: "cookie"
       });
  });
</script>
{/literal}
</body>
</html>
