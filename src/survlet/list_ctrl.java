package survlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import multi.BbsDAO;
import multi.BbsDTO;
import multi.MemberDAO;
import multi.MemberDTO;
import util.FileUtil;
import util.PagingUtil;

public class list_ctrl extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("리스트컨트롤 시작");
		//DAO객체생성 및 DB연결
		BbsDAO dao = new BbsDAO();
		
		//컨트롤러(서블릿) 및 View(JSP)로 전달할 파라미터 저장을 위한 맵 컬렉션
		Map<String, Object> param = new HashMap<String, Object>();
		
		//게시판 관련 파라미터 처리
		String flag = req.getParameter("flag");
		String menu = req.getParameter("menu");
		//검색어 게시판 구분을 위한 Map에 저장
		param.put("flag", flag);
		param.put("menu", menu);
		
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
		
		//검색어 쿼리스트링 생성
		String addQueryString = "menu="+menu+"&flag="+flag+"&";
		//검색어 관련 파라미터 처리
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		
		if(!(searchWord==null || searchWord.equals(""))){
			//검색어가 있는경우 파라미터를 Map에 저장하고, 쿼리스트링을 만들어준다.
			addQueryString += String.format("searchColumn=%s&searchWord=%s&", 
					searchColumn, searchWord);
			param.put("column", searchColumn);
			param.put("word", searchWord);
		}
		
		//현재 페이지번호를 설정. 최초진입시 무조건 1로 설정.
		
		int nowPage = (req.getParameter("nowPage")==null
				|| req.getParameter("nowPage").equals("")) ?
						1 : Integer.parseInt(req.getParameter("nowPage"));
//		테이블 전체 레코드수 카운트
		int totalRecordCount = dao.getTotalRecordCountSearch(param);
		
		//페이지 처리 - web.xml의 초기화 파라미터 이용
		ServletContext application = this.getServletContext();
		//사진게시판과 일반게시판 리스크갯수 구분을 위해 전역변수 선언
		int pageSize = 0;
		if(flag.equals("04")) {
			pageSize= 6;
		}
		else {
			pageSize = 
					Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
		}
		int blockPage = 
				Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));
		
		//전체 페이지수를 계산
		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);		
		System.out.println("전체레코드수:"+ totalRecordCount);
		System.out.println("전체페이지수:"+ totalPage);
		

		//한페이지에 출력할 게시물의 구간을 정하기위해 start, end값 계산
		/*
			페이지 처리를 위해 오라클에서는 서브쿼리와 rownum을 이용하지만
			마리아디비에서는 limit를 사용하므로 아래 계산식이 달라져야한다. 
		*/
		int start = (nowPage-1) * pageSize;
		int end = pageSize;
		
		//Map 컬렉션에 데이터 저장
		param.put("start", start);
		param.put("end", end);
		param.put("totalPage", totalPage);
		param.put("nowPage", nowPage);
		param.put("totalCount", totalRecordCount);
		param.put("pageSize", pageSize);

		//여기서 페이지 이동 처리 ★sub04.jsp가 아닌 list_ctrl(서블릿)으로 url처리 해야함
		String pagingImg = PagingUtil.pagingBS4(totalRecordCount, 
				pageSize, blockPage, nowPage,
				"../space/list_ctrl?"+addQueryString);
		param.put("pagingImg", pagingImg);		
		
		//테이블의 전체 레코드를 가져와서 List 컬렉션에 저장한다. 
		//페이지처리O
		List<BbsDTO> lists = dao.selectListPageSearch(param);
		 
		//DB연결을 해제하는것이 아니라 커넥션풀에 개체를 반납한다. 
		dao.close();
		
		//로그인 등급확인
		String grade="0";
		HttpSession session = req.getSession();
		//관리자등급확인을 위한 로그인정보 불러오기
		if(flag.equals("06")) {
			//이렇게 하면 null에러 발생! 사용하지말것
//			String user = session.getAttribute("USER_ID").toString();
			//관리자페이지는 USER_GRADE 활용
			if(session.getAttribute("USER_ID")!=null &&
					session.getAttribute("USER_ID")!=""){
				String user = session.getAttribute("USER_ID").toString();
				MemberDAO mdao = new MemberDAO();
				MemberDTO mdto = mdao.getMember(user);
				if(mdto.getGrade()!=null && mdto.getGrade().equals("02")){
					grade=mdto.getGrade();//관리자 등급:02
				}
			}
		}
		
		//데이터를 request영역에 저장한다. 
		req.setAttribute("lists", lists);
		req.setAttribute("map", param);
		req.setAttribute("flag", flag);
		req.setAttribute("menu", menu);
		req.setAttribute("pagingImg", pagingImg);
		req.setAttribute("addQueryString", addQueryString);
		req.setAttribute("nowPage", nowPage);
		req.setAttribute("leftMenu", leftMenu);
		req.setAttribute("flaglist", flaglist);
		req.setAttribute("menulist", menulist);
		req.setAttribute("grade", grade);

		//여기서 추가해야 페이지이동할때 오류 안남
		addQueryString += "nowPage="+nowPage+"&";
		
		if(flag.equals("04")) {
			//영역에 저장된 데이터를 View로 전달하기 위해 포워드한다. 
			req.getRequestDispatcher("/space/sub04.jsp?"+addQueryString).forward(req, resp);
		}
		else if(flag.equals("1")) {
			req.getRequestDispatcher("/admin/peopleCtrl.jsp?"+addQueryString).forward(req, resp);
		}
		else {
			req.getRequestDispatcher("/space/communityList.jsp?"+addQueryString).forward(req, resp);
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		super.doPost(req, resp);
	}
}
