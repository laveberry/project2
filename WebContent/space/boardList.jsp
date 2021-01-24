<%@page import="multi.MemberDTO"%>
<%@page import="multi.MemberDAO"%>
<%@page import="util.PagingUtil"%>
<%@page import="multi.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="multi.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- //////MODEL1방식/////// -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
  <title>통합 게시판 컨트롤(MODEL1 방식)</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<%@ include file="../include/global_head.jsp"%>

<%
request.setCharacterEncoding("UTF-8");

BbsDAO dao = new BbsDAO();
Map<String, Object> param = new HashMap<String, Object>();


//menu별 구분 처리
String menu = request.getParameter("menu");
System.out.println("menu="+menu);
String menulist ="";
switch(menu){
	case "space": menulist="열린공간"; break;
	case "community" : menulist="커뮤니티"; break;
}

//flag에 따른 게시판 이름 구분 처리
String flag = request.getParameter("flag");
System.out.println("보드리스트flag="+flag);
String flaglist = "";
switch(flag){
	case "01": flaglist = "공지사항"; break;
	case "02": flaglist = "프로그램일정"; break;
	case "03": flaglist = "자유게시판"; break;
	case "04": flaglist = "사진게시판"; break;
	case "05": flaglist = "정보자료실"; break;
	case "06": flaglist = "직원자료실"; break;
	case "07": flaglist = "보호자게시판"; break;
}

//메뉴 및 게시판 종류 구분param에 담기
param.put("menu", menu);
param.put("flag", flag);

String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
//뒤에 "&" 붙여주어야 오류가 안난다.
String queryStr = "menu="+menu+"&flag="+flag +"&";

if (searchWord != null) {
	//Map에 파라미터 담기
	param.put("column", searchColumn);
	param.put("word", searchWord);
	//쿼리스트링 생성
	queryStr += "searchClumn=" + searchColumn + "&searchWord=" + searchWord +"&";
}
//전체 레코드 갯수
int totalRecordCount = dao.getTotalRecordCountSearch(param);

//페이지 처리
int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));
int totalPage = (int) Math.ceil((double) totalRecordCount / pageSize);
//현재페이지 처리
int nowPage = (request.getParameter("nowPage") == null || request.getParameter("nowPage").equals("")) ? 1
		: Integer.parseInt(request.getParameter("nowPage"));
//마리아DB용 계산식
int start = (nowPage - 1) * pageSize;
int end = pageSize;

param.put("start", start); 
param.put("end", end);

//페이지처리+회원이름검색 리스트불러오기
List<BbsDTO> bbs = dao.selectListPageSearch(param);
//자원해제
dao.close();
%>
<body>
	<center>  
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
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
				<jsp:include page="<%=leftMenu %>"/> 
				
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/<%=menu %>/sub<%=flag %>_title.gif" alt="게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;<%=menulist %>&nbsp;>&nbsp;<%=flaglist %>
					<p>
				</div>
				</div>

<div class="row text-right" style="margin-bottom:20px; padding-right:50px;">
		
<!-- 검색부분 -->
<form class="form-inline ml-auto">	
	<div class="form-group">
		<select name="searchColumn" class="form-control">
		<!-- searchColumn!=null 이 없다면 null예외 발생됨! -->
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
		<input type="text" name="searchWord"  class="form-control"/>
		<div class="input-group-btn">
			<button type="submit" class="btn btn-default">
				<i class="glyphicon glyphicon-search"></i>
			</button>
		<input type="hidden" name="flag" value="<%=flag%>"/>
		<input type="hidden" name="menu" value="<%=menu%>"/>
			
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
	<tr class="thead-dark">
		<th class="text-center">번호</th>
		<th class="text-center">제목</th>
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
			<td class="text-left"><a href="board_view.jsp?<%=queryStr%>&num=<%=dto.getNum()%>&nowPage=<%=nowPage%>&">
			<%=dto.getTitle() %></a></td> <!-- 제목 -->
			<td class="text-center"><%=dto.getName() %></td><!-- 작성자 -->
			<td class="text-center"><%=dto.getPostdate() %></td><!-- 작성일 -->
			<td class="text-center"><%=dto.getVisitcount() %></td><!-- 조회수 -->
			<td class="text-center"><%=(dto.getAttachedfile()!=null) ? dto.getAttachedfile() : "" %></td><!-- 첨부 -->
		</tr>
	<%}
	}%>
	</tbody>
	</table>

	<%
	if(flag!=null && flag.equals("01")) {
// 	if(flag.equals("01")) {
		//권한부여를 위해 로그인 정보 불러오기
		if(session.getAttribute("USER_ID")!=null && session.getAttribute("USER_ID")!=""){
		String user = session.getAttribute("USER_ID").toString();
			MemberDAO mdao = new MemberDAO();
			MemberDTO mdto = mdao.getMember(user);
			if(mdto.getGrade()!=null && mdto.getGrade().equals("02")){
// 			if(mdto.getGrade().equals("02")){
	%>
		<!-- 글쓰기 위치 정렬을위한 div태그 및 ml-auto-->
		<div class="row text-right ml-auto" style="float:right;">
			<button type="button" class="btn btn-dark ml-auto" style="height: 30px; "
						onclick="location.href='board_write.jsp?menu=<%=menu%>&flag=<%=flag%>';">글쓰기</button>
		</div>
	<% 
			}
		}
	}
	else{
	%>	
		<div class="row text-right ml-auto" style="padding-right: 50px; float:right;">
			<button type="button" style="height: 30px;" class="btn btn-dark ml-auto" 
				onclick="location.href='board_write.jsp?menu=<%=menu%>&flag=<%=flag%>';">글쓰기</button>
		</div>
	<%
	}
	%>
	</div>
	<div class="row mt-3">
		<div class="col">
		<!-- 페이지번호 처리 -->
		<!-- justify-content-center : 가운데 정렬 -->
		<ul class="pagination justify-content=center">
			<%=PagingUtil.pagingBS4(totalRecordCount, pageSize, blockPage, nowPage,
				"boardList.jsp?"+queryStr) %>
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