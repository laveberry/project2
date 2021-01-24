<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="multi.MemberDTO"%>
<%@page import="multi.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

MemberDAO dao = new MemberDAO();
MemberDTO dto = new MemberDTO();

Map<String,Object> map = new HashMap<String, Object>();

//요청한 페이지의 폼값 받아오기
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email");
int phoneNum = Integer.parseInt(request.getParameter("phoneNum"));
String address = request.getParameter("address");
String grade = request.getParameter("grade");

//dto에 정보담기
map.put("id", id);
map.put("pass", pass);
map.put("name", name);
map.put("email", email);
map.put("phoneNum", phoneNum);
map.put("address", address);
map.put("grade", grade);

System.out.println("proc 주소"+address);


int result = 0;
result = dao.updatePeople(map);
dao.close();
if(result==1){
	%>
	<script type="text/javascript">
		alert("회원정보수정 성공")
		location.href ='./peopleCtrl.jsp';
	</script>
	<%
}
else{%>
	<script>
		alert("회원정보수정 실패");
		history.go(-1);
	</script>
<%}


%>