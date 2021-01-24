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

<title>관리자페이지-게시물관리</title>
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

// BbsDTO dto = new BbsDTO();
BbsDAO dao = new BbsDAO();

Map<String, Object> param = new HashMap<String, Object>();

String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
String queryStr = "";

if (searchWord != null) {
	//Map에 파라미터 담기
	param.put("column", searchColumn);
	param.put("word", searchWord);
	//쿼리스트링 생성
	queryStr += "&searchClumn=" + searchColumn + "&searchWord=" + searchWord;
}

//전체 레코드 갯수
int totalRecordCount = dao.getTotalRecordCountSearch2(param);

//페이지 처리
int pageSize = 5;
int blockPage = 5;
// int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
// int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));
int totalPage = (int) Math.ceil((double) totalRecordCount / pageSize);

int nowPage = (request.getParameter("nowPage") == null || request.getParameter("nowPage").equals(""))
		? 1
		: Integer.parseInt(request.getParameter("nowPage"));

int start = (nowPage - 1) * pageSize;
int end = pageSize;

param.put("start", start);
param.put("end", end);

//페이지처리+회원이름검색 리스트불러오기
List<BbsDTO> bbs = dao.selectListAdmin(param);
//자원해제
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

		<input type="button" value="선택항목삭제" onclick="check_delete();"/><br />
		<script>
		var f = document.boardForm;
		//게시판 삭제컨트롤 스크립트
		var flag = document.getElementsByName("flag");
		var num = document.getElementsByName("num");
		var style = document.getElementsByName("style");
		
			//선택항목삭제
			var cbox = document.getElementsByName("checkbox");
			
			function check_delete() {
			
				for(var i = 0 ; i<cbox.length ; i++){
						var c = confirm('삭제하시겠습니까?');
						if (c) {
							if(cbox[i].checked==true){
	// 							location.href="delete_proc.jsp?style="+style[0].value+"&flag="+flag[0].value+"&num="+num[0].value;
								f.method = "post";
								//JS도 연결시 + 사용하기
								f.action = "delete_proc.jsp";
								f.submit();
							}
						}
					}
				}
// 			$('#checkbox option:checked').attr('action', 'delete_proc.jsp?style="+style[0].value+"&flag="+flag[0].value+"&num="+num[0].value')
		</script>

		<!-- Page Content -->
		<br />

		<table class="table table-bordered" id="dataTable"
			style="font-size: 0.5em; text-align: center; vertical-align: middle;">
			<thead>
				<colspan>
				<col width="5%" />
				<col width="10%" />
				<col width="20%" />
				<col width="10%" />
				<col width="10%" />
				<col width="7%" />
				<col width="7%" />
				<col width="5%" />
				<col width="5%" />
				</colspan>
				<tr>
					<th>번호</th>
					<th>게시판</th>
					<th>제목</th>
					<th>작성자</th>
					<th>날짜</th>
					<th>조회수</th>
					<th>첨부파일</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<!-- 게시물이 없을때 -->
				<%
				if (bbs.isEmpty()) {
				%>
				<tr>
					<td colspan="6" align="center" height="100">등록된 게시물이 없습니다.</td>
				</tr>
				<%
				}
				//게시물이 있을때
				else {
				int vNum = 1;
				int countNum = 0;

				for (BbsDTO dto : bbs) {
					vNum = totalRecordCount - (((nowPage - 1) * pageSize) + countNum++);
				%>
			<form name="boardForm" action="delete_proc.jsp?style=board&flag=<%=dto.getFlag()%>&num=<%=dto.getNum()%>">
				<tr>
					<td><input type="checkbox" name="checkbox" id="" /> <%=vNum%></td>
					<td><%=dto.getFlag()%></td>
					<td class="text-left"><a
						href="board_view.jsp?flag=<%=dto.getFlag()%>&num=<%=dto.getNum()%>">
							<%=dto.getTitle()%></a></td>
					<!-- 제목 -->
					<td><%=dto.getName()%></td>
					<td><%=dto.getPostdate()%></td>
					<td><%=dto.getVisitcount()%></td>
					<td class="text-center"><%=(dto.getAttachedfile() != null) ? dto.getAttachedfile() : ""%></td>
					<!-- 첨부 -->
					<td><button>
							<a href="board_edit.jsp?flag=<%=dto.getFlag()%>&num=<%=dto.getNum()%>">수정</a>
						</button></td>
					<td><button onclick="one_delete()">삭제</button></td>
					<!-- 히든폼으로 페이지 종류 구분 -->
					
					<%
					String menu = "";
					switch (dto.getFlag()) {
					case "01":case "02":case "03":case "04":case "05":
						menu = "space";break;
					case "06":case "07":
						menu = "community";break;
					}
					%>
					<input type="hidden" name="style" value="board" />
					<input type="hidden" name="num" value="<%=dto.getNum()%>" />
					<input type="hidden" name="flag" value="<%=dto.getFlag()%>" />
					<input type="hidden" name="menu" value="<%=menu %>" />
					
					<script>
						function one_delete() {
							var c = confirm('삭제하시겠습니까?');
							if (c) {
								f.method = "post";
								//JS도 연결시 + 사용하기
// 								f.action = "delete_proc.jsp?style="+style[0].value+"&flag="+flag[0].value+"&num="+num[0].value;
								f.submit();
							}
						}
					</script>
				</form>
				</tr>
				<%
				}
				}
				%>
			</tbody>
		</table>
		
	<!-- 페이지번호 : 오류시 sout로 결과값 확인해보기-->
        <div class="row text-center">
		<%=PagingUtil.pagingBS4(totalRecordCount,
		pageSize, 
		blockPage, 
		nowPage,
		"../admin/boardCtrl.jsp?"+queryStr) %>
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
		<!-- Page Content -->
		<h1></h1>
		<hr>
		<p>laveberry company</p>
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
