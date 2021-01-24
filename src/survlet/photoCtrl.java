package survlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

import multi.BbsDAO;
import multi.BbsDTO;
import util.FileUtil;
import util.JavascriptUtil;

public class photoCtrl extends HttpServlet{
	
	//글쓰기페이지 진입시 요청처리. 글쓰기 폼으로 이동하는것은 get방식
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("글쓰기서블릿 get 시작");
		
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
		req.setAttribute("flag", flag);
		req.setAttribute("menu", menu);
		req.setAttribute("leftMenu", leftMenu);
		req.setAttribute("flaglist", flaglist);
		req.setAttribute("menulist", menulist);
		
		System.out.println("플레그="+flag);
		System.out.println("메뉴="+menu);
		
		if(flag.equals("04")) {
			req.getRequestDispatcher("/space/sub04_write.jsp?menu=space&flag=04").forward(req, resp);
		}
		else {
			req.getRequestDispatcher("/space/community_write.jsp?menu="+menu+"&flag="+flag).forward(req, resp);
		}
	}
	
	
	//글쓰기 전송시
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("서블릿 연결 완료");
		req.setCharacterEncoding("UTF-8");
		
		//application 내장객체 생성
//		ServletContext application = req.getServletContext();
//		String saveDirectory = application.getRealPath("/Upload");
		String saveDirectory = req.getServletContext().getRealPath("/Upload");
		int maxPostSize = 1024* 5000;
		String encording = "UTF-8";
		FileRenamePolicy policy = new DefaultFileRenamePolicy();

		
		
		//파일 업로드를 위한 객체생성 및 물리적경로 가져오기
//		MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("/Upload"));
		MultipartRequest mr = new MultipartRequest(
							req, saveDirectory, maxPostSize, encording, policy);
		
		//신규파일명 저장 및 게시판구분을 위한 폼값 받아오기. 쿼리스트링 전달을위해 전역변수로 선언
		String flag = mr.getParameter("flag");
		String menu = mr.getParameter("menu");
		
		BbsDTO dto = new BbsDTO();
		BbsDAO dao = new BbsDAO();
		int sucOrFail;
		
			//업로드 경로가 존재한다면
			if(saveDirectory !=null) { 
				/*
				파일업로드가 완료되면 나머지 폼값을 받기위해 mr참조변수를 이용한다. 
				 */
				String id = mr.getParameter("id");//id도 빼먹지말고 받아주기!
				String title = mr.getParameter("title");
				String content = mr.getParameter("content");
				//서버에 저장된 실제 파일명
//				String attachedfile = mr.getFilesystemName("file");
				
				

				//null예외 방지를 위해 if문 안에서 파라미터 받아오기
				if(mr.getParameter("file")!=null) {
					//서버에 저장된 파일명 가져오기(form값 name)
					String attachedfile = (mr.getFilesystemName("file")!=null) ?
							mr.getFilesystemName("file") : "";
					//파일명 변경을 위한 날짜와 시간 얻어오기
			//		String nowTime = new SimpleDateFormat("yyyy_MM_dd_H_m_s_S").format(new Date());

					//파일의 확장자를 가져오기위해 파일명의 마지막에 있는 점의 위치를 찾는다. lastIndexof()활용
					int idx = -1;
					idx = attachedfile.lastIndexOf(".");
					String newfilename = "file&menu="+menu+"&flag="+flag;
					String changefile = newfilename + attachedfile.substring(idx, attachedfile.length());
					
					File oldfile = null;
					oldfile = new File(saveDirectory + oldfile.separator + attachedfile);
					File newfile = new File(saveDirectory + oldfile.separator + changefile);
					
					oldfile.renameTo(newfile);
					
					//null에러 방지를 위해 여기서 넣어주기
					dto.setAttachedfile(attachedfile);//원본파일명
					dto.setChangefile(changefile);//서버에저장된 파일명
					System.out.println("파일"+attachedfile);
					System.out.println("새로운파일이름"+changefile);
				}
				
				//확인
				System.out.println("서블릿ctrl="+id);
				System.out.println("title"+title);
				System.out.println("content"+content);
				System.out.println("flag="+flag);
				
				//DTO객체에 위의 폼값을 저장한다.
				dto.setFlag(flag);
				dto.setId(id);
				dto.setTitle(title);
				dto.setContent(content);
				//DAO객체생성 및 연결. insert처리
				//파일업로드 성공 및 insert성공시
				sucOrFail = dao.insertWrite(dto);
				/*
				페이지 처리를 위한 데이터 입력(100개)
				sucOrFail =1;
				for(int i=1; i<=100 ; i++) {
					dto.setTitle("자료실"+i+"번째 포스팅");
					dao.insert(dto);
				}
				 */
				//성공하면 1, 실패시 0 반환
				dao.close();
			}
			else {
				//mr객체가 생성되지 않은경우, 즉 파일업로드 실패시
				System.out.println("mr객체생성 실패");
				sucOrFail = -1;
			}
			if(sucOrFail==1) {
				//글쓰기 성공시 리스트로 이동
//				resp.sendRedirect("../space/sub04.jsp?menu="+menu+"&flag"+flag);
				resp.sendRedirect("../space/list_ctrl?menu="+menu+"&flag="+flag);
			}
			else {
					System.out.println("서블릿 글쓰기 실패");
					//jsp에서는 JspWrite, 자바에서는 PrintWriter!!!★
					PrintWriter out = resp.getWriter();	
					out.println("<script>alert('글쓰기 실패.');"
							    + " history.back(); "
							    + "</script>");
					out.close();//꼭 close해줘야함
				}
			}
	}
