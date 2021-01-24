<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
<%@page import="multi.MemberDTO"%>
<%@page import="multi.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<%
String flag = request.getParameter("flag");
int num = Integer.parseInt(request.getParameter("num"));
// 상단메뉴구분
String menu = "";
switch(flag){
	case "01":case"02":case"03":case"04":case"05":
		menu = "space";break;
	case "06":case"07":
		menu = "community";break;
}
String leftMenu = "../include/"+menu+"_leftmenu.jsp"; 

BbsDTO dto = new BbsDTO();
BbsDAO dao = new BbsDAO();

dto = dao.selectView(flag, num);
%>
 <body>
<!-- 	<center> -->
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/${menu}/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<jsp:include page="<%=leftMenu %>"/> 
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/${menu}/sub<%=flag %>_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
				<div>

<form enctype="multipart/form-data" action="../space/photoCtrl">
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<input type="hidden" name="style" value="view" />
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">아이디</th>
		<td>
			<%=dto.getId() %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>
			<%=dto.getPostdate() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
			<%=dto.getName() %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>
			<%=dto.getVisitcount() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			<%=dto.getTitle() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">사진</th>
		<td colspan="3">
			<!-- 첨부파일 이미지경로 넣기 -->
			<img src="" alt="" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			<%=dto.getContent() %>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
			<c:if test="${not empty dto.attachedfile }">
				${dto.attachedfile }
				<a href="./Download?filename=${dto.attachedfile }&flag=${dto.flag }&num=${dto.num}"></a>
			</c:if>
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
<%if(session.getAttribute("USER_ID")==dto.getId()){ %>
	<!-- param.num과 dto.num 구분하기 ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★ -->
	<button type="button" class="btn btn-primary"
		onclick="location.href='sub<%=flag%>_Password.jsp?num=${param.num}&mode=edit&nowPage=${param.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">
		수정하기</button>
	<button type="button" class="btn btn-success"
			onclick="location.href='../${menu}/sub<%=flag%>_Password.jsp?id=${param.id}&mode=delete&nowPage=${param.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">
	삭제하기</button>	
<%} %>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='sub<%=flag%>.jsp?menu=${menu}&flag=${param.flag }&nowPage=${param.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">
		리스트보기</button>
</div>
</form> 
				</div>
			</div>
			<!-- BODY END -->
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>