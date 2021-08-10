<html lang="en">
<head>
    <meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Deleted Users Retention</title>

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
	
	<style>
	.jumping-dots span {
	  position: relative;
	  bottom: 0px;
	  -webkit-animation: jump 2s infinite;
	  animation: jump 2s infinite;
	}
	
	.jumping-dots .dot-1{
	  animation-delay: 200ms;
	}
	.jumping-dots .dot-2{
	  animation-delay: 400ms;
	}
	.jumping-dots .dot-3{
	  animation-delay: 600ms;
	}
	
	@-webkit-keyframes jump {
	  0%   {bottom: 0px;}
	  20%  {bottom: 5px;}
	  40%  {bottom: 0px;}
	}
	
	@-moz-keyframes jump {
	  0%   {bottom: 0px;}
	  20%  {bottom: 5px;}
	  40%  {bottom: 0px;}
	}
	
	@-o-keyframes jump {
	  0%   {bottom: 0px;}
	  20%  {bottom: 5px;}
	  40%  {bottom: 0px;}
	}
	
	@keyframes jump {
	  0%   {bottom: 0px;}
	  20%  {bottom: 5px;}
	  40%  {bottom: 0px;}
	}
	
	.progress-bar {
    -webkit-transition: none !important;
    transition: none !important;
	}

	</style>
</head>
<script type="text/javascript">
	var userArray = [];
	var username;
	var docLength;
	var totalDocLength = 0;

	let i = 1;
	
	//Build DOM Tree structure from HTML strings and get the no. of docs for one user
	function AJAXParser(html)
	{
		var parser = new DOMParser();
		var responseDoc = parser.parseFromString(html, 'text/html');
		
		var length = responseDoc.getElementById('length').value;
		return length.replace(/,/g, '');
	}
	
	//Progress bar and loading screen related
	function doProgress(i)
	{
		let currentProgress = (i/userArray.length)*100;
		progBar.style.width = currentProgress+'%';
		$('#progBar').attr('aria-valuenow',currentProgress);
		$('#progBar').html(Math.round(currentProgress)+'%');
		if(currentProgress == 100)
		{
			$('#progText').html('DONE!');
		}
	}
	
	//Count total Docs found while loading
	function countDocs(html, user)
	{	
		docLength = AJAXParser(html);
		totalDocLength += +docLength;
		console.log("Found "+docLength+" Docs for "+user+"; totalDocLength -> "+totalDocLength);
		$('#loadingDocuCount').html('Documents found: '+totalDocLength);
	}
	
	//async calls for each user to fetch their docs
	async function main()
	{
		
		for (const user of userArray)
		{
			const data = await fetch('url'+user)
			.then(function (response)
			{
				// The API call was successful
				return response.text();
			}).then(function (html)
			{
				// HTML String
				//console.log(html);
				countDocs(html, user);
				document.getElementById('tbody').insertAdjacentHTML('beforeend',html);
				
			}).catch(function (err)
			{
				// There was an error
				console.warn('Something went wrong.', err);
			});
			
			doProgress(i);
			i++;
		}
		
		//Update total docs on the navbar
		$('#totalDocs').html('Documents found: '+totalDocLength);
		
		//Parse dates as Date() Object
		$.fn.dataTable.moment( 'DD MMM YYYY' );
		
		//Build DataTable
		$(document).ready(function()
		{
			$('#datatable thead tr').clone(true).appendTo( '#datatable thead' );
			$('#datatable thead tr:eq(1) th').each(function(i)
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

			var table = $('#datatable').DataTable
			({
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
		
		//Fade out the loading screen once everything is done
		setTimeout(function() {
			$("#cover").fadeOut(1000);
		}, 1000);
		
	}
	
</script>

<!-- Fill array with each user found -->
<#list users as node>
	<script type="text/javascript">
		username = "${node.properties['cm:userName']}";
		userArray.push(username);
	</script>
</#list>


<!-- Page Loader/Cover -->


<div id="cover" style="position: fixed; height: 100%; width: 100%; top:0; left: 0; background: #FFF; z-index:9999;">
	<div class="container">
		<div class="h-100 row justify-content-center align-items-center">
			<div class="col-8">
				<p class="h3 text-center" id="progText">Fetching documents for each user<span class="jumping-dots">
					<span class="dot-1">.</span>
					<span class="dot-2">.</span>
					<span class="dot-3">.</span>
					</span>
					<br/>
				</p>
				<div class="progress">
					<div class="progress-bar progress-bar-striped progress-bar-animated" id="progBar" title="Progress Bar" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
				</div>
				
				<hr>
				
				<div class="row">
					<div class="col">
						<span class="h2">Users found: ${length}</span>
					</div>
					<div class="col d-flex justify-content-end">
						<span class="h2" id="loadingDocuCount">Documents found: 0</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- Top Bar -->


<nav class="navbar navbar-light bg-light mb-4">
	<span class="navbar-brand">
		<img class="ms-2" src="/share/res/components/images/header/sharedox_logo.png" alt="ShareDox Logo">
		<span>Deleted Users Retention</span>
	</span>
	<div class="col d-flex justify-content-end">
		<span class="border-end pe-5 h5">Users found: ${length}</span>
		<span class="pe-5 ps-5 h5" id="totalDocs"></span>
	</div>
</nav>


<!-- Table -->


<div class="container-fluid">
	<table class="display" style="width:100%" id="datatable">
		<thead>
			<tr>
				<th scope="col">Resource Name</th>
				<th scope="col">Owner</th>
				<th scope="col">Path</th>
				<th scope="col">Last Modified</th>
				<th scope="col">End retention date</th>
				<th scope="col">Status</th>
				<th scope="col">Link to resource</th> 
			</tr>
		</thead>
		<tbody id="tbody">
			
		</tbody>
	</table>
</div>	
<script type="text/javascript">main();</script>
</html>
