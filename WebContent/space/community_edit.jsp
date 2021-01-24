<%@page import="multi.MemberDAO"%>
<%@page import="multi.MemberDTO"%>
<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 체크 -->
<%@ include file="../include/isLogin.jsp" %>
<%@ include file="../include/global_head.jsp" %>
<script>
	function checkValidate(fm){
		if(fm.title.value==""){
			alert("제목을 입력하세요."); 
			fm.title.focus(); 
			return false; 
		}
		if(fm.content.value==""){
			alert("내용을 입력하세요."); 
			fm.content.focus(); 
			return false;
		}
	}
</script>
<!--  <body> -->
<center>
<div id="wrap">
	<%@ include file="../include/top.jsp" %>

	<img src="../images/${menu }/sub_image.jpg" id="main_visual" />

	<div class="contents_box">
		<div class="left_contents">
			<%@ include file = "../include/community_leftmenu.jsp" %>
		</div>
		<div class="right_contents">
			<div class="top_title">
				<img src="../images/${menu }/sub${flag }_title.gif" alt="" class="con_title" />
				<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;${menulist }&nbsp;&nbsp;${flaglist }<p>
			</div>
		<div>

<form enctype="multipart/form-data" onsubmit="return checkValidate(this);"
	method="post" name="writeFrm" action="../space/edit_ctrl">
	<table class="table table-bordered">
	<colgroup>
		<col width="20%"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">작성자</th>
			<td>${sessionScope.USER_NAME }
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">제목</th>
			<td>
				<input type="text" class="form-control" name="title" value="${dto.title }"/>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">내용</th>
			<td>
				<textarea rows="10" class="form-control" name="content" value="${dto.content }"></textarea>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">첨부파일</th>
			<td>
				첨부파일명 : ${dto.attachedfile } <br />
				<input type="file" class="form-control" name="file" />
			</td>
		</tr>
		<input type="hidden" name="flag" value="${param.flag }" />
		<input type="hidden" name="menu" value="${param.menu }" />
		<input type="hidden" name="num" value="${dto.num }" />
		
	</tbody>
	</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	
	<button type="submit" class="btn btn-danger">전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning">
		<a href="../space/list_ctrl?${queryStr }">
		리스트보기
		</a>
	</button>
</div>
</form> 
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>