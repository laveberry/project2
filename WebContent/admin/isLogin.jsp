<%@page import="util.JavascriptUtil"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
System.out.println("isLogin 시작");
//관리자 등급 불러오기
String adminCheck = (String) session.getAttribute("USER_GRADE");
System.out.println("등급="+adminCheck);
String r_uri = request.getRequestURI();
//로그인 안되어있을때
if(session.getAttribute("USER_ID")==null || adminCheck=="01" || adminCheck==null || adminCheck=="") {
%>
<script>
	alert("관리자만 사용 가능합니다.");
	location.href="./login.jsp?returnURL=<%=r_uri%>"; 
</script>
<%	
	return;
}
%>