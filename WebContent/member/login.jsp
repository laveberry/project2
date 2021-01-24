<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
// String menu = request.getParameter("menu");
// String flag = request.getParameter("flag");
%>
<script>
	var id = document.getElementsByName("user_id");
	var pw = document.getElementsByName("user_pw");
	function loginValidate() {
		if(id[0].value=="" || id[0].value==null){
			alert("아이디를 입력하세요");
			id[0].focus();
			return false;
		}
		if(!pw[0].value){
			alert("패스워드를 입력하세요");
			pw[0].focus();
			return false;
		}
	}
</script>
<!--  <body> -->
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
		<!-- form 추가 -->
<%-- 	<form action="<%=request.getContextPath() %>/main/main.do" method="get" onsubmit="return loginValidate()"> --%>
	<form action="LoginProcessMap.jsp" method="post" onsubmit="return loginValidate()">
	
		<!-- 로그인 후 이동할 페이지가 있는경우 해당파라미터를 EL로 얻어와 hidden폼에 추가.
			이값은 로그인처리 페이지로 전달된다. -->
		<input type="hid-den" name="returnURL" value="${param.returnURL }"/>
		<input type="hid-den" name="flag" value="${param.flag }"/>
		<input type="hid-den" name="menu" value="${param.menu }"/>
	
<%-- 	<form action="<%=request.getContextPath() %>/space/login.do"> --%> <!-- 위에꺼 안될시 이걸루하기 -->
		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/login_title.gif" alt="인사말" class="con_title" />
					<p class="location">
					<input type="image" src="../images/center/house.gif"/>&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
<!-- 					<img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p> -->
				</div>
				<div class="login_box01">
					<img src="../images/login_tit.gif" style="margin-bottom:30px;" />
					<ul>
						<li><img src="../images/login_tit001.gif" alt="아이디" style="margin-right:15px;" /><input type="text" name="user_id" value="" class="login_input01" /></li>
						<li><img src="../images/login_tit002.gif" alt="비밀번호" style="margin-right:15px;" /><input type="password" name="user_pw" value="" class="login_input01" /></li>
					</ul>
					<!-- 폼값 전송을 위해 input으로 변경 -->
					<button type="submit"><img src="../images/login_btn.gif" alt="로그인" class="login_btn01" /></button>
<!-- 					<input type="image" src="../images/login_btn.gif" alt="로그인" class="login_btn01"/> -->
<!-- 					<a href="#" onclick="loginValidate()"><img src="../images/login_btn.gif" class="login_btn01" /></a> -->
				</div>
				<p style="text-align:center; margin-bottom:50px;"><a href="id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>&nbsp;<a href="join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</form>
	</div>

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
