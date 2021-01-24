<%@page import="util.FileUtil"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="util.JavascriptUtil"%>
<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 체크 -->
<%@ include file="../include/isLogin.jsp" %>

<%
request.setCharacterEncoding("UTF-8");
BbsDTO dto = new BbsDTO();
MultipartRequest req = FileUtil.upload(request, request.getServletContext().getRealPath("/Upload"));
String title = req.getParameter("title");
String content = req.getParameter("content");
String file = req.getParameter("file");
String flag = req.getParameter("flag");
String menu = req.getParameter("menu");

dto.setTitle(title);
dto.setContent(content);
dto.setAttachedfile(file);
dto.setFlag(flag);
dto.setId(session.getAttribute("USER_ID").toString());


BbsDAO dao = new BbsDAO(application);

// 100개 글쓰기
// int affected = 1;
// for(int i=1 ; i<100 ; i++){
// 	dto.setTitle(title + " "+i+"번째 게시물");
// 	dao.insertWrite(dto);
// }

int affected = dao.insertWrite(dto);
if(affected==1){
	JavascriptUtil.jsAlertBack("글쓰기 성공!");
	response.sendRedirect("boardList.jsp?menu="+menu+"&flag="+flag);
}
else{%>
	<script>
		alert("글쓰기에 실패하였습니다.");
		history.back();
	</script>
	
<%
// 	request.getRequestDispatcher("/14Dataroom/DataWrite.jsp");
}
%>