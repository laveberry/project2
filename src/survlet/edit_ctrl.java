package survlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import multi.BbsDAO;
import multi.BbsDTO;
import util.FileUtil;

public class edit_ctrl extends HttpServlet{
	
	//수정하기 진입시
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//파라미터 받기
		int num = Integer.parseInt(req.getParameter("num"));
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
				req.setAttribute("flag", flag);
				req.setAttribute("menu", menu);
				req.setAttribute("leftMenu", leftMenu);
				req.setAttribute("flaglist", flaglist);
				req.setAttribute("menulist", menulist);
		
		//DB연결
		BbsDAO dao = new BbsDAO();
		//게시물 불러오기
		BbsDTO dto = dao.selectView(flag, num);
		//수정폼을 구성하기 위해 게시물의 내용 가져와서 requset에 저장하기
		req.setAttribute("dto", dto);
		
		String queryStr = "menu="+menu+"&flag="+flag+"&num="+num;
		
		
//		if(flag=="04") {//파일없움...
//			req.getRequestDispatcher("/space/sub04_edit.jsp?"+queryStr).forward(req, resp);
//		}
//		else {
			req.getRequestDispatcher("/space/community_edit.jsp?"+queryStr).forward(req, resp);
//		}
	}
	
	
	//수정 전송시
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("utf-8");
		
		MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("/Upload"));
		ServletContext app = this.getServletContext();
		BbsDAO dao = new BbsDAO(app);
		BbsDTO dto = new BbsDTO();
		
		int sucOrFail;
		
		if(mr != null) {
			int num = Integer.parseInt(mr.getParameter("num"));
			String flag = mr.getParameter("flag");
			String menu = mr.getParameter("menu");
			
			int nowPage = (req.getParameter("nowPage")==null
					|| req.getParameter("nowPage").equals("")) ?
							1 : Integer.parseInt(req.getParameter("nowPage"));
			
			//수정처리후 상세보기 페이지로 이동해야 하므로 영역에 속성을 저장한다.
			req.setAttribute("num", num);
			req.setAttribute("nowPage", nowPage);
			req.setAttribute("flag", flag);
			req.setAttribute("menu", menu);
			
			String originalfile="";
			
			String id = mr.getParameter("id");
			String title = mr.getParameter("title");
			String name = mr.getParameter("name");
			String content = mr.getParameter("content");
			if(mr.getParameter("file")!=null) {
				String attachedfile = mr.getFilesystemName("file");//얘는 왜 null예외가 안뜨지 ?photoCtrl에서는 뜸..rename때문인듯
				originalfile = mr.getParameter("originalfile");
				
				//파일이 변경되었는지 확인. null이면 변경되지 않았다
				if(attachedfile==null) {
					attachedfile = originalfile;
				}
				dto.setAttachedfile(attachedfile);
			}

			//확인하기
			dto.setId(id);
			dto.setTitle(title);
			dto.setName(name);
			dto.setContent(content);
			dto.setNum(num);
			
			sucOrFail = dao.updateEdit(dto);
			
			
			String queryStr = "menu="+menu+"&flag="+flag+"&num="+num+"&nowPage="+nowPage;
			
			if(sucOrFail==1) {
				System.out.println("게시글 수정 완료");
			}
			else {
				System.out.println("게시글 수정 실패");
			}
			//원본파일 지워주기
			if(sucOrFail==1 && mr.getFilesystemName("attachedfile")!=null) {
				FileUtil.deleteFile(req, "/Upload", originalfile);
				System.out.println("원본파일 삭제완료");
			}
			else {
				sucOrFail = -1;
				System.out.println("원본파일 없음");
			}
			resp.sendRedirect("../space/list_ctrl?"+queryStr);
//			req.getRequestDispatcher("/space/list_ctrl?"+queryStr).forward(req, resp);
		}
	}
}
