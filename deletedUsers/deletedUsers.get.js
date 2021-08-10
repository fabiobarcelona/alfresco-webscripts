var pageSize = 1000; // no more than 1000!!!
var currentPage = 0;
var currentPageSize = -1;
var nodes = null;
var fromNode = 0;
var users = [];

do
{
	var q = 'TYPE:\"cm\\:person\" AND (cm:email\:\"\") AND (\-cm:userName:\"*1*\") AND (\-cm:userName:\"*2*\") AND (\-cm:userName:\"*3*\") AND (\-cm:userName:\"*4*\") AND (\-cm:userName:\"*5*\") AND (\-cm:userName:\"*6*\") AND (\-cm:userName:\"*7*\") AND (\-cm:userName:\"*8*\") AND (\-cm:userName:\"*9*\") AND (\-cm:userName:\"*0*\") AND @sys\\:node\\-dbid:['+fromNode+' TO MAX]';
	
	var sort1 = { column: '@sys:node-dbid', ascending: true };
	var paging = { maxItems: pageSize, skipCount: 0 };
	var def = { query: q, store: 'workspace://SpacesStore', language: 'fts-alfresco', sort: [sort1], page: paging };

	nodes = search.query(def);

	for each (node in nodes)
	{
		fromNode = node.properties["sys:node-dbid"] + 1;
		if(node.properties["cm:email"] == null || node.properties["cm:email"].length == 0)
		{
			users.push(node);
		}	
	}
	
} while ( nodes != null && nodes.length > 0 );


var length = users.length;

model.users = users;
model.length = length;




/*var nodes;
var users = [];

var s = {};

s.page = {};
s.query         = "SELECT cm:userName FROM cm:person WHERE (cm:email IS NULL) AND (cm:userName NOT LIKE '%\\_%') AND (cm:userName NOT LIKE '%$%') AND (cm:userName NOT LIKE '%.%') AND (cm:userName NOT LIKE '%0%') AND (cm:userName NOT LIKE '%1%') AND (cm:userName NOT LIKE '%2%') AND (cm:userName NOT LIKE '%3%') AND (cm:userName NOT LIKE '%4%') AND (cm:userName NOT LIKE '%5%') AND (cm:userName NOT LIKE '%6%') AND (cm:userName NOT LIKE '%7%') AND (cm:userName NOT LIKE '%8%') AND (cm:userName NOT LIKE '%9%')";
s.language      = 'cmis-alfresco';
s.page.maxItems = 100;

var nodes = search.query(s);

	for each (node in nodes)
	{
		users.push(node);
	}
	
var length = users.length;

model.users = users;
model.length = length;*/
