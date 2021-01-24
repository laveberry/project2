<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="smtp.SMTPAuth"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%
request.setCharacterEncoding("utf-8");

System.out.println("블루클리닝 컨트롤페이지 시작");
//블루클리닝 컨트롤 페이지. 이메일 발송 연결

//폼값 받아오기
String name = request.getParameter("name");
String address = request.getParameter("address");
String num = request.getParameter("num1")+request.getParameter("num2")+request.getParameter("num3");
String phone = request.getParameter("phone1")+request.getParameter("phone2")+request.getParameter("phone3");
String mail = request.getParameter("mail1")+"@"+request.getParameter("mail2");
String clean = request.getParameter("clean");//청소종류
String space = request.getParameter("space");//분양평수/등기평수
String day = request.getParameter("day");//청소희망날짜
String type = request.getParameter("type");//예약신청,견적문의 라디오값 구분
String etc = request.getParameter("etc");//기타특이사항
//폼값 확인
System.out.println("type="+type);

//메일전송 컨텐츠 내용
String content = "==블루크리닝 신청내용==<br/>이름:"+name+"<br/>메일:"+mail
			+"<br/>주소:"+address+"<br/>연락처:"+phone+"<br/>청소종류:"+clean
			+"<br/>분양평수/등기평수:"+space+"<br/>희망날짜:"+day+"<br/>접수종류:"+type
			+"<br/>기타특이사항:"+etc;

//이메일발송을 위한 객체생성
SMTPAuth smtp = new SMTPAuth();
//메일을 보내기위해 폼값 Map에 저장
Map<String, String> blueCleaningMail = new HashMap<String, String>();
blueCleaningMail.put("from", "berry1990@naver.com");
blueCleaningMail.put("to", mail);
blueCleaningMail.put("subject", "블루클리닝 신청내역");
blueCleaningMail.put("content", content);
boolean customerSend = smtp.emailSending(blueCleaningMail);
if(customerSend==true){
	out.print("고객에게 메일발송 성공");
}
else{
	out.print("고객에게 메일발송 실패");
}

//고객, 관리자에게 이메일 발송
//관리자에게 메일발송(put값만 변경해서 발송)
blueCleaningMail.put("to", "berry1990@naver.com");
blueCleaningMail.put("subject", session.getAttribute("USER_ID")+"고객의 블루클리닝 신청내역");
boolean adminSend = smtp.emailSending(blueCleaningMail);
if(adminSend==true){
// 	System.out.println("관리자에게 메일발송 성공");
	out.println("관리자에게 메일발송 성공");
}
else{
// 	System.out.println("관리자에게 메일발송 실패");
	out.println("관리자에게 메일발송 실패");
}

%>