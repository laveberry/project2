package survlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import multi.BbsDAO;
import multi.BbsDTO;

public class view_ctrl extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("서블릿 view컨트롤 시작");
		
		BbsDAO dao = new BbsDAO();
		BbsDTO dto = new BbsDTO();
		
		int num = Integer.parseInt(req.getParameter("num"));
		String flag = req.getParameter("flag");
//		int nowPage = Integer.parseInt(req.getParameter("nowPage"));
		
		int nowPage = (req.getParameter("nowPage")==null
				|| req.getParameter("nowPage").equals("")) ?
						1 : Integer.parseInt(req.getParameter("nowPage"));
		
		
		//추가부분/////////
		String menu = "";
		switch(flag){
			case "01":case"02":case"03":case"04":case"05":
				menu = "space";break;
			case "06":case"07":
				menu = "community";break;
		}
		String menulist ="";
		switch(menu){
			case "space": menulist="열린공간"; break;
			case "community" : menulist="커뮤니티"; break;
		}
		//flag에 따른 게시판 이름 구분 처리
		System.out.println("보드리스트flag="+flag);
		String flaglist = "";
		switch(flag){
			case "01": flaglist = "공지사항"; break;
			case "02": flaglist = "프로그램일정"; break;
			case "03": flaglist = "자유게시판"; break;
			case "04": flaglist = "사진게시판"; break;
			case "05": flaglist = "정보자료실"; break;
			case "06": flaglist = "직원자료실"; break;
			case "07": flaglist = "보호자게시판"; break;
		}
		String leftMenu = "../include/"+menu+"_leftmenu.jsp";
		////////////////////////////
		req.setAttribute("flag", flag);
		req.setAttribute("menu", menu);
		req.setAttribute("leftMenu", leftMenu);
		req.setAttribute("flaglist", flaglist);
		req.setAttribute("menulist", menulist);
		
		System.out.println("menulist"+menulist);
		
		
//		String queryStr = "menu="+menu+"&flag="+flag+"&num="+num;
		String queryStr = "menu="+menu+"&flag="+flag+"&num="+num+"&nowPage="+nowPage;

		
		dao.updateVisitCount(num, flag);
		dto = dao.selectView(flag, num);
		
		//게시물 줄바꿈처리
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
		dao.close();
		
		//request영역에 DTO저장
		req.setAttribute("dto", dto);
		req.setAttribute("menu", menu);
		req.setAttribute("nowPage", nowPage);
		req.setAttribute("queryStr", queryStr);
		
		
		if(flag.equals("04")) {
			req.getRequestDispatcher("../space/sub04_view.jsp?"+queryStr).forward(req, resp);
		}
		else {
			req.getRequestDispatcher("../space/community_view.jsp?"+queryStr).forward(req, resp);
		}
	}
}
