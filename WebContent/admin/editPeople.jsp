<%@page import="multi.MemberDAO"%>
<%@page import="multi.MemberDTO"%>
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
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>회원 상세정보 수정</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">

<%
MemberDTO dto = new MemberDTO();
MemberDAO dao = new MemberDAO();
//id값으로 회원정보 불러오기
String id = request.getParameter("id");
dto = dao.getMember(id);
Map<String, Object> param = new HashMap<String, Object>();
%>
</head>

<%@include file="./top01.jsp" %>

  	<!-- 왼쪽메뉴 -->
	<jsp:include page="left01.jsp"/>


 <div id="content-wrapper">

      <div class="container-fluid">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="index.html">관리자 정보수정</a>
          </li>
          <li class="breadcrumb-item active"></li>
        </ol>
        <!-- Page Content -->
  
  
  
  <form method="post" name="writeFrm" action="edit_proc.jsp?">
	<table class="table table-bordered">
	<colgroup>
		<col width="20%"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">아이디</th>
				<input type="hidden" name="id" value="<%=dto.getId() %>" />
			<td><%=dto.getId() %>&nbsp;&nbsp;※아이디는 변경하실수 없습니다.
<!-- 				<input type="text" class="form-control"  -->
<!-- 					style="width:100px;" /> -->
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">패스워드</th>
			<td>
 				<input type="password" name="pass" class="form-control" 
 					style="width:400px;" value="<%=dto.getPass()%>"/>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">이름</th>
			<td>
				<input type="text" name="name" class="form-control"  
 					style="width:200px;" value="<%=dto.getName()%>"/> 
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">이메일</th>
			<td>
				<input type="text" class="form-control" name="email" value="<%=dto.getEmail()%>"/>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">전화번호</th>
			<td>
				<input type="text" class="form-control" name="phoneNum" value="<%=dto.getPhoneNum()%>"/>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">주소</th>
			<td>
				<input type="text" class="form-control" name="address" value="<%=dto.getAddress()%>"/>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">등급</th>
			<td>
				<input type="text" class="form-control" name="grade" value="<%=dto.getGrade()%>"/>
			</td>
		</tr>
	</tbody>
	</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	
	<button type="submit" class="btn btn-danger">전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning" 
		onclick="">
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

  </div>
  <!-- /#wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">×</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
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
