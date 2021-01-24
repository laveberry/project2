<%@page import="util.FileUtil"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="multi.BbsDAO"%>
<%@page import="multi.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

MultipartRequest req = FileUtil.upload(request, request.getServletContext().getRealPath("/Upload"));

System.out.println("수정하기 proc시작");

//요청한 페이지의 폼값 받아오기
int num = Integer.parseInt(req.getParameter("num"));
String menu = req.getParameter("menu");
String flag = req.getParameter("flag");
String title = req.getParameter("title");
String content = req.getParameter("content");
String file = req.getParameter("file");

System.out.println("프로세스 flag"+flag);
BbsDTO dto = new BbsDTO();
BbsDAO dao = new BbsDAO();

//게시물 불러오기
dto = dao.selectView(flag, num);

		System.out.println("수정하기 dto 담기 시작");

		dto.setNum(num);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setAttachedfile(file);
		dto.setFlag(flag);
	
	int affected = dao.updateEdit(dto);
	
	if(affected==1){%>
		<script>
			alert("수정성공")
		</script>
		<%
		dao.close();
// 		response.sendRedirect("boardCtrl.jsp?menu="+menu+"&flag="+flag+"&num="+num);
		response.sendRedirect("boardCtrl.jsp");
	}
	else{
		%>
		<script>
			alert("수정하기 실패");
			history.go(-1);
		</script>
<%
}
%>