<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//글쓰기 페이지 진입전 로그인 확인
if(session.getAttribute("USER_ID")==null){
	//특정 페이지로 진입원할때 진입원하는 페이지의 URI얻어오기
	String r_uri = request.getRequestURI();
	String flag = request.getParameter("flag");
	String menu = request.getParameter("menu");
	
	
// String queryStr = "?menu="+menu+"&flag="+flag+"&menulist="+menulist+"&flaglist="+flaglist;
String queryStr = "?menu="+menu+"&flag="+flag;

%> 
<script>
	alert("로그인 후 이용해주세요");
	//여기서 uri값을 받아서 login.jsp로 넘겨주기
	location.href="../member/login.jsp?<%=queryStr%>&returnURL=<%=r_uri%>";
<%-- 	location.href="../member/login.jsp?returnURL=<%=r_uri%>"; --%>
</script>
<%
	return;
}
%>
