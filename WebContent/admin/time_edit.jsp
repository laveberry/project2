<%@page import="multi.BbsDTO"%>
<%@page import="multi.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
//캘린더 내용 저장용 폼값 받기
String content = request.getParameter("content");
String cal = request.getParameter("cal");
String id = session.getAttribute("USER_ID").toString();

BbsDAO dao = new BbsDAO();
BbsDTO dto = new BbsDTO();

int result = dao.calControl(id, content, cal);
dao.close();

if(result==1){%>
<script>
	alert("달력 내용쓰기 성공");
	location.href = "timeCtrl.jsp";
</script>
	
<%
}
else{%>
<script>
	alert("달력 내용쓰기 실패ㅠ");
	history.go(-1);
</script>
<%}
%>