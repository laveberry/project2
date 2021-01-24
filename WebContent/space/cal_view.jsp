<%@page import="survlet.list_ctrl"%>
<%@page import="util.PagingUtil"%>
<%@page import="multi.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="multi.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<title>캘린더 상세보기</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<%
request.setCharacterEncoding("utf-8");

String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");
String flag = request.getParameter("flag");

request.setCharacterEncoding("UTF-8");
String menu = "space";
String menulist ="";
switch(menu){
	case "space": menulist="열린공간"; break;
}
String flaglist = "";
switch(flag){
	case "02": flaglist = "프로그램일정"; break;
}
Map map = new HashMap();
map.put("cal", year+month+day);

BbsDAO dao = new BbsDAO();
BbsDTO dto = dao.calView(map);
dao.close();
%>

<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>
		<img src="../images/<%=menu %>/sub_image.jpg" id="main_visual" />
		<div class="contents_box">
			<div class="left_contents">

				<!-- 지시어 안에는 표현식 쓸수없음 -->
				<%-- 				<%@ include file = "../include/<%=menu%>_leftmenu.jsp" %>  --%>
				<!-- 액션태그 지시어 사용시 전체는 가능하지만 중간삽입은 안됨 -->
				<%-- 				<jsp:include page="../include/<%=menu%>_leftmenu.jsp"/> --%>
				<!-- 액션태그 사용시 이렇게! -->
				<%//include url용 스트링 생성
				String leftMenu = "../include/"+menu+"_leftmenu.jsp";  %>
				<jsp:include page="<%=leftMenu %>" />

			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/<%=menu %>/sub<%=flag %>_title.gif" alt="게시판"
						class="con_title" />
					<p class="location">
						<img src="../images/center/house.gif" />&nbsp;&nbsp;<%=menulist %>&nbsp;>&nbsp;<%=flaglist %>
					<p>
				</div>
				<div>
					<!-- 상세보기 -->
					<form action="" name="">
						<table class="table table-bordered">
							<colgroup>
								<col width="20%" />
								<col width="30%" />
								<col width="20%" />
								<col width="*" />
							</colgroup>
							<tbody>
								<th class="text-center" style="vertical-align: middle;">날짜</th>
								<td colspan="3"><%=year %>. <%=month %>. <%=day %></td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">일정</th>
									<%if(dto.getContent()!=null) {%>
									<td colspan="3" style="height:200px; vertical-align: middle;">
										<%=dto.getContent() %></td>
									<%}else {%>
									<td colspan="3" style="height:200px; vertical-align: middle;">
										일정이 없습니다.</td>
									<%}%>
								</tr>
							</tbody>
						</table>
						
						<button>
							<a href="calList.jsp">리스트보기</a>
						</button>
						
					</form>
				</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>
		<%@ include file="../include/footer.jsp"%>
</center>
</body>
</html>
