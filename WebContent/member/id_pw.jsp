<%@page import="multi.MemberDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="multi.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>아이디/패스워드 찾기</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>

<script>
function loginValidate(fn) {
	if(fn.user_name.value=="" || fn.user_name.value==null){
		alert("이름을 입력하세요");
		fn.user_name.focus();
		return false;
	}
	if(fn.user_mail.value=="" || fn.user_name.value==null){
		alert("이메일을 입력하세요");
		fn.user_mail.focus();
		return false;
	}
	if(fn.user_id.value=="" || fn.user_id.value==null){
		alert("이메일을 입력하세요");
		fn.user_id.focus();
		return false;
	}
}
function loginValidate2(fn) {
	if(!fn.user_id.value){
		alert("아이디를 입력하세요");
		fn.user_id.focus();
		return false;
	}
	if(!fn.user_name2.value){
		alert("이름을 입력하세요");
		fn.user_name2.focus();
		return false;
	}
	if(!fn.user_mail2.value){
		alert("이메일을 입력하세요");
		fn.user_mail2.focus();
		return false;
	}
}
</script>

<%@ include file="../include/global_head.jsp" %>
<!--  <body> -->
<!-- 	<center> -->
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
		<img src="../images/member/sub_image.jpg" id="main_visual" />
		
		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				
				<div class="idpw_box">
					<div class="id_box">
		<form action="searchid.jsp" onsubmit="return loginValidate(this)">
						<ul>
							<li><input type="text" name="user_name" value="" class="login_input01" /></li>
							<li><input type="text" name="user_mail" value="" class="login_input01" /></li>
						</ul>
						<input type="image" src="../images/member/id_btn01.gif" class="id_btn" />
<!-- 						<button type="submit"><img src="../images/member/id_btn01.gif" class="id_btn" /></button> -->
<!-- 						<a href="join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a> -->
		</form>
					</div>
					<div class="pw_box">
		<form action="searchpw.jsp" onsubmit="return loginValidate2(this)">
						<ul>
							<li><input type="text" name="user_id" value="" class="login_input01" /></li>
							<li><input type="text" name="user_name2" value="" class="login_input01" /></li>
							<li><input type="text" name="user_mail2" value="" class="login_input01" /></li>
						</ul>
						 	<input type="image" src="../images/member/id_btn01.gif" class="pw_btn" />
<!-- 						<button type="submit"><img src="../images/member/id_btn01.gif" class="pw_btn" /></button> -->
<!-- 						<a href=""><img src="../images/member/id_btn01.gif" class="pw_btn" /></a> -->
		</form>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
