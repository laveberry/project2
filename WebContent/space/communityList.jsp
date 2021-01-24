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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- //////MODEL1방식/////// -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
  <title>(MODEL2)서블릿 커뮤니티 게시판</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<%@ include file="../include/global_head.jsp"%>

<center>  
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>
		<img src="../images/${menu }/sub_image.jpg" id="main_visual" />  
		<div class="contents_box">
			<div class="left_contents">
			
				<jsp:include page="${leftMenu }"/> 
				
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/${menu }/sub${flag }_title.gif" alt="게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;${menulist }&nbsp;>&nbsp;<${flaglist }
					<p>
				</div>
				</div>

<div class="row text-right" style="margin-bottom:20px; padding-right:50px;">
		
	<!-- 검색 -->
	<form class="form-inline ml-auto">
		<input type="hidden" name="menu" value="${menu }" /> <input
			type="hidden" name="flag" value="${flag }" />
		<div class="form-group">
			<select name="searchColumn" class="form-control">
				<option value="title"<%=(request.getParameter("searchColumn") != null &&
						request.getParameter("searchColumn").equals("title")) ? "selected" : ""%>>제목</option>
				<option value="name"<%=(request.getParameter("searchColumn") != null &&
					request.getParameter("searchColumn").equals("name")) ? "selected" : ""%>>작성자</option>
				<option value="content"<%=(request.getParameter("searchColumn") != null &&
					request.getParameter("searchColumn").equals("content")) ? "selected" : ""%>>내용</option>
			</select>
		</div>
	<div class="input-group">
		<input type="text" name="searchWord"  class="form-control"/>
		<div class="input-group-btn">
			<button type="submit" class="btn btn-default">
				<i class="glyphicon glyphicon-search"></i>
			</button>
			
<%-- 		<input type="hidden" name="flag" value="${param.flag }"/> --%>
<%-- 		<input type="hidden" name="menu" value="${param.menu }"/> --%>
			
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
	<c:choose>
		<c:when test="${empty lists }">

		<tr>
			<td colspan="6" align="center" height="100">
				등록된 게시물이 없습니다.
			</td>
		</tr>
		</c:when>
		<c:otherwise>
		<!-- 게시물이 있을때 -->
		<c:forEach items="${lists }" var="row" varStatus="loop">
		<tr>
			<td class="text-center">${map.totalCount - (((map.nowPage-1)*map.pageSize) + loop.index) }</td><!-- 번호 -->
			<td class="text-left"><a href="../space/view_ctrl?${addQueryString }num=${row.num }&nowPage=${nowPage }&">
			${row.title }</a></td> <!-- 제목 -->
			<td class="text-center">${row.name }</td><!-- 작성자 -->
			<td class="text-center">${row.postdate }</td><!-- 작성일 -->
			<td class="text-center">${row.visitcount }</td><!-- 조회수 -->
			<td class="text-center">
			<c:if test="${not empty row.attachedfile }">
                <a href="../space/download_ctrl?attachedfile=${row.attachedfile }&num=${row.num}">
				<i class="material-icons" style="font-size:20px">attach_file</i>
                </a>
			</c:if>
			</td><!-- 첨부 -->
		</tr>
		</c:forEach>
		<!-- /테이블 -->
	</c:otherwise>
	</c:choose>
	</tbody>
	</table>
	
	<!-- 이거 없애야 가운데 정렬된다! -->
<!-- 	<div class="row text-center justify-content-center " style="padding-right:50px;"> -->
	<c:choose>
		<c:when test="${flag eq '06' }">
			<c:if test="${grade eq '02' }">
				<div class="row text-right ml-auto" style="float:right;">
					<button type="button" class="btn btn-dark ml-auto" style="height: 30px; color: white;">
						<a href="../space/photoCtrl?menu=${menu }&flag=${flag }">
						글쓰기
						</a>
					</button>
				</div>
			</c:if>
		</c:when>
		<c:otherwise>
<!-- 			<div class="row text-right ml-auto" style="float:right;"> -->
				<button type="button" class="btn btn-dark ml-auto" style="height: 30px; color: white;">
					<a href="../space/photoCtrl?menu=${menu }&flag=${flag }">
					글쓰기
					</a>
				</button>
<!-- 			</div> -->
		</c:otherwise>
	</c:choose>
</div>
	<div class="row mt-3">
		<div class="col">
			<!-- 페이지번호 부분 -->
			<ul class='pagination justify-content-center'>
				${map.pagingImg }
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