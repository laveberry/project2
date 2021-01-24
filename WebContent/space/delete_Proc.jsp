<%@page import="util.FileUtil"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="util.JavascriptUtil"%>
<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--delete_Proc.jsp--%>
<%@ include file="../include/isLogin.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

System.out.println("삭제하기 Proc 시작");

BbsDTO dto = new BbsDTO();
BbsDAO dao = new BbsDAO();
// MultipartRequest req = FileUtil.upload(request, request.getServletContext().getRealPath("/Upload"));

int num = Integer.parseInt(request.getParameter("num"));
String flag = request.getParameter("flag");
String menu = request.getParameter("menu");
String nowPage = request.getParameter("nowPage");

dto.setNum(num);
dto.setFlag(flag);

//작성자 본인확인을 위해 기존 게시물 가져오기
dto = dao.selectView(flag, num); 

String session_id = (String)session.getAttribute("USER_ID");
//로그인 id와 게시물id 일치여부 확인
if(session.getAttribute("USER_ID")!=null || session.getAttribute("USER_ID").equals(dto.getId())){
	System.out.println("삭제하기proc 본인확인 완료");

	int affected = dao.delete(dto);
	if(affected==1){
		%>
		<script>
			alert("삭제되었습니다.");
		</script>
		<%
		dao.close();
		response.sendRedirect("boardList.jsp?menu="+menu+"&flag="+flag);
		//얘는 왜 작동을 안할까ㅠㅠㅠㅠㅠㅠㅠㅠㅠ
// 		JavascriptUtil.jsAlertLocation("삭제되었습니다", "boardList.jsp?menu="+menu+"flag="+flag, out);
	} 
	else{
		%>
		<script>
			alert("삭제실패");
			history.back();
		</script>
		<%
// 		JavascriptUtil.jsAlertBack("삭제실패하였습니다");
	}
}
else{
	%>
	<script>
		alert("본인만 삭제가능");
		history.go(-1);
	</script>
	<%
// 	JavascriptUtil.jsAlertBack("본인만 삭제 가능합니다", out);
}
%>