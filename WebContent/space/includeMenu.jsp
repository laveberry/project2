<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
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
int num = Integer.parseInt(request.getParameter("num"));
// String menu = request.getParameter("menu");
String flag = request.getParameter("flag");
String flaglist = "";
switch (flag) {
case "01": flaglist = "공지사항"; break;
case "02": flaglist = "프로그램일정"; break;
case "03": flaglist = "자유게시판"; break;
case "04": flaglist = "사진게시판"; break;
case "05": flaglist = "정보자료실"; break;
case "06": flaglist = "직원자료실"; break;
case "07": flaglist = "보호자게시판"; break;
}
String menu = "";
// 상단메뉴구분
switch (flag) {
case "01":case "02":case "03":case "04":case "05":
	menu = "space";break;
case "06":case "07":
	menu = "community";break;
}
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
String queryStr = "menu=" + menu + "&flag=" + flag;
if (searchWord != null) {
	queryStr += "searchColumn=" + searchColumn + "&searchWord=" + searchWord;
}
//2페이지에서 상세보기 했다면 리스트로 돌아갈때도 페이지가 유지되어야 한다.
String nowPage = request.getParameter("nowPage");
queryStr += "&nowPage=" + nowPage;

String leftMenu = "../include/" + menu + "_leftmenu.jsp";
%>
</body>
</html>