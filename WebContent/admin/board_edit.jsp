<%@page import="util.PagingUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
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

<title>SB Admin - Blank Page</title>
<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<!-- Page level plugin CSS-->
<link href="vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">
<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">

<%
request.setCharacterEncoding("UTF-8");

BbsDAO dao = new BbsDAO(application);
String flag = request.getParameter("flag");
int num = Integer.parseInt(request.getParameter("num"));
BbsDTO dto = dao.selectView(flag, num);

String menu = "";
switch (flag) {
case "01":case "02":case "03":case "04":case "05":
	menu = "space";break;
case "06":case "07":
	menu = "community";break;
}
String queryStr = "menu=" + menu + "&flag=" + flag;

dao.close();
%>
</head>

<%@include file="./top01.jsp"%>
<!-- 왼쪽메뉴 -->
<jsp:include page="left01.jsp" />

<!-- 상단 -->
<div id="content-wrapper">
	<div class="container-fluid">
		<!-- Breadcrumbs-->
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">게시판 관리</a></li>
			<li class="breadcrumb-item active">김다혜</li>
		</ol>


<form enctype="multipart/form-data" method="post" name="writeFrm" action="./board_edit_proc.jsp">
	<table class="table table-bordered">
	<colgroup>
		<col width="20%"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">작성자</th>
			<td><%=dto.getName() %>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">제목</th>
			<td>
				<input type="text" class="form-control" name="title"
				value="<%=dto.getTitle()%>"/>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">내용</th>
			<td>
				<textarea rows="10" class="form-control" name="content"
				><%=dto.getContent() %></textarea>
			</td>
		</tr>
		<tr>
			<input type="hidden" name="originalfile" value="<%=dto.getAttachedfile() %>" />
			<th class="text-center" 
				style="vertical-align:middle;">첨부파일</th>
			<td>
				 첨부파일명 : <%=dto.getAttachedfile() %>
				<input type="file" class="form-control" name="file" />
			</td>
		</tr>
		<input type="hidden" name="flag" value="<%=flag %>" />
		<input type="hidden" name="menu" value="<%=menu %>" />
		<input type="hidden" name="num" value="<%=num %>" />
	</tbody>
	</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	<button type="submit" class="btn btn-danger">전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='boardCtrl.jsp?<%=queryStr%>'">
		리스트보기</button>
</div>
</form> 

		<hr>
		<p>프로젝트2 관리자페이지 입니다</p>

		<!-- Page Content -->
		<h1></h1>
		<hr>
		<p>This is a great starting point for new custom pages.</p>

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
