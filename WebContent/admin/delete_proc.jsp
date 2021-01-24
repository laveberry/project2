<%@page import="multi.BbsDTO"%>
<%@page import="multi.BbsDAO"%>
<%@page import="multi.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
System.out.println("삭제프로세스 실행");

String style = request.getParameter("style");
int result = 0;

if(style.equals("board")){//게시판 삭제
	int num = Integer.parseInt(request.getParameter("num"));
	String flag = request.getParameter("flag");
	BbsDAO dao = new BbsDAO();
	BbsDTO dto = new BbsDTO();
	dto.setNum(num);
	dto.setFlag(flag);
	result = dao.delete(dto);
}
else if(style.equals("people")){//회원삭제
	String id = request.getParameter("id");
	MemberDAO dao = new MemberDAO();
	result = dao.deletePeople(id);
}
if(result==1){
	%>
	<script>
		alert("삭제성공");
		history.back();
	</script>
	<%
}
else{
	%>
	<script>
		alert("삭제실패");
		history.back();
	</script>
	<%
}
%>