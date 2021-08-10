<input type="hidden" id="length" value="${length}">
<#list docs as node>
    <tr>
		<td>${node.properties['cm:name']}</td>
		<#if node.properties["cm:owner"]?exists><td>${node.properties['cm:owner']}</td>
		<#else>
			<td>${node.properties['cm:creator']}</td>
        </#if>
        <td>${node.displayPath?replace("/Company Home/","")}</td>
        <td>${node.properties["cm:modified"]?date?replace("-"," ")}</td>
        <#if node.properties["rt:endRetentionDate"]?exists><td>${node.properties["rt:endRetentionDate"]?date?replace("-"," ")}</td>
		<#else>
			<td>Unknown</td>
		</#if>	
        <#if node.properties["rt:status"]?exists><td>${node.properties["rt:status"]}</td>
        <#else>
			<td>Unknown</td>
        </#if>
        <td>
			<a href='/share/page/document-details?nodeRef=${node.nodeRef}' target="_blank">${node.nodeRef}</a>
        </td>
    </tr>
</#list>
