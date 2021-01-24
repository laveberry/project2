<%@page import="util.FileUtil"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="multi.MemberDAO"%>
<%@page import="multi.MemberDTO"%>
<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 로그인 체크 -->
<%@ include file="../include/isLogin.jsp" %>
<%@ include file="../include/global_head.jsp" %>
<%-- <%@ include file="../flagmenu.jsp" %>  --%>
<%@ include file="./includeMenu.jsp" %>

<%
System.out.println("관리자 게시판 수정하기 시작!");
System.out.println("수정flag="+flag);

BbsDAO dao = new BbsDAO();
BbsDTO dto = dao.selectView(flag, num);
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
				<img src="../images/space/sub<%=flag %>_title.gif" alt="공지사항" class="con_title" />
				<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%=flaglist %><p>
			</div>
		<div>

<form enctype="multipart/form-data" onsubmit="return checkValidate(this);"
	method="post" name="writeFrm" action="../space/edit_ctrl?<%=queryStr%>">
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
			<!-- 첨부파일 확인하기★ -->
			<th class="text-center" 
				style="vertical-align:middle;">첨부파일</th>
					첨부파일명 : <%=(dto.getAttachedfile()==null) ? "" : dto.getAttachedfile()%>
			<td>
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
	<%if(flag.equals("04")){ %>
		<button type="button" class="btn btn-warning" 
			onclick="location.href='sub04.jsp?<%=queryStr%>'">
			리스트보기</button>
	<%}else{%>
		<button type="button" class="btn btn-warning" 
		onclick="location.href='boardList.jsp?<%=queryStr%>'">
		리스트보기</button>
	<%} %>
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