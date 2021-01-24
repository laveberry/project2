<%@page import="util.JavascriptUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="smtp.SMTPAuth"%>
<%@page import="multi.MemberDAO"%>
<%@page import="java.util.Map"%>
<script src="../common/jquery/jquery-3.5.1.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//패스워드 찾기
request.setCharacterEncoding("UTF-8");

//폼값받기
String id = request.getParameter("user_id");
String name = request.getParameter("user_name2");
String email = request.getParameter("user_mail2");
//폼값확인
System.out.println("아이디:"+id);
System.out.println("이름:"+name);
System.out.println("이메일:"+email);
//DB연결
MemberDAO dao = new MemberDAO();
String pwSearch = dao.pwSearch(id, name, email); 
dao.close();

//비번 찾기 성공
 if(pwSearch!=""){  
   System.out.println("pw=:"+pwSearch);
   
	//이메일로 메일주소 보내기
	SMTPAuth smtp = new SMTPAuth();
	
// 	Map<String, String> emailContent = new HashMap<String, String>();
// 	emailContent.put("from", request.getParameter("from"));
// 	emailContent.put("to", request.getParameter("to"));
// 	emailContent.put("subject", request.getParameter("subject"));
// 	emailContent.put("content", request.getParameter("content"));
	
	Map<String, String> emailContent = new HashMap<String, String>();
	emailContent.put("from", "berry1990@naver.com");
	emailContent.put("to", email);
	emailContent.put("subject", "[KSOMO]비밀번호 찾기 결과 전송");
	emailContent.put("content", name+"님의 비밀번호는"+pwSearch+"입니다.");
	
	boolean emailResult = smtp.emailSending(emailContent);
	if(emailResult==true){
		JavascriptUtil.jsAlertLocation("메일발송 성공", "../main/main.do;", out);
	}
	else{
// 		out.print("메일발송실패");
		out.print(JavascriptUtil.jsAlertLocation("메일발송실패", "history.back()")); //url안에 ;넣지 말아야함!
	}
	JavascriptUtil.jsAlertBack("고객님의 비번은:"+pwSearch+"입니다");
	return;
} 
else{
	JavascriptUtil.jsAlertLocation("회원이 아닙니다", "history.go(-1)", out);
}
