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

        <style type="text/css">
        {literal}

            .ClassInfo {
                color: white;
                background: black;
            }
            th {
                text-align: left;
            }

            .AttributeList {
                width:100%;
            }
        {/literal}
        </style>
    </head>
    <body>

{def $indexpage = ezini( 'NodeSettings', 'RootNode', 'content.ini' ) 
     $indexnode = fetch( 'content', 'node', hash( 'node_id', $indexpage ) ) 
}
<h1>SiteDoc</h1>
<h2>SiteMap</h2>
<ul class="sitemap">
    <li><span>{$indexnode.name|wash}</span> <a href="#class_{$indexnode.class_identifier|wash}">[{$indexnode.class_name|wash}]</a>
    {if $indexnode.children_count|gt(0)}{include uri="design:sitedoc/childnodes.tpl" top=$indexnode}{/if}
    </li>
</ul>
<h2>Classes</h2>
{def $class_list = fetch('class', 'list', hash())}
<table border="1">
<tr>
    <th>Name</th>
    <th>Count</th>
    <th>Container</th>
</tr>
{foreach $class_list as $class}
<tr class="ClassInfo" id="class_{$class.identifier|wash}">
    <td>{$class.name|wash}</td>
    <td>{$class.object_count|wash}</td>
    <td>{$class.is_container|choose('No', 'Yes')}</td>
</tr>
<tr>
    <td colspan="10">
        <table class="AttributeList">
            <tr>
                <th>Name</th>
                <th>Identifer</th>
                <th>DataType</th>
            </tr>
            {foreach $class.data_map as $attribute}
                <tr>
                    <td>{$attribute.name|wash}</td>
                    <td>{$attribute.identifier|wash}</td>
                    <td>{$attribute.data_type_string|wash}</td>
                </tr>
            {/foreach}
        </table>
    </td>
</tr>
{/foreach}
</table>

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
