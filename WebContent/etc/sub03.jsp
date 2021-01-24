<%@page import="util.PagingUtil"%>
<%@page import="multi.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="multi.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>


<!-- 자유게시판 -->
<%
	request.setCharacterEncoding("UTF-8");

BbsDAO dao = new BbsDAO(application);
Map<String, Object> param = new HashMap<String, Object>();

String queryStr = "";

String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");

if (searchWord != null) {
	//Map에 파라미터 담기
	param.put("column", searchColumn);
	param.put("word", searchWord);
	//쿼리스트링 생성
	queryStr += "searchClumn=" + searchColumn + "&searchWord=" + searchWord;
}
//전체 레코드 갯수
int totalRecordCount = dao.getTotalRecordCountSearch(param);

//페이지 처리
int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));

int totalPage = (int) Math.ceil((double) totalRecordCount / pageSize);

int nowPage = (request.getParameter("nowPage") == null || request.getParameter("nowPage").equals("")) ? 1
		: Integer.parseInt(request.getParameter("nowPage"));

int start = (nowPage - 1) * pageSize;
int end = pageSize;

param.put("start", start);
param.put("end", end);

//페이지처리+회원이름검색
List<BbsDTO> bbs = dao.selectListPageSearch(param);
//자원해제
dao.close();
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!--  <body> -->
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
				</div>
				<div>

<div class="row text-right" style="margin-bottom:20px;
		padding-right:50px;">
<!-- 검색부분 -->
<form class="form-inline">	
	<div class="form-group">
		<select name="keyField" class="form-control">
		<!-- searchColumn!=null 이부분 왜 필요한지 이해가 안되네 ? ★★★★★★★★★★★★★★ -->
			<option value="title"
			 <%=(searchColumn!=null && searchColumn.equals("title")) ?
					 "selected":"" %>>제목</option>
			<option value="name"
			<%=(searchColumn!=null && searchColumn.equals("name")) ? 
					"selected":"" %>>작성자</option>
			<option value="content"
			<%=(searchColumn!=null && searchColumn.equals("content")) ?
					"selected":"" %>>내용</option>
		</select>
	</div>
	<div class="input-group">
		<input type="text" name="keyString"  class="form-control"/>
		<div class="input-group-btn">
			<button type="submit" class="btn btn-default">
				<i class="glyphicon glyphicon-search"></i>
			</button>
		</div>
	</div>
</form>	
</div>
<div class="row">
	<!-- 게시판리스트부분 -->
	<table class="table table-bordered table-hover">
	<colgroup>
		<col width="80px"/>
		<col width="*"/>
		<col width="120px"/>
		<col width="120px"/>
		<col width="80px"/>
		<col width="50px"/>
	</colgroup>
	
	<thead>
	<tr class="success">
		<th class="text-center">번호</th>
		<th class="text-left">제목</th>
		<th class="text-center">작성자</th>
		<th class="text-center">작성일</th>
		<th class="text-center">조회수</th>
		<th class="text-center">첨부</th>
	</tr>
	</thead>
	
	<!-- 리스트반복 -->
	<tbody>
	<!-- 게시물이 없을때 -->
	<% if(bbs.isEmpty()){%>
		<tr>
			<td colspan="6" align="center" height="100">
				등록된 게시물이 없습니다.
			</td>
		</tr>
	
	<%}
	//게시물이 있을때
	else{
		int vNum = 0;
		int countNum = 0;
		
		for(BbsDTO dto : bbs){
			vNum = totalRecordCount - (((nowPage-1)*pageSize)+countNum++);
	%>
		<tr>
			<td class="text-center"><%=vNum %></td><!-- 번호 -->
			<td class="text-left"><a href="sub01_view.jsp?num=<%=dto.getNum()%>&nowPage=<%=nowPage%>&<%=queryStr%>">
			<%=dto.getTitle() %></a></td> <!-- 제목 -->
			<td class="text-center"><%=dto.getName() %></td><!-- 작성자 -->
			<td class="text-center"><%=dto.getPostdate() %></td><!-- 작성일 -->
			<td class="text-center"><%=dto.getVisitcount() %></td><!-- 조회수 -->
			<td class="text-center"><%=dto.getAttachedfile() %></td><!-- 첨부 -->
		</tr>
		
	<%
		}
	} %>
	</tbody>
	</table>
</div>
<div class="row text-right" style="padding-right:50px;">
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
		
	<button type="button" class="btn btn-default" 
		onclick="location.href='sub01_write.jsp';">글쓰기</button>
				
	<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
	<button type="submit" class="btn btn-danger">전송하기</button> -->
</div>
<div class="row text-center">
	<!-- 페이지번호 부분 -->
	<ul class="pagination">
	
		<%=PagingUtil.pagingBS4(totalRecordCount,
		pageSize, 
		blockPage, 
		nowPage,
		"sub03.jsp?"+queryStr) %>

<!-- 		<li><span class="glyphicon glyphicon-fast-backward"></span></li> -->
<!-- 		<li><a href="#">1</a></li>		 -->
<!-- 		<li class="active"><a href="#">2</a></li> -->
<!-- 		<li><a href="#">3</a></li> -->
<!-- 		<li><a href="#">4</a></li>		 -->
<!-- 		<li><a href="#">5</a></li> -->
<!-- 		<li><span class="glyphicon glyphicon-fast-forward"></span></li> -->
	</ul>	
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