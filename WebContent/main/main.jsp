<%@page import="java.time.DayOfWeek"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Iterator"%>
<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
<%@page import="java.util.Calendar"%>
<%@page import="survlet.mainSurvlet"%>
<%@page import="java.util.List"%>
<%@page import="util.CookieUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<!-- <link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" /> -->
<!-- 제이쿼리 추가 -->
<script src="../common/jquery/jquery-3.5.1.js"></script>

<style type="text/css" media="screen">
@import url("../css/common.css");
@import url("../css/main.css");
@import url("../css/sub.css");
.
</style>

<%
//캘린더
Calendar tDay = Calendar.getInstance(); //현재날짜
int now_year = tDay.get(Calendar.YEAR); //현재년도
int now_month = tDay.get(Calendar.MONTH) + 1; //현재월
int now_week = tDay.get(Calendar.DAY_OF_WEEK);//현재요일(일1, 토7)
int now_day = tDay.get(Calendar.DATE); //현재일
int last_day = tDay.getActualMaximum(Calendar.DAY_OF_MONTH);//현재달 마지막 일

Calendar cDay = Calendar.getInstance();
cDay.set(cDay.DAY_OF_MONTH, 1);//DAY_OF_MONTH를 1로 설정(월의 첫날)
int first_week = cDay.get(Calendar.DAY_OF_WEEK);//위에서 설정한 1일의 요일
cDay.set(cDay.DAY_OF_MONTH, last_day);//DAY_OF_MONTH를 1로 설정(월의 첫날)
int last_week = cDay.get(Calendar.DAY_OF_WEEK);//마지막일의 요일
%>
<%
//쿠키 불러오기
String saveId = "";
Cookie[] cookies = request.getCookies();

if (cookies != null) {
	for (Cookie c : cookies) {
		if (c.getName().equals("SAVE_ID")) {
	saveId = c.getValue();
	//저장쿠키 확인
	System.out.println("saveId=" + saveId);
	//쿠키값 req에 저장하기
	request.setAttribute("cookieID", saveId);
		}
	}
}
//메인 게시판용 리스트 불러오기
BbsDAO dao = new BbsDAO();
List<BbsDTO> notice = dao.mainList("01", 5);
List<BbsDTO> free = dao.mainList("03", 5);
List<BbsDTO> image = dao.mainList("04", 6);
dao.close(); 
%>
<script>
//캘린더 아잭스
$(function() {
	//계산을 위한 변수선언
	var sum = parseInt($('#hmonth').val());
	var sum2 = parseInt($('#hyear').val());
	var mon = $('#calMon');
	var year = $('#calYear');
	
	//아잭스 시작(현재상태)
	$.ajax({
		url : "calAjax.jsp",
		type : "post",
		data :
			{
			year : $('#calYear').text(),
			month : $('#calMon').text(),
			},
		dateType : "html",
		contentType : "application/x-www-form-urlencoded;chatset:utf-8",
		success : function(Date) {
			$("#calBody").html(Date);
			},
		error : function(request,status,error) {
			//확인하기
	        alert("code:"+request.status+"\n"+"message:"+request.responseText+
	        		"\n"+"error:"+error);
		}
	});
	//이전달 클릭시 액션 및 Ajax
	$('#calBefore').bind("click", function() {
		if (sum == 1) {
			sum = 12;
			sum2--;
		}else {sum--;}
		mon.text(sum);
		year.text(sum2);
		//ajax실행
		$.ajax({
			url : "calAjax.jsp",
			type : "post",
			data :
				{
				year : $('#calYear').text(),
				month : $('#calMon').text(),
				},
			dateType : "html",
			contentType : "application/x-www-form-urlencoded;chatset:utf-8",
			success : function(Date) {
				$("#calBody").html(Date);
				},
			error : function(request,status,error) {
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+
		        		"\n"+"error:"+error);
			}
		});
	});
	//다음달 클릭시 액션 및 Ajax
	$('#calAfter').click(function() {
		if (sum == 12) {
			sum = 1;
			sum2++;
		}else {sum++;}
		mon.text(sum);
		year.text(sum2);
		//ajax실행
		$.ajax({
			url : "calAjax.jsp",
			type : "post",
			data :
				{
				year : $('#calYear').text(),
				month : $('#calMon').text(),
				},
			dateType : "html",
			contentType : "application/x-www-form-urlencoded;chatset:utf-8",
			success : function(Date) {
				$("#calBody").html(Date);
				},
			error : function(request,status,error) {
		        alert("code:"+request.status+"\n"+"message:"+request.responseText+
		        		"\n"+"error:"+error);
			}
		});
	});
});


//로그인 체크
function loginValidate(fn) {
	if (fn.user_id.value == "") {
		alert("아이디를 입력하세요");
		fn.user_id.focus();
		return false;
	}
	if (!fn.user_pw.value) {
		alert("패스워드를 입력하세요");
		fn.user_pw.focus();
		return false;
	}
}
</script>
</head>

<body>
	<center>
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>

			<div id="main_visual">
				<a href="/product/sub01.jsp"><img
					src="../images/main_image_01.jpg" /></a><a
					href="/product/sub01_02.jsp"><img
					src="../images/main_image_02.jpg" /></a><a
					href="/product/sub01_03.jsp"><img
					src="../images/main_image_03.jpg" /></a><a href="/product/sub02.jsp"><img
					src="../images/main_image_04.jpg" /></a>
			</div>

			<div class="main_contents">
				<div class="main_con_left">
					<p class="main_title" style="border: 0px; margin-bottom: 0px;">
						<img src="../images/main_title01.gif" alt="로그인 LOGIN" />
					</p>
					<div class="login_box">

						<!-- 로그인 전 -->
						<%
							if (session.getAttribute("USER_ID") == null) {
						%>
						<form method="post"
							action="<%=request.getContextPath()%>/main/main.do"
							name="loginFrm" onsubmit="return loginValidate(this);">
							<table cellpadding="0" cellspacing="0" border="0">
								<colgroup>
									<col width="45px" />
									<col width="120px" />
									<col width="55px" />
								</colgroup>
								<tr>
									<th><img src="../images/login_tit01.gif" alt="아이디" /></th>
									<td><input type="text" name="user_id"
										value="<%=(request.getAttribute("cookieID") == null) ? "" : request.getAttribute("cookieID")%>"
										class="login_input" /></td>
									<td rowspan="2"><input type="image"
										src="../images/login_btn01.gif" alt="로그인" /></td>
								</tr>
								<tr>
									<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
									<td><input type="password" name="user_pw" value=""
										class="login_input" /></td>
								</tr>
							</table>
							<p>
								<input type="checkbox" id="id_save" name="id_save" value=""
									<%if (request.getAttribute("cookieID") != null && request.getAttribute("cookieID") != "") {%>
									checked="checked" <%}%> /> <img
									src="../images/login_tit03.gif" alt="저장" /> <a
									href="../member/id_pw.jsp"><img
									src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a> <a
									href="../member/join01.jsp"><img
									src="../images/login_btn03.gif" alt="회원가입" /></a>
							</p>
							<%}%>

							<!-- 로그인 성공 -->
							<%
								if (session.getAttribute("USER_ID") != null) {
							%>
							<p style="padding: 10px 0px 10px 10px">
								<span style="font-weight: bold; color: #333;"><%=session.getAttribute("USER_NAME")%>님,</span>
								반갑습니다.<br />로그인 하셨습니다.
							</p>
							<p style="text-align: right; padding-right: 10px;">
								<a href=""><img src="../images/login_btn04.gif" /></a> <a
									href="../member/logout.jsp"><img
									src="../images/login_btn05.gif" /></a>
							</p>
							<!-- 로그인 실패 -->
							<%
								} else if (request.getAttribute("ERROR_MSG") == "실패") {
							%>
							<script>
								alert("아이디/비밀번호 오류");
							</script>
							<%
								}
							%>

						</form>
					</div>
				</div>
				<div class="main_con_center">
					<p class="main_title">
						<img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a
							href="../space/boardList.jsp?menu=space&flag=01&nowPage=1"><img
							src="../images/more.gif" alt="more" class="more_btn" /></a>
					</p>
				<ul class="main_board_list">
					<%
					for(BbsDTO dto : notice){ %>
							<%
							if(dto.getFlag().equals("01")){%>
						<li><p style="width:200px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;">
							<a href="../space/board_view.jsp?menu=space&flag=01&num=<%=dto.getNum() %>&nowPage=1">
								<%=dto.getTitle() %></a><span><%=dto.getPostdate() %></span>
						</p></li>
						<%
						}
					} %>
					</ul>
				</div>
				<div class="main_con_right">
					<p class="main_title">
						<img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a
							href="../space/boardList.jsp?menu=space&flag=03&nowPage=1"><img
							src="../images/more.gif" alt="more" class="more_btn" /></a>
					</p>
				<ul class="main_board_list">
						<!-- maxlength='10' 와  style='text-overflow:ellipsis; 로 글자수 제한-->
<%--   				  <c:forEach items="${bbs }" var="dto" varStatus="loop"> --%>
<%--   				  	<c:if test="${dto.flag eq 03}"> --%>
					<%
					for(BbsDTO dto : free){ %>
							<%
							if(dto.getFlag().equals("03")){%>
						<li><p style="width:200px; overflow:hidden; white-space:nowrap; text-overflow:ellipsis;">
							<a href="../space/board_view.jsp?menu=space&flag=03&num=<%=dto.getNum() %>&nowPage=1"'>
								<%=dto.getTitle() %></a><span><%=dto.getPostdate() %></span>
						</p></li>
					<%
						}
					} %>
<%-- 						</c:if> --%>
<%-- 				</c:forEach> --%>
					</ul>
				</div>
			</div>
 

		<div class="main_contents">
	<div class="main_con_left">
		<p class="main_title">
			<img src="../images/main_title04.gif" alt="월간일정 CALENDAR" />
		</p>
		<img src="../images/main_tel.gif" />
	</div>
	<div class="main_con_center">
	
	
	<!-- 년/월만 텍스트 처리하기 -->
<p class="main_title" style="border: 0px; margin-bottom: 0px;">
	<img src="../images/main_title05.gif" alt="월간일정 CALENDAR" />
</p>
<div class="cal_top">
	<table cellpadding="0" cellspacing="0" border="0">
		<colgroup>
			<col width="13px;" />
			<col width="*" />
			<col width="13px;" />
		</colgroup>
		<!-- EL식은 안되네염 ? -->
		<input type="hidden" id="hyear" name="hyear" value="<%=now_year%>" />
		<input type="hidden" id="hmonth" name="hmonth" value="<%=now_month%>" />
		<tr>
			<!-- 							<td><a href="" id="calBefore"><img src="../images/cal_a01.gif" style="margin-top:3px;" /></a></td>캘린더 이전달 -->
			<td><button id="calBefore" style="border: 0">
					<img src="../images/cal_a01.gif" style="margin-top: 3px;" />
				</button></td>
			<!-- 년 -->
			<td><span id="calYear"
				style="font-size: 1.4em; font-weight: bold;"><%=now_year%></span>&nbsp;&nbsp;
				<span id="calMon" style="font-size: 1.2em;"><%=now_month%></span><span
				style="font-size: 1.2em;">월</span> <!-- 							<td><img src="../images/calender_2012.gif" id="calYear" />&nbsp;&nbsp; -->
				<!-- 월 --> <!-- 							<img src="../images/calender_m1.gif" id="calMon"/></td> -->
			<td><button id="calAfter" style="border: 0">
					<img src="../images/cal_a02.gif" style="margin-top: 3px;" />
				</button></td>
			<!-- 캘린더 버튼. 다음달-->
		</table>
		</div>
		<div class="cal_bottom" id="calBody">
			달력Display
		</div>
		</div>

				
				<!-- 사진게시판 -->
				<div class="main_con_right">
					<p class="main_title">
						<img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a
							href="../space/list_ctrl?menu=space&flag=04"><img src="../images/more.gif"
							alt="more" class="more_btn" /></a>
					</p>
					<ul class="main_photo_list">
					<%
					int a = 0, b = 3;
					%>
					<table border='1px dotted gray' style="text-align: center;">
					<%for(BbsDTO dto : image){ %> 
						<%
						if(a%b==0){%>
						<tr>
						<%} %>
							<td width="33.3%">
								<dl>
									<dt>
										<a href="../space/sub04_view.jsp?menu=space&flag=04&num=<%=dto.getNum()%>&nowPage=1">
											<img src="../Upload/<%=dto.getAttachedfile() %>" style="width: 100%; object-fit: cover;"/></a>
									</dt>
									<dd style="overflow:hidden; white-space:nowrap; text-overflow:ellipsis;">
										<a href="../space/sub04_view.jsp?menu=space&flag=04&num=<%=dto.getNum()%>&nowPage=1" >
											<%=dto.getTitle() %></a>
									</dd>
								</dl>
							</td>
							<%if(a%b==b-1){ %>
							</tr>
							<%}
							a++;
							}%>
					</table>
				</ul>	
			</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>

		<%@ include file="../include/footer.jsp"%>

	</center>
</body>
</html>