<%@page import="multi.MemberDTO"%>
<%@page import="multi.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

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
		
		
		<!-- ### 게시판의 body 부분 start ### -->
		
		<c:choose>
			<c:when test="${param.mode eq 'edit' }">
				<c:set var='modeView' value='수정을'/>
			</c:when>
			<c:otherwise>
				<c:set var='modeView' value='삭제를'/>
			</c:otherwise>
		</c:choose>
		
			<h3>자료실 - <small>${modeView } 위한 패스워드 검증</small></h3>
			
<script>
	function checkValidate(fm){
		if(fm.pass.value==""){
			alert("비밀번호를 입력하세요."); 
			fm.pass.focus(); 
			return false;
		}
	}
</script>

<div class="row mt-3 mr-1">
	<table class="table table-bordered table-striped">
	<!-- action부분 확인하기 -->
	<form name="writeFrm" method="post" action="../space/sub04_Password" enctype="multipart/form-data"
		onsubmit="return checkValidate(this);" >
	
		<!-- 패스워드 검증을 위해 idx, mode는 웹서버로 전송되어야 하므로
			hidden폼에 값을 저장해야한다. -->
		<input type="hid-den" name="idx" value="${param.id }" />
		<input type="hid-den" name="mode" value="${param.mode }" />
		
	<colgroup>
		<col width="20%"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th class="text-center" 
				style="vertical-align:middle;">패스워드</th>
			<td>
				<input type="password" class="form-control" name="pass" style="width:200px;"/>
			</td>
		</tr>
	</tbody>
	</table>
</div>
<div class="row mb-3">
	<div class="col text-right">		
		<button type="submit" class="btn btn-danger">전송하기</button>
		<button type="reset" class="btn btn-dark">Reset</button>
		<button type="button" class="btn btn-warning" 
			onclick="location.href='../space/sub04.jsp?nowPage=${param.nowPage}&searchColum=${param.searchColumn}&searchWord=${param.searchWord}';">리스트보기</button>
	</div>
	
	</form>
</div> 	
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