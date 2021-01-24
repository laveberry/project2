<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
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

<title>캘린더</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- Page level plugin CSS-->
<link href="vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">

<%
int year;
int month;
//오늘날짜 받아오기
Calendar today = Calendar.getInstance();
//내가원하는날짜 입력하기
Calendar cal = new GregorianCalendar();
//년도 셋팅하기
year = (request.getParameter("year") == null) ? today.get(Calendar.YEAR)
		: Integer.parseInt(request.getParameter("year"));
//달 셋팅하기
month = (request.getParameter("month") == null) ? today.get(Calendar.MONTH) + 1
		: Integer.parseInt(request.getParameter("month"));
//이전년도
if (month <= 0) {
	month = 12;
	year--;
//이후년도
} else if (month >= 13) {
	month = 1;
	year++;
}
//년도, 달, 일 셋팅하기
cal.set(Calendar.YEAR, year);
cal.set(Calendar.MONTH, (month - 1));
cal.set(Calendar.DATE, 1);
%>



</head>

<%@include file="./top01.jsp"%>
<!-- 왼쪽메뉴 -->
<jsp:include page="left01.jsp" />
<div id="content-wrapper">
	<div class="container-fluid">
		<!-- Breadcrumbs-->
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.html">달력</a></li>
			<li class="breadcrumb-item active">김다혜</li>
		</ol>
		<input type="button" value="선택항목삭제" /><br />
		<br />

		<!-- 달력테이블 시작 -->
		<table border="1" style="font-size: 2em; text-align: center;">
			<tr>
				<td align="center" height='18' valign='bottom' colspan="7">
				<!-- 이전달 -->
				<a href='timeCtrl.jsp?year=<%=cal.get(Calendar.YEAR)%>&month=<%=((cal.get(Calendar.MONTH) + 1) - 1)%>'>
				<font color='484848' size='2'>◀️ </font></a> <font color='484848' size='2'><%=cal.get(Calendar.YEAR)%>
						/ <%=(cal.get(Calendar.MONTH) + 1)%> </font>
				<!-- 다음달 --> 
				<a href='timeCtrl.jsp?year=<%=cal.get(Calendar.YEAR)%>&month=<%=((cal.get(Calendar.MONTH) + 1) + 1)%>'><font
						color='484848' size='2'>▶️ </font></a></td>
			</tr>
			<tr>
				<td>일</td>
				<td>월</td>
				<td>화</td>
				<td>수</td>
				<td>목</td>
				<td>금</td>
				<td>토</td>
			</tr>
			<%
				//년,월,일 셋팅	
				cal.set(year, month - 1, 1);
				//요일 설정
				int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
			%>
			<tr>
				<%
					//요일 출력
					for (int i = 1; i < dayOfWeek; i++) {
				%>
				<td></td>
				<%
					}
					//getActualMaximum : 해당월 마지막날짜
					//일자 출력하기
					//
					for (int i = 1; i <= cal.getActualMaximum(Calendar.DAY_OF_MONTH); i++) {
				%>
				<td>
				<!-- 해당일자 상세정보로 이동 -->
					<a href='day.jsp?year=<%=cal.get(Calendar.YEAR)%>&month=<%=((cal.get(Calendar.MONTH) + 1))%>&day=<%=i%>'><%=i%></a>
				</td>
				<%
				
					if ((dayOfWeek - 1 + i) % 7 == 0) {
				%>
			</tr>
			<tr>
				<%
					}
				}
				%>

			</tr>
		</table>

		<!-- 페이지 번호 -->
		<div class="row text-center">
			<!-- 페이지번호 부분 -->
			<ul class='pagination justify-content-center'>
				<%-- 		${map.pagingImg } --%>
			</ul>
		</div>


		<!-- 검색 -->
		<form class="form-inline ml-auto">
			<div class="form-group">
				<select name="searchColumn" class="form-control">
					<option value="title"
						<%=(request.getParameter("searchColumn") != null && request.getParameter("searchColumn").equals("title"))
		? "selected"
		: ""%>>제목</option>
					<option value="name"
						<%=(request.getParameter("searchColumn") != null && request.getParameter("searchColumn").equals("name"))
		? "selected"
		: ""%>>작성자</option>
					<option value="content"
						<%=(request.getParameter("searchColumn") != null && request.getParameter("searchColumn").equals("content"))
		? "selected"
		: ""%>>내용</option>
				</select>
			</div>
			<div class="input-group">
				<input type="text" name="keyString" class="form-control" />
				<div class="input-group-btn">
					<button type="submit" class="btn btn-default">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
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
