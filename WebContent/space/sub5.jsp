<%@page import="survlet.list_ctrl"%>
<%@page import="util.PagingUtil"%>
<%@page import="multi.BbsDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="multi.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
  <title>사진 게시판</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<%
String flag = request.getParameter("flag");
String menu =request.getParameter("menu");
// String flag = "04";
// String menu = "space";
%>
<!-- 사진게시판 -->
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
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판</p>	
				</div>
			</div>
			
						<!-- 게시판 메뉴 -->
	<div class="row text-right" style="margin-bottom:20px;padding-right:0px;">

	
	<!-- 검색 -->

<form class="form-inline ml-auto">	
	<input type="hidden" name="menu" value="<%=menu %>" />
	<input type="hidden" name="flag" value="<%=flag%>"/>
	<div class="form-group">
		<select name="searchColumn" class="form-control">
			<option value="title"
			 <%=(request.getParameter("searchColumn")!=null && request.getParameter("searchColumn").equals("title")) ?
					 "selected":"" %>>제목</option>
			<option value="name"
			<%=(request.getParameter("searchColumn")!=null && request.getParameter("searchColumn").equals("name")) ?
					"selected":"" %>>작성자</option>
			<option value="content"
			 <%=(request.getParameter("searchColumn")!=null && request.getParameter("searchColumn").equals("content")) ?
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
	<br /><br /><br />
	<div class="container">
  <table class="table table-bordered table-hover" style="text-align: center;">
<!--   	<colgroup width="50px"> -->
<!--   		<col width="50px"/> -->
<!--   	</colgroup > -->
<!--   	<colgroup width="50px"> -->
<!--   		<col width="50px"/> -->
<!--   	</colgroup> -->
<!--   	<colgroup width="50px"> -->
<!--   		<col width="50px"/> -->
<!--   	</colgroup> -->
<!--     <thead class="thead-dark"> -->
<!--       <tr style="width: 50px"> -->
<!--         <th colspan="2" style="height: 200px; width: 50px">사진</th> -->
<!--       </tr> -->
<!--     </thead> -->
	<c:choose>
		<c:when test="${empty lists }">
				<tr>
					<td colspan="4" align="center" height="100">
						등록된 게시물이 없습니다.
					</td>
				</tr>
		</c:when>
		<c:otherwise>
			<c:forEach items="${lists }" var="row" varStatus="loop">
	    <tr>
	        <td>제목</td>
	        <td colspan="3">
				<!-- 파라미터로 넘어오는것 : 쿼리스트링 형태 -->
				<!-- nowPage -> param.(PagindUtil.java)에서 map.(ListCtrl.java)으로 변경 -->
				<a href="../space/sub04_view?menu=${map.menu }&flag=${row.flag }&nowPage=${map.nowPage}&num=${row.num }&nowPage=${map.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}">
					${row.title }
				</a>	        </td>
	    </tr>
	    <tr>
	    	<td>번호</td>
	      	<td>
				${map.totalCount - (((map.nowPage-1)*map.pageSize) + loop.index) }
	      	</td>
	      	<td>아이디</td>
	      	<td>${row.id }</td>
	    </tr>
	    <tr style="width: 50px">
	        <th colspan="4" style="height: 200px; width: 50px">
	        	<img src="" alt="" />
	        </th>
	    </tr>
	    <tr>
	        <td colspan="4">
			<c:if test="${not empty row.attachedfile }">
			<a href="./Download?filename=${row.attachedfile }&num=${row.num}">
				<img src="../images/disk.png" width="20" alt="" />	        
			</c:if>
			</td>
	    </tr>
	    <tr>
	</c:forEach>
	</c:otherwise>
</c:choose>
    </tbody>
  </table>

<div class="row text-right" style="padding-right:50px;">
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
		
	<button type="button" class="btn btn-dark ml-auto" 
		onclick="location.href='sub04_write.jsp?menu=${map.menu }&flag=${map.flag }&nowPage=${map.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}';">글쓰기</button>
</div>
<div class="row text-center">
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
