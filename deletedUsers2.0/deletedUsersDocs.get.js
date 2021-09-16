var pageSize = 1000; // no more than 1000!!!
var nodes = null;
var user = null;
var queryRes = null;
var fromNode = args.currentNode;
var docs = [];
var users = [];

function onlyUnique(value, index, self)
{
	return self.indexOf(value) === index;
}

function checkUser(user)
{
	var s = {};
	
	s.page = {};
	s.query = 'TYPE:"cm:person" AND cm:userName:'+user;
	s.language      = 'fts-alfresco';
	s.page.maxItems = 1;
	
	queryRes = search.query(s);
	
	for each (res in queryRes)
	{
		if(res.properties["cm:email"] == null || res.properties["cm:email"].length == 0 )
		{
			return false
		}
		else
		{
			return true;
		}
	}
}

var q = 'TYPE:"cm:content" AND +cm:lockOwner:System AND @sys\\:node\\-dbid:['+fromNode+' TO MAX]';

var sort1 = { column: '@sys:node-dbid', ascending: true };
var paging = { maxItems: pageSize, skipCount: 0 };
var def = { query: q, store: 'workspace://SpacesStore', language: 'fts-alfresco', sort: [sort1], page: paging };

nodes = search.query(def);	

for each (node in nodes)
{
	if(node.properties["sys:node-dbid"] == fromNode)
	{
		continue;
	}
	
	if (node.properties["cm:owner"] == null || node.properties["cm:owner"].length == 0)
	{
		user = node.properties["cm:creator"];
	}
	else
	{
		user = node.properties["cm:owner"];
	}
	
	if(!checkUser(user))
	{
		users.push(user);
		docs.push(node);
	}
}

var length = docs.length;
var lastIndex = nodes[nodes.length - 1].properties["sys:node-dbid"];
var uniqueUsers = users.filter(onlyUnique).toString();

model.uniqueUsers = uniqueUsers;
model.lastIndex = lastIndex;
model.docs = docs;
model.length = length;
