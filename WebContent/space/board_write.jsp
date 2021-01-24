<%@page import="multi.MemberDAO"%>
<%@page import="multi.MemberDTO"%>
<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 체크 -->
<%@ include file="../include/isLogin.jsp" %>
<%@ include file="../include/global_head.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

//flag에 따른 게시판 이름 구분 처리
String flag = request.getParameter("flag");
String menu = request.getParameter("menu");
System.out.println("쓰기flag="+flag);
String flaglist = "";
switch(flag){
	case "01": flaglist = "공지사항"; break;
	case "02": flaglist = "프로그램일정"; break;
	case "03": flaglist = "자유게시판"; break;
	case "04": flaglist = "사진게시판"; break;
	case "05": flaglist = "정보자료실"; break;
}

String uid = session.getAttribute("USER_ID").toString();
String upw = session.getAttribute("USER_PW").toString();

MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.getMemberDTO(uid, upw);

%>
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

	<img src="../images/space/sub_image.jpg" id="main_visual" />

	<div class="contents_box">
		<div class="left_contents">
			<%@ include file = "../include/space_leftmenu.jsp" %>
		</div>
		<div class="right_contents">
			<div class="top_title">
				<img src="../images/space/sub<%=flag %>_title.gif" alt="" class="con_title" />
				<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%=flaglist %><p>
			</div>
		<div>

<form enctype="multipart/form-data" onsubmit="return checkValidate(this);"
	method="post" name="writeFrm" action="write_Proc.jsp?&menu=<%=menu %>flag=<%=flag %>">
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
				<input type="text" class="form-control" name="title" />
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">내용</th>
			<td>
				<textarea rows="10" class="form-control" name="content"></textarea>
			</td>
		</tr>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">첨부파일</th>
			<td>
				<input type="file" class="form-control" name="file" />
			</td>
		</tr>
		<input type="hidden" name="flag" value="<%=flag %>" />
		<input type="hidden" name="menu" value="<%=menu %>" />
	</tbody>
	</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	
	<button type="submit" class="btn btn-danger">전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='boardList.jsp?menu=${param.menu }&flag=${param.flag }&nowPage=${param.nowpage }&searchColumn=${param.searchColumn }&searchWord=${param.searchWord }';">
		리스트보기</button>
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