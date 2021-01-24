package survlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import javax.servlet.http.HttpServletResponse;


import multi.BbsDAO;
import multi.BbsDTO;
import util.FileUtil;
import util.JavascriptUtil;

public class write_ctrl extends HttpServlet{
	
	//글쓰기 페이지 진입시 포워드 진행
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String menu = req.getParameter("menu");
		String flag = req.getParameter("flag");
		
		//추가부분/////////
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
				req.setAttribute("flag", flag);//${flag} 사용가능
				req.setAttribute("menu", menu);
				req.setAttribute("leftMenu", leftMenu);
				req.setAttribute("flaglist", flaglist);
				req.setAttribute("menulist", menulist);
				
				//${param.flag}용 쿼리스트링 생성
				String queryStr = "menu="+menu+"&flag="+flag;
		//포워드 진행
		req.getRequestDispatcher("space/community_write.jsp"+queryStr).forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		//req객체와 물리적경로를 매개변수로 upload()를 호출한다.
		MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("/Upload"));
		
		int sucOrFail;
		
		if(mr != null) {
			
			BbsDTO dto = new BbsDTO();

			String title = req.getParameter("title");
			String content = req.getParameter("content");
			String file = req.getParameter("file");
			String flag = req.getParameter("flag");
			String menu = req.getParameter("menu");
			
			//추가부분/////////
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
			//리퀘스트영역에 저장
			req.setAttribute("flag", flag);
			req.setAttribute("menu", menu);
			req.setAttribute("leftMenu", leftMenu);
			req.setAttribute("flaglist", flaglist);
			req.setAttribute("menulist", menulist);
			
			
			
			HttpSession session = req.getSession();
			
			dto.setTitle(title);
			dto.setContent(content);
			dto.setAttachedfile(file);
			dto.setFlag(flag);
			dto.setId(session.getAttribute("USER_ID").toString());
			
			

			BbsDAO dao = new BbsDAO();

			// 100개 글쓰기
			// int affected = 1;
			// for(int i=1 ; i<100 ; i++){
//			 	dto.setTitle(title + " "+i+"번째 게시물");
//			 	dao.insertWrite(dto);
			// }
			


			int affected = dao.insertWrite(dto);
			if(affected==1){
				JavascriptUtil.jsAlertBack("글쓰기 성공!");
				resp.sendRedirect("/space/list_ctrl?menu="+menu+"flag="+flag);
			
		}
			else {
				JavascriptUtil.jsAlertLocation("글쓰기실패", "history.go(-1)");
			}
	}
} 
}
