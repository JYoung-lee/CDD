<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/cdd/resources/js/ bootstrap.bundle.min.js"></script>
<script src="/cdd/resources/js/bootstrap.bundle.js"></script>
<script src="/cdd/resources/js/bootstrap.js"></script>
<link rel="stylesheet" href="/cdd/resources/css/bootstrap.css">

<body>


	<!-- Button trigger modal -->
	<button id="hiyo" type="button" class="btn btn-primary"
		data-toggle="modal" data-target="#staticBackdrop">Launch
		static backdrop modal</button>

	

	<!-- Modal -->
	<div class="modal fade" id="staticBackdrop" data-backdrop="static"
		data-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content"></div>
		</div>
	</div>
	
	<script>
		$("#hiyo").click(function() {
			$(".modal-content").load("/cdd/feeds/feedWriteForm.cdd");
		})
	</script>




</body>
</html>

