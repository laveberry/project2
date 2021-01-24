<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
<%@page import="multi.MemberDTO"%>
<%@page import="multi.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<body>
	<!-- 	<center> -->
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>

		<img src="../images/${menu }/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<jsp:include page="${leftmenu }" />
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/${menu }/sub${flag }_title.gif" alt=""
						class="con_title" />
					<p class="location">
						<img src="../images/center/house.gif" />&nbsp;&nbsp;${menulist }&nbsp;>&nbsp;${flaglist }
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
								<input type="hidden" name="menu" value="${param.menu }" />
								<input type="hidden" name="flag" value="${param.flag }" />
								<input type="hidden" name="num" value="${dto.num }" />
								<tr>
									<th class="text-center" style="vertical-align: middle;">아이디</th>
									<td>${dto.id }</td>
									<th class="text-center" style="vertical-align: middle;">작성일</th>
									<td>${dto.postdate }</td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">작성자</th>
									<td>${dto.name }</td>
									<th class="text-center" style="vertical-align: middle;">조회수</th>
									<td>${dto.visitcount }</td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">제목</th>
									<td colspan="3">${dto.title }</td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">내용</th>
									<td colspan="3">
   										${dto.content }
									</td>
								</tr>
								<tr>
									<th class="text-center" style="vertical-align: middle;">첨부파일</th>
									<td colspan="3">
										<c:if test="${not empty dto.attachedfile }">
											${dto.attachedfile }
											<a href="./Download?filename=${dto.attachedfile }&flag=${dto.flag }&num=${dto.num}"></a>
										</c:if>
									</td>
								</tr>
							</tbody>
						</table>
						</form>
						<div class="row text-center" style="">
							<!-- 각종 버튼 부분 -->
							<c:if test="${sessionScope.USER_ID eq dto.id }">
							<button type="button" class="btn btn-primary">
								<a href="../space/edit_ctrl?${queryStr }&num=${dto.num}">
								수정하기
								</a>
								</button>
							<button type="button" class="btn btn-success"
								onclick="isDelete()">
								삭제하기</button>
							
							</c:if>
							<script>
								function isDelete(){
									var c = confirm("삭제할까요?");
									if(c){
										var f = document.deleteFrm;
										f.method = "post";
										f.action = "../space/delete_ctrl"
										f.submit();
									}
								}
							</script>
							<button type="button" class="btn btn-warning">
								<a href="../space/list_ctrl?${queryStr }">리스트보기</a>
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