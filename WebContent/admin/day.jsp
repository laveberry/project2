<%@page import="multi.BbsDTO"%>
<%@page import="multi.BbsDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="multi.MemberDTO"%>
<%@page import="multi.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>달력 상세보기[관리자]</title>

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
<jsp:include page="left01.jsp" />

<div id="content-wrapper">
	<div class="container-fluid">
		<!-- Breadcrumbs-->
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="main_admin.jsp">달력 상세보기</a>
			</li>
			<li class="breadcrumb-item active">김다혜</li>
		</ol>
	</div>
	
<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

Map map = new HashMap();
map.put("cal", year+month+day);

//DB연결
BbsDAO dao = new BbsDAO();
BbsDTO dto = new BbsDTO();
//기존 캘린더게시물 있는지 확인
dto = dao.calView(map);
%>
	<form action="time_edit.jsp" method="post">
		<table class="table table-bordered">
			<colgroup>
				<col width="20%" />
				<col width="30%" />
				<col width="20%" />
				<col width="*" />
			</colgroup>
			<tbody>
				<th class="text-center" style="vertical-align: middle;">날짜</th>
				<td colspan="3"><%=year%>. <%=month%>. <%=day%></td>
				</tr>
					<input type="hidden" name="cal" value=<%=year+month+day %> />
				<%
				if(dto.getContent()==null){%>
				<tr>
					<th class="text-center" style="vertical-align: middle;">일정</th>
					<td colspan="3"> <input type="text" name="content" value="일정이 없습니다" style="height:200px"/> </td>
				</tr>
				
				<%}else{%>
				<tr>
					<th class="text-center" style="vertical-align: middle;">일정</th>
					<td colspan="3">
						 <input type="text" name="content" value="<%=dto.getContent()%>" style="height:200px"/>
					</td>
				</tr>
				<%} %>
			</tbody>
		</table>
			<!-- 각종 버튼 -->
		<div class="row text-center" style="">
			<button type="submit" class="btn btn-danger">전송하기</button>
			<button type="reset" class="btn">Reset</button>
			<button type="button" class="btn btn-warning">
				<a href="timeCtrl.jsp">리스트보기</a>
			</button>
		</div>
	</form>


	<hr>
	<p>프로젝트2 관리자페이지 입니다</p>
	<!-- /.container-fluid -->
	<!-- Sticky Footer -->
	<footer class="sticky-footer">
		<div class="container my-auto">
			<div class="copyright text-center my-auto">
				<span>Copyright Â© Your Website 2019</span>
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
					<span aria-hidden="true">Ã</span>
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
