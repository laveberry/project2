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
<!-- MODEL2방식 서블릿 , 이미지 게시판-->
<head>
<title>사진 게시판(MODEL2 방식)</title>
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
String flag = request.getParameter("flag");
String menu = request.getParameter("menu");
String nowPage =request.getParameter("nowPage");
%>
<!-- <body> -->
<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>
		<img src="../images/space/sub_image.jpg" id="main_visual" />
		<div class="contents_box">
			<div class="left_contents">
				<%@ include file="../include/space_leftmenu.jsp"%>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location">
						<img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판
					</p>
				</div>
			</div>

			<!-- 게시판 메뉴 -->
			<div class="row text-right"
				style="margin-bottom: 20px; padding-right: 0px;">

				<!-- 검색 -->
				<form class="form-inline ml-auto">
					<input type="hidden" name="menu" value="<%=menu%>" /> <input
						type="hidden" name="flag" value="<%=flag%>" />
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
						<input type="text" name="searchWord" class="form-control" />
						<div class="input-group-btn">
							<button type="submit" class="btn btn-default">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
					</div>
				</form>
				<br /><br /><br />
				<div class="container">
					<table class="table table-bordered table-hover"
						style="text-align: center;">
						<c:choose>
							<c:when test="${empty lists }">
								<tr>
									<td colspan="4" align="center" height="100">등록된 게시물이 없습니다.
									</td>
								</tr>
							</c:when>
							<c:otherwise>

								<!-- 게시물이 있을경우 -->
								<c:set var="i" value="0" />
								<c:set var="j" value="3" />
								<!-- 가로 반복을위한 값 셋팅후 테이블 생성 -->
								<table border='1' style="text-align: center;">
									<c:forEach items="${lists }" var="row" varStatus="loop">
										<c:if test="${i%j == 0 }">
											<tr>
										</c:if>
										<td style="width: 250px; padding: 10px; padding-top: 1px;">
											<div class="card" style="height: 200px;">
												<!-- nowPage -> param.(PagindUtil.java)에서 map.(ListCtrl.java)으로 변경 -->
												<span>번호 : ${map.totalCount - (((map.nowPage-1)*map.pageSize) + loop.index) }
													작성자 : ${row.name }</span> <a class=card-title
													href="../space/sub04_view.jsp?${addQueryString }&num=${row.num}&nowPage=${nowPage}">
													<b>${row.title }</b>
												</a>

												<div class="card-body">
													<a class=card-title
														href="../space/sub04_view.jsp?${addQueryString }&num=${row.num}&nowPage=${nowPage}">
														<img src="../Upload/${row.attachedfile }" alt="이미지"
														style="height: 100%; width: 100%" />
													</a>

												</div>
											</div>
										</td>
										<c:if test="${i%j==j-1 }">
											</tr>
										</c:if>
										<c:set var="i" value="${i+1 }" />
									</c:forEach>
								</table>
							</c:otherwise>
						</c:choose>
						</tbody>
								${map.test }
					<div class="row mt-3">
						<div class="col">
							<!-- 페이지번호 부분 -->
							<ul class='pagination justify-content-center'>
								${map.pagingImg }
							</ul>
						</div>
					</div>
						
					</table>
					<div class="row text-right" style="padding-right: 50px;">
						<button type="button" class="btn btn-dark ml-auto"
							onclick="location.href='../space/photoCtrl?menu=space&flag=04';">글쓰기</button>
					</div>

				</div>
				<%@ include file="../include/quick.jsp"%>
			</div>
			<%@ include file="../include/footer.jsp"%>
</div>
</center>
</body>
</html>
