var parentRef = args["ParentRef"];
var childRef = args["ChildRef"];
var mode = Number(args["mode"]);

var msg = "";

if((parentRef != null && childRef != null) && (parentRef != "" && childRef != "") && (parentRef != undefined && childRef != undefined))
{
	if(mode == 0)
	{
		parentRef = parentRef.replace("workspace://SpacesStore/", "");
		childRef = childRef.replace("workspace://SpacesStore/", "");
	
		var parentNode = search.findNode("node", ["workspace", "SpacesStore", parentRef]);
		var child = search.findNode("node", ["workspace", "SpacesStore", childRef]);

		parentNode.addNode(child);
		msg = "New parent set successfully";
	}
	else if (mode == 1)
	{
	
		var parentNode = search.findNode("node", ["workspace", "SpacesStore", parentRef.replace("workspace://SpacesStore/", "")]);
		var child = search.findNode("node", ["workspace", "SpacesStore", childRef.replace("workspace://SpacesStore/", "")]);
		var primaryParent = child.getParent();
		
		if(primaryParent.getNodeRef() == parentRef)
		{
			msg = "Can't remove association: Child parent is primary";
		}
		else
		{	
			parentNode.removeNode(child);
			msg = "Child Association removed successfully";
		}	
	}
	
}

model.msg = msg;
