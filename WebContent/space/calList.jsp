<%@page import="java.util.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
  <title>캘린더</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<%@ include file="../include/global_head.jsp"%>
<!-- 달력 프로그램리스트 -->
<%
request.setCharacterEncoding("UTF-8");
String menu = "space";
String flag = "02";
String menulist ="";
switch(menu){
	case "space": menulist="열린공간"; break;
}

String flaglist = "";
switch(flag){
	case "02": flaglist = "프로그램일정"; break;
}

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
		url : "../main/calAjax.jsp",
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
			url : "../main/calAjax.jsp",
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
			url : "../main/calAjax.jsp",
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
</script>

	<center>  
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
		<img src="../images/<%=menu %>/sub_image.jpg" id="main_visual" />  
		<div class="contents_box">
			<div class="left_contents">
			
				<%//include url용 스트링 생성
				String leftMenu = "../include/"+menu+"_leftmenu.jsp";  %>
				<jsp:include page="<%=leftMenu %>"/> 
				
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/<%=menu %>/sub<%=flag %>_title.gif" alt="게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;<%=menulist %>&nbsp;>&nbsp;<%=flaglist %>
					<p>
				</div>
			</div>
			
			
			<div>
				<table border="0">
					<input type="hidden" id="hyear" name="hyear" value="<%=now_year%>" />
					<input type="hidden" id="hmonth" name="hmonth" value="<%=now_month%>" />
					
					<tr>
						<td><button id="calBefore" style="border:0">
							<img src="../images/cal_a01.gif" alt="이전달" />
						</button>
						</td>
						<td><span id="calYear"
							style="font-size: 1.4em; font-weight: bold;"><%=now_year%></span>&nbsp;&nbsp;
						<span id="calMon" style="font-size: 1.2em;"><%=now_month%></span><span style="font-size: 1.2em;">월</span> 
					<td><button id="calAfter" style="border: 0">
					<img src="../images/cal_a02.gif" style="margin-top: 3px;" />
				</button></td>
			<!-- 캘린더 버튼. 다음달-->
					</tr>				
			</table>
			
			<div id="calBody">
				달력Display
			</div>
			</div>

		
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>