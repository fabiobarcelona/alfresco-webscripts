<html lang="en">
<head>
    <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${user} Retention Report</title>

	<link rel="icon" href="http://sharedox.prod.oami.eu/share/res/favicon.ico" type="image/ico" />
	
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.css">
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.6.5/css/buttons.dataTables.min.css"/>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
	<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.5/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/fixedheader/3.1.7/js/dataTables.fixedHeader.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.6.5/js/buttons.html5.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.4/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.datatables.net/plug-ins/1.10.25/sorting/datetime-moment.js"></script>
	

</head>

<nav class="navbar navbar-light bg-light mb-4">
	<span class="navbar-brand" href="#">
		<img class="ms-2" src="/share/res/components/images/header/sharedox_logo.png" alt="ShareDox Logo">
		<span class="border-end pe-3 ps-2 h5">${user} Retention Report</span>
		<span class="ps-3 h5">Documents found: ${length}</span>
	</span>
</nav>
	
	
<div class="container-fluid">
	<table class="display" style="width:100%" id="datatable">
		<thead>
			<tr>
				<th scope="col">Resource Name</th>
				<th scope="col">Path</th>
				<th scope="col">Last Modified</th>
				<th scope="col">End retention date</th>
				<th scope="col">Status</th>
				<th scope="col">Link to resource</th>
			</tr>
		</thead>
		<tbody>
			<#list docs as node>
				<tr>
					<td>${node.properties['cm:name']}</td>
					<td>${node.displayPath?replace("/Company Home/","")}</td>
					<td>${node.properties["cm:modified"]?date?replace("-"," ")}</td>
					<#if node.properties["rt:endRetentionDate"]?exists>
						<td>${node.properties["rt:endRetentionDate"]?date?replace("-"," ")}</td>
					<#else>
						<td>Unknown</td>
					</#if>	
					<#if node.properties["rt:status"]?exists>
						<td>${node.properties["rt:status"]}</td>
					<#else>
					  <td>Unknown</td>
					</#if>
					<td>
						<a href='/share/page/document-details?nodeRef=${node.nodeRef}' target="_blank">${node.nodeRef}</a>
					</td>
				</tr>
			</#list>
		</tbody>
	</table>
</div>  
<script type="text/javascript">
$(document).ready(function()
{
	$('#datatable thead tr').clone(true).appendTo( '#datatable thead' );
	$('#datatable thead tr:eq(1) th').each( function (i)
	{
		var title = $(this).text();
		$(this).html( '<input type="text" placeholder="Search '+title+'" />' );
        $( 'input', this ).on( 'keyup change', function ()
		{
			if ( table.column(i).search() !== this.value )
			{
				table.column(i).search(this.value).draw();
            }
        });
    });
	  
	$.fn.dataTable.moment( 'DD MMM YYYY' );

    var table = $('#datatable').DataTable(
	{
		dom: "<'row ps-4 pe-4'<'col-sm-4'B><'col-sm-4'l><'col-sm-4'f>>rtip",
		buttons:
		[{
			extend: 'csv',
			text: 'Export to CSV',
            filename: 'retention'
        }],
        orderCellsTop: true,
        fixedHeader: true,

    });
});
</script>

</html>
