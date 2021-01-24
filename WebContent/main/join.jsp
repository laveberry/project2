<%@page import="util.JavascriptUtil"%>
<%@page import="multi.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//회원가입 관련 폼값 받아오기
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email_1")+"@"+request.getParameter("email_2");
String teleNum = request.getParameter("tel1")+request.getParameter("tel2")+request.getParameter("tel3");
String phoneNum = request.getParameter("mobile1")+request.getParameter("mobile2")+request.getParameter("mobile3");
String zipcode = request.getParameter("zip1");
String address = request.getParameter("addr1")+request.getParameter("addr2");

//폼값 확인
System.out.println(email);
System.out.println(teleNum);
System.out.println(phoneNum);
System.out.println(zipcode);
System.out.println(address);

//회원가입 진행
MemberDAO dao = new MemberDAO();
int result = dao.regist(id, pass, name, email, teleNum, phoneNum, address);

if(result==1){
	JavascriptUtil.jsAlertLocation("회원가입성공★", "main.jsp", out);
}
else{%>
	<script>
		alert("회원가입실패");
		history.back();
	</script>
<%
}
%>
