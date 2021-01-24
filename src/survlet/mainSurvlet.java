package survlet;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import multi.MemberDAO;
import multi.MemberDTO;

//컨트롤러 역할
public class mainSurvlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//캘린더
//		Calendar tDay = Calendar.getInstance();
//		int now_yaer = tDay.get(Calendar.YEAR);
//		int now_month = tDay.get(Calendar.MONTH);
//		System.out.println("year="+now_yaer);
//		System.out.println("mon="+now_month);
//		req.setAttribute("now_year", now_yaer);
//		req.setAttribute("now_month", now_month);
		
		//여기서 전달안하면 get방식으로 로그인이 진행되는것 같은데 확인하기
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		req.setCharacterEncoding("UTF-8");

		//request영역에 속성저장
		String id = req.getParameter("user_id");
		String pw = req.getParameter("user_pw");
		String save = req.getParameter("id_save");//이값이 아니라 체크여부가 판단되어야함..
		//url과 uri 구분 확인하기★★★★★★★★★★★★★★★★★★★★★★★★★★
		String uri = req.getRequestURI();
		/*
		//문자열처리 ..파일명.do를 얻어온다.
		if(요청명==write.do) {
			쓰기처리
			쓰기함수();
			
		}
		else if(요청명==read.do) {
			읽기처리
			함수();
		}
		*/
		
		System.out.println("uri"+uri);
		
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = dao.getMemberDTO(id, pw);

		
		if(dto.getId()!=null) {
			//세션 저장을 위해 생성
			HttpSession session = req.getSession(); //꼭 이렇게 생성해야함!
			session.setAttribute("USER_ID", dto.getId());
			session.setAttribute("USER_PW", dto.getPass());
			session.setAttribute("USER_NAME", dto.getName());
			session.setAttribute("USER_GRADE", dto.getGrade());
			
			if(save!=null) {
				makeCookie(req, resp, dto.getId());
			}
			else {
				makeCookie(req, resp, "");
			}
			/*
			다른페이지로 이동명령 -> 주소 변경됨. req, resp객체 새롭게 생성
			ex) (session, DB에 변화생기는) 로그인, 회원가입, 게시판 글쓰기
			 */
//			resp.sendRedirect("../main/main.do?returnURL=uri");
//			resp.sendRedirect("../member/login.jsp?returnURL="+uri);
			resp.sendRedirect("../main/main.do");
//			resp.sendRedirect("../common/islogin.jsp");
//			resp.sendRedirect(req.getContextPath()+"/main/main.jsp");
		}
		else {
			req.setAttribute("ERROR_MSG", "실패");
			/*
			페이지 이동 알수없음. 최초호출 URL만 표시됨. req,resp 객체 공유. 최초요청정보 사용가능
			ex)단순조회(리스트보기, 검색)
			 */
			//절대경로
			req.getRequestDispatcher("/main/main.jsp").forward(req, resp);
			
			
//			req.getRequestDispatcher("/common/islogin.jsp").forward(req, resp);
			//이부분 다시보기★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
//			req.getRequestDispatcher("/main/main.jsp?returnURL=uri").forward(req, resp);
		}
	}
	//쿠키생성
	public void makeCookie(HttpServletRequest req, HttpServletResponse resp, String save_id) {
		Cookie cookie = new Cookie("SAVE_ID", save_id);
		cookie.setPath(req.getContextPath());
		cookie.setMaxAge(3600);
		resp.addCookie(cookie);
	}
}
