<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
<%@page import="multi.MemberDTO"%>
<%@page import="multi.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	<input type="hidden" name="downcount" value="${dto.downcount }" />
	<input type="hidden" name="num" value="${dto.num }" />
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">아이디</th>
		<td>
			<!-- requset영역에 저장된 dto값 -->
			${dto.id }
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>
			${dto.postdate }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
			${dto.name }
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>
			${dto.visitcount }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			${dto.title }
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">사진</th>
		<td colspan="3">
			<!-- 첨부파일 이미지경로 넣기 -->
			<img src="../Upload/${dto.attachedfile } %>" style="width: 100%;"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			${dto.content }
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
			<c:if test="${not empty dto.attachedfile }">
				${dto.attachedfile }
				파일이름 : ${dto.attachedfile } &nbsp;&nbsp; |  다운로드횟수 : ${dto.downcount } <br />
<!-- 				<a href="../space/download_ctrl">다운로드</a> -->
                    <a href="../space/download_ctrl?attachedfile=${dto.attachedfile }&num=${dto.num}">
                        [다운로드]
                    </a>
			</c:if>
		</td>
	</tr>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	<c:if test="${not empty sessionScope.USER_ID and sessionScope.USER_ID eq dto.id}">
<%-- <%if(session.getAttribute("USER_ID")!=null || session.getAttribute("USER_ID")==${dto.id}){ %> --%>

	<button type="button" class="btn btn-primary"
		onclick="location.href='../space/edit_ctrl?${queryStr}';">
		수정하기</button>
	<button type="button" class="btn btn-success"
			onclick="location.href='../space/sub04_Password.jsp?${queryStr}">
	삭제하기</button>	
</c:if>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='../space/list_ctrl?menu=space&flag=04&nowPage=${nowPage };">
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