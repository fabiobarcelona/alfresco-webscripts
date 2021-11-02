<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="Web Script interface to set a new parent folder to a child folder">
		<meta name="author" content="Fabio Barcelona García">
	
		<title>Second Parent Setter</title>
		
		<link rel="icon" href="http://sharedox.prod.oami.eu/share/res/favicon.ico" type="image/ico" />
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
	</head>

	<body>
	<script>
		function main(mode)
		{
			var parentRef = document.getElementById('ParentRef').value;
			var childRef = document.getElementById('ChildRef').value;
			
			window.location = 'http://test-sharedox.test.oami.eu/alfresco/wcs/secondParent?ParentRef='+parentRef+'&ChildRef='+childRef+'&mode='+mode
		}
		</script>
		<main>
			<div class="container text-center" style="margin-top:20vh">
				<div class="row">
					<div class="col-6">
						<h1 class="mt-5">Parent NodeRef</h1>
						<input type="text" id="ParentRef" class="inputTag mt-3" placeholder="workspace://SpacesStore/..." size="55">
					</div>

					<div class="col-6">
						<h1 class="mt-5">Child NodeRef</h1>
						<input type="text" id="ChildRef" class="inputTag mt-3" placeholder="workspace://SpacesStore/..." size="55">
					</div>
				</div>
				
				<button class="btn btn-success btn-lg" style="margin-top: 5rem !important;" onclick="main(0)" id="btnSubmit">Set second parent</button>
				<br/>
				<button class="btn btn-danger btn-lg mt-3" onclick="main(1)">Remove Child Association</button>
				
				<h3 class="mt-3" > ${msg} </h3>
			</div>
		</main>

		<footer class="footer fixed-bottom mt-auto py-3 bg-light">
			<div class="container text-center">
				<span class="text-muted">Made with &#10084; by Fabio Barcelona</span>
			</div>
		</footer>
	</body>
</html>
