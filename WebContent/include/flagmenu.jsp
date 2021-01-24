<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"></script>
</head>
<body>
<%
//flag에 따른 게시판 이름 구분 처리
String flag = request.getParameter("flag");
String menu = request.getParameter("menu");
System.out.println("수정flag="+flag);
String flaglist = "";
switch(flag){
	case "01": flaglist = "공지사항"; break;
	case "02": flaglist = "프로그램일정"; break;
	case "03": flaglist = "자유게시판"; break;
	case "04": flaglist = "사진게시판"; break;
	case "05": flaglist = "정보자료실"; break;
}
%>
</body>
</html>