<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ page import="java.text.*,java.util.*"%>
<%
//Javaalert사용시 이렇게 out객체 안에 넣어주거나 out객체를 전달해주어야한다!
out.println(JavascriptUtil.jsAlertBack("테스트"));
%>

