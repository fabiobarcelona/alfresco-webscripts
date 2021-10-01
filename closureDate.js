function main()
{
	var folDesc = space.properties["cm:description"];
	var date = new Date();
	
	if(space.hasAspect('rt:closured'))
	{
		if(parseInt(folDesc) > 0)
		{
			//Modificar fechas de esta forma en Alfresco
			var year = date.getFullYear();
			var month = date.getMonth();
			var day = date.getDate();
			var newDate = new Date(year + parseInt(folDesc), month, day);
			
			space.properties["rt:closureDate"] = newDate;
			space.save();
		}
	}
}

main();
