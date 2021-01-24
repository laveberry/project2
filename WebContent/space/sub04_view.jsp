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
// int nowPage = Integer.parseInt(request.getParameter("nowPage"));
String nowPage = request.getParameter("nowPage");

System.out.println("04뷰nowPage="+nowPage);
// 상단메뉴구분
String menu = "";
switch(flag){
	case "01":case"02":case"03":case"04":case"05":
		menu = "space";break;
	case "06":case"07":
		menu = "community";break;
}

String queryStr = "menu="+menu+"&flag="+flag+"&num="+num+"&nowPage="+nowPage;


BbsDTO dto = new BbsDTO();
BbsDAO dao = new BbsDAO();

dto = dao.selectView(flag, num);
%>
 <body>
<!-- 	<center> -->
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
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
	<input type="hidden" name="downcount" value="<%=dto.getDowncount() %>" />
	<input type="hidden" name="num" value="<%=dto.getNum() %>" />
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
			<img src="../Upload/<%=dto.getAttachedfile() %>" style="width: 100%;"/>
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
			style="vertical-align:middle;">첨부파일 </th>
		<td colspan="3">
			<% 
			System.out.println("뷰 첨부파일"+dto.getAttachedfile());
			if(dto.getAttachedfile()!=null){%>
<%-- 			<c:if test="${not empty dto.attachedfile }"> --%>
<%-- 				${dto.attachedfile } --%>
				파일이름 : <%=dto.getAttachedfile()%> &nbsp;&nbsp; |  다운로드횟수 : <%=dto.getDowncount() %> <br />
<!-- 				<a href="../space/download_ctrl">다운로드</a> -->
                    <a href="../space/download_ctrl?attachedfile=<%=dto.getAttachedfile()%>&num=<%=dto.getNum()%>">
                        [다운로드]
                    </a>
				
<!-- 			</c:if> -->
			<%} %>
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
<%if(session.getAttribute("USER_ID")!=null || session.getAttribute("USER_ID")==dto.getId()){ %>

	<!-- queryStr EL식으로 넘겨주면 안넘어간다!!!! -->
	<button type="button" class="btn btn-primary"
		onclick="location.href='../space/edit_ctrl?<%=queryStr%>';">
		수정하기</button>
		<!-- 이게 왜 작동되는거지?????삭제하기 -->
	<button type="button" class="btn btn-success"
			onclick="location.href='../space/sub04_Password.jsp?id=${param.id}&mode=delete&nowPage=${param.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">
	삭제하기</button>	
<%} %>
	<!-- 왜자꾸 nowPage값이 null로 나오지?????? -->
	<button type="button" class="btn btn-warning">
		<a href="../space/list_ctrl?menu=space&flag=04&nowPage=<%=nowPage%>">리스트보기</a>
	</button>
<!-- 		onclick="location.href='../space/list_ctrl?menu=space&flag=04;"> -->
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