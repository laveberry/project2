<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
<%@page import="multi.MemberDTO"%>
<%@page import="multi.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>

<%
int num = Integer.parseInt(request.getParameter("num"));
// String menu = request.getParameter("menu");
String flag = request.getParameter("flag");
String flaglist = "";
switch (flag) {
case "01": flaglist = "공지사항"; break;
case "02": flaglist = "프로그램일정"; break;
case "03": flaglist = "자유게시판"; break;
case "04": flaglist = "사진게시판"; break;
case "05": flaglist = "정보자료실"; break;
case "06": flaglist = "직원자료실"; break;
case "07": flaglist = "보호자게시판"; break;
}
String menu = "";
// 상단메뉴구분
switch (flag) {
case "01":case "02":case "03":case "04":case "05":
	menu = "space";break;
case "06":case "07":
	menu = "community";break;
}
String menulist ="";
switch(menu){
case "space": menulist="열린공간"; break;
case "community" : menulist="커뮤니티"; break;
}
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
String queryStr = "menu=" + menu + "&flag=" + flag;
if (searchWord != null) {
	queryStr += "searchColumn=" + searchColumn + "&searchWord=" + searchWord;
}
//2페이지에서 상세보기 했다면 리스트로 돌아갈때도 페이지가 유지되어야 한다.
String nowPage = request.getParameter("nowPage");
queryStr += "&nowPage=" + nowPage;

String leftMenu = "../include/" + menu + "_leftmenu.jsp";

BbsDTO dto = new BbsDTO();
BbsDAO dao = new BbsDAO();
//게시물 불러오기
dao.updateVisitCount(num, flag);
dto = dao.selectView(flag, num);
dao.close();
%>
<body>
	<!-- 	<center> -->
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>

		<img src="../images/<%=menu%>/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<jsp:include page="<%=leftMenu%>" />
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/<%=menu%>/sub<%=flag%>_title.gif" alt="사진게시판"
						class="con_title" />
					<p class="location">
						<img src="../images/center/house.gif" />&nbsp;&nbsp;<%=menulist%>&nbsp;>&nbsp;<%=flaglist%>
					<p>
				</div>
				<div>

					<form action="delete_Proc.jsp" name="deleteFrm">
						<table class="table table-bordered">
							<colgroup>
								<col width="20%" />
								<col width="30%" />
								<col width="20%" />
								<col width="*" />
							</colgroup>
							<tbody>
								<input type="hidden" name="menu" value="<%=menu %>" />
								<input type="hidden" name="flag" value="<%=flag%>" />
								<input type="hidden" name="num" value="<%=num%>" />
<%-- 								<input type="hidden" name="num" value="<%=dto.getNum() %>" /> --%>

								<tr>
									<th class="text-center" style="vertical-align: middle;">아이디</th>
									<td><%=dto.getId()%></td>
									<th class="text-center" style="vertical-align: middle;">작성일</th>
									<td><%=dto.getPostdate()%></td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">작성자</th>
									<td><%=dto.getName()%></td>
									<th class="text-center" style="vertical-align: middle;">조회수</th>
									<td><%=dto.getVisitcount()%></td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">제목</th>
									<td colspan="3"><%=dto.getTitle()%></td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">내용</th>
									<td colspan="3">
   										<%=dto.getContent().replace("\r\n","<br/>") %>
									</td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">첨부파일</th>
									<td colspan="3">
										<%if(dto.getAttachedfile()!=null) {%> 
											<%=dto.getAttachedfile() %>
<%-- 										<c:if test="${not empty dto.attachedfile }"> --%>
<%-- 											${dto.attachedfile } --%>
											<a href="./Download?filename=${dto.attachedfile }&flag=${dto.flag }&num=${dto.num}"></a>
<!-- 										</c:if></td> -->
										<%} %>
								</tr>
							</tbody>
						</table>
						</form>
						<div class="row text-center" style="">
							<!-- 각종 버튼 부분 -->
							<%
							//null발생하지않게 조건 체크해주기
							if(session.getAttribute("USER_ID")!=null){
								if (session.getAttribute("USER_ID").equals(dto.getId())) {
							%>
							<button type="button" class="btn btn-primary"
								onclick="location.href='board_edit.jsp?<%=queryStr%>&num=<%=num %>'">
<%-- 								onclick="location.href='board_edit?<%=queryStr%>';"> --%>
								수정하기</button>
							<button type="button" class="btn btn-success"
								onclick="isDelete()">
								삭제하기</button>
							
							<%
								}
							}
							%>

							<script>
								function isDelete(){
									var c = confirm("삭제할까요?");
									if(c){
										var f = document.deleteFrm;
										f.method = "post";
										f.action = "delete_Proc.jsp"
										f.submit();
									}
								}
							</script>
							<button type="button" class="btn btn-warning">
							<!-- 이거 실수로 내가 고쳐버림...다시보고정리하기 ㅠ -->
								<a href="boardList.jsp?<%=queryStr %>">리스트보기</a>
							</button>
						</div>

				</div>
			</div>
			<!-- BODY END -->
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>


	<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>