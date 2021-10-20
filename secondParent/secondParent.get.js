var parentRef = args["ParentRef"];
var childRef = args["ChildRef"];
var msg = "";

if(parentRef != null && childRef != null)
{
	msg = "New parent set successfully";
	
	parentRef = parentRef.replace("workspace://SpacesStore/", "");
	childRef = childRef.replace("workspace://SpacesStore/", "");
	
	var parentNode = search.findNode("node", ["workspace", "SpacesStore", parentRef]);
	var child = search.findNode("node", ["workspace", "SpacesStore", childRef]);

	parentNode.addNode(child);
}

model.msg = msg;
