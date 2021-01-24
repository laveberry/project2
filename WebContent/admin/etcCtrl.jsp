<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>기타</title>
<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<!-- Page level plugin CSS-->
<link href="vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">
</head>

<%@include file="./top01.jsp"%>
<!-- 왼쪽메뉴 -->
<jsp:include page="left01.jsp" />

<style>
body{
	font-size: 1em;
}
</style>

<div id="content-wrapper">

	<div class="container-fluid">

		<!-- Breadcrumbs-->
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">블루클리닝 견적</a></li>
			<li class="breadcrumb-item active">김다혜</li>
		</ol>

		<!-- Page Content -->
		<!--         <h1>준비중입니다.</h1> -->
		<!--         <hr> -->
		<!--         <p> -->
		<div class="container">
			<table cellpadding="0" cellspacing="0" border="0" class="con_table"
				style="width: 100%;">
				<colgroup>
					<col width="25%" />
					<col width="*" />
				</colgroup>
				<tbody>
					<tr>
						<th>고객명/회사명</th>
						<td style="text-align: left;"><input type="text" name=""
							value="" class="join_input" /></td>
					</tr>
					<tr>
						<th>청소할 곳 주소</th>
						<td style="text-align: left;"><input type="text" name=""
							value="" class="join_input" style="width: 300px;" /></td>
					</tr>
					<tr>
						<th>연락처</th>
						<td style="text-align: left;"><input type="text" name=""
							value="" class="join_input" style="width: 50px;" /> - <input
							type="text" name="" value="" class="join_input"
							style="width: 50px;" /> - <input type="text" name="" value=""
							class="join_input" style="width: 50px;" /></td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td style="text-align: left;"><input type="text" name=""
							value="" class="join_input" style="width: 50px;" /> - <input
							type="text" name="" value="" class="join_input"
							style="width: 50px;" /> - <input type="text" name="" value=""
							class="join_input" style="width: 50px;" /></td>
					</tr>
					<tr>
						<th>이메일</th>
						<td style="text-align: left;"><input type="text" name=""
							value="" class="join_input" style="width: 100px;" /> @ <input
							type="text" name="" value="" class="join_input"
							style="width: 100px;" /></td>
					</tr>
					<tr>
						<th>청소의뢰내역</th>
						<td style="text-align: left;" style="padding:0px;">
							<table cellpadding="0" cellspacing="0" border="0"
								style="width: 100%;">
								<tr>
									<td>청소종류</td>
									<td style="border-right: 0px;"><input type="text" name=""
										value="" class="join_input" /></td>
								</tr>
								<tr>
									<td style="border-bottom: 0px;">분양평수/등기평수</td>
									<td style="border: 0px;"><input type="text" name=""
										value="" class="join_input" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<th>청소 희망날짜</th>
						<td style="text-align: left;"><input type="text" name=""
							value="" class="join_input" /></td>
					</tr>
					<tr>
						<th>접수종류 구분</th>
						<td style="text-align: left;"><input type="radio" name=""
							value="" /> 예약신청 &nbsp;&nbsp;&nbsp;<input type="radio" name=""
							value="" /> 견적문의</td>
					</tr>
					<tr>
						<th>기타특이사항</th>
						<td style="text-align: left;"><input type="text" name=""
							value="" class="join_input" style="width: 400px;" /></td>
					</tr>
				</tbody>
			</table>


			<!--         </p> -->
		</div>
	</div>
	<!-- /.container-fluid -->






	<!-- Sticky Footer -->
	<footer class="sticky-footer">
		<div class="container my-auto">
			<div class="copyright text-center my-auto">
				<span>Copyright © Your Website 2019</span>
			</div>
		</div>
	</footer>

</div>
<!-- /.content-wrapper -->

</div>
<!-- /#wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top"> <i
	class="fas fa-angle-up"></i>
</a>

<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
				<button class="close" type="button" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body">Select "Logout" below if you are ready
				to end your current session.</div>
			<div class="modal-footer">
				<button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
				<a class="btn btn-primary" href="login.html">Logout</a>
			</div>
		</div>
	</div>
</div>

<!-- Bootstrap core JavaScript-->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="js/sb-admin.min.js"></script>

</body>

</html>
