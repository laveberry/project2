<%@page import="util.PagingUtil"%>
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

<%
//DB연결
MemberDAO dao = new MemberDAO(application);
//정보저장을 위한 Map생성
Map<String, Object> param = new HashMap<String, Object>();
int PAGE_SIZE = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
int BLOCK_PAGE = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));
//검색어가 있을경우
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
String queryStr = "";
//Map에 파라미터 담기
if (searchWord != null) {
	param.put("column", searchColumn);
	param.put("word", searchWord);
	//쿼리스트링 생성
	queryStr += "searchClumn=" + searchColumn + "&searchWord=" + searchWord;
}
// 전체 회원 수 카운트
int totalRecordCount = dao.getTotalPeopleCount(param);
System.out.println("관리자-카운트된회원수" + totalRecordCount);

//페이지 처리
int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));
int totalPage = (int) Math.ceil((double) totalRecordCount / pageSize);
//현재페이지 처리
int nowPage = (request.getParameter("nowPage") == null || request.getParameter("nowPage").equals(""))
		? 1
		: Integer.parseInt(request.getParameter("nowPage"));

int start = (nowPage - 1) * pageSize;
int end = pageSize;

param.put("start", start);
param.put("end", end);
//회원 리스트 불러오기+검색
List<MemberDTO> bbs = dao.adminPeople(param);

int vNum = 0;
int countNum = 0;
//자원해제
dao.close();
%>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>관리자 리스트</title>
<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- Page level plugin CSS-->
<link href="vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">

<style>
table {text-align: center;font-size: 0.5em;}
input {font-size: 0.5em;}
</style>
</head>

<%@include file="./top01.jsp"%>
<jsp:include page="left01.jsp" />


<div id="content-wrapper">
	<div class="container-fluid">

		<!-- Breadcrumbs-->
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="main_admin.jsp">관리자 리스트</a>
			</li>
			<li class="breadcrumb-item active">김다혜</li>
		</ol>
		<input type="button" value="선택회원삭제" /><br />
		<br />

		<script>
			//선택회원삭제 스크립트
		</script>
		<!-- Page Content -->
		<table class="table table-bordered" id="dataTable" cellspacing="0">
			<thead>
				<colspan>
					<col width="5%" />
					<col width="10%" />
					<col width="10%" />
					<col width="15%" />
					<col width="15%" />
					<col width="15%" />
					<col width="5%" />
					<col width="5%" />
					<col width="5%" />
				</colspan>
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>연락처</th>
					<th>주소</th>
					<th>Email</th>
					<th>등급</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (bbs.isEmpty()) {
				%>
				<tr>
					<td colspan="10" align="center" height="100">회원이 없습니다.</td>
				</tr>
				<%
				}
				//게시물이 있을때
				else {
				for (MemberDTO dto : bbs) {
					vNum = totalRecordCount - (((nowPage - 1) * pageSize) + countNum++);
					System.out.println("뷰 아이디="+dto.getId());
				%>
				<tr>
					<td><%=vNum%> <input type="checkbox" /> </td>
					<td><%=dto.getId()%></td>
					<td><%=dto.getName()%></td>
					<td><%=dto.getPhoneNum()%></td>
					<td><%=dto.getAddress()%></td>
					<td><%=dto.getEmail()%></td>
					<td><%=dto.getGrade()%></td>
					<td><button>
							<a href="editPeople.jsp?id=<%=dto.getId()%>">수정</a>
						</button></td>
					<form action="delete_proc.jsp" name="deletFrom">
						<input type="hidden" name="id" value="<%=dto.getId()%>" /> 
						<input type="hidden" name="style" value="people">
						<td>
							<button onclick="deleteFrom()" id="delete">삭제</button>
						</td>
					</form>
				</tr>
				<%
					}
				}
				%>
				<script>
					function deleteFrom() {
						//삭제 폼이름 받아오기
						var f = document.deletFrom;
						var c = confirm('삭제할까요?');
						if (c) {
							f.method = "post";
							f.action = "delete_proc.jsp";
							f.submit();
						}
					}
				</script>
			</tbody>
		</table>


		<!-- 페이지 번호 -->
		<div class="row text-center">
			<!-- 페이지번호 부분 -->
			<%=PagingUtil.pagingBS4(totalRecordCount, pageSize, blockPage, nowPage, "../admin/peopleCtrl.jsp?" + queryStr)%>
		</div>


		<!-- 검색 -->
		<form class="form-inline ml-auto">
			<div class="form-group">
				<select name="searchColumn" class="form-control">
					<option value="grade"
						<%=(request.getParameter("searchColumn") != null && request.getParameter("searchColumn").equals("grade"))
		? "selected"
		: ""%>>등급</option>
					<option value="id"
						<%=(request.getParameter("searchColumn") != null && request.getParameter("searchColumn").equals("id"))
		? "selected"
		: ""%>>아이디</option>
					<option value="name"
						<%=(request.getParameter("searchColumn") != null && request.getParameter("searchColumn").equals("name"))
		? "selected"
		: ""%>>이름</option>
				</select>
			</div>
			<div class="input-group">
				<input type="text" name="searchWord" class="form-control" />
				<div class="input-group-btn">
					<button type="submit" class="btn btn-default">
						<i class="glyphicon glyphicon-search"></i>
					</button>
				</div>
			</div>
		</form>



		<hr>
		<p>프로젝트2 관리자페이지 입니다</p>


	</div>
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
