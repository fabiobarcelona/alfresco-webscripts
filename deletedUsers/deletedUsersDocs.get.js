var pageSize = 1000; // no more than 1000!!!
var nodes = null;
var fromNode = 0;
var docs = [];
var user=args.user?args.user:person.properties.userName;

do
{
	var q = 'TYPE:\"cm:content\" AND ((+cm:creator:'+user+') OR (cm:owner:'+user+')) AND +cm:lockOwner:System AND @sys\\:node\\-dbid:['+fromNode+' TO MAX]';
	
	var sort1 = { column: '@sys:node-dbid', ascending: true };
	var paging = { maxItems: pageSize, skipCount: 0 };
	var def = { query: q, store: 'workspace://SpacesStore', language: 'fts-alfresco', sort: [sort1], page: paging };

	nodes = search.query(def);

	for each (node in nodes)
	{
		fromNode = node.properties["sys:node-dbid"] + 1;
		docs.push(node);
	}
	
} while ( nodes != null && nodes.length > 0 );


var length = docs.length;

model.docs = docs;
model.length = length;


/*var s = {};
var user=args.user?args.user:person.properties.userName

s.page = {};
s.query         = '(+cm:owner:'+user+ ' OR (+cm:creator:'+user+ ' AND (+cm:owner IS NULL))) AND +rt:endRetentionDate:[MIN TO MAX] AND +cm:lockOwner:System';
s.language      = 'fts-alfresco';
s.page.maxItems = 2000;

var nodes = search.query(s);

var length = nodes.length;

model.nodes = nodes;
model.length = length;*/