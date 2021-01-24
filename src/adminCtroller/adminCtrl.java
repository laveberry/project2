package adminCtroller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import multi.MemberDAO;
import multi.MemberDTO;

//관리자페이지 
@WebServlet("/admin")
public class adminCtrl extends HttpServlet{
	
	//처음 진입시 로그인페이지로 이동
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		//관리자아이디로 로그인되어있을시 바로이동
//		if( session.getAttribute("USER_GRADE")!=null && session.getAttribute("USER_GRADE").equals("02")) {
			resp.sendRedirect("./admin/main_admin.jsp");
//		}
//		else {//아닐경우 관리자로그인 페이지로 이동
//			resp.sendRedirect("./admin/login.jsp");
//		}
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		req.setCharacterEncoding("utf-8");
		System.out.println("관리자 서블릿 시작");
		
		String id = req.getParameter("user_id");
		String pw = req.getParameter("user_pw");
		String save = req.getParameter("id_save");
		
		
		HttpSession session = req.getSession();
		String adminCheck = (String) session.getAttribute("USER_GRADE");
				
		//기존로그인 아이디가 관리자일때 메인으로 이동
		if(adminCheck!=null && adminCheck=="02") {
			resp.sendRedirect("./admin/main_admin.jsp");
		}
		else {//관리자페이지에서 로그인 진행
			
			System.out.println("서블릿 아이디="+id);
			System.out.println("서블릿 pw="+pw);
			
			MemberDAO dao = new MemberDAO();
			MemberDTO dto = dao.getMemberDTO(id, pw);
			
			System.out.println("dto등급="+dto.getGrade());
			System.out.println("dto이메일="+dto.getEmail());
			System.out.println("dto아이디="+dto.getId());
			System.out.println("dto비번="+dto.getPass());
			
//			if(dto==null) {//로그인확인
//				PrintWriter out = resp.getWriter(); 
//				   out.println("<script>alert('관리자가 아닙니다.');"
//						     + " history.back(); "
//						     + "</script>");
//						   out.close();
//			}
			
			//로그인했는데 관리자일때
			//스트링은 equals()로 비교
			if(dto.getGrade().equals("02")) {
				System.out.println("세션에 로그인정보 저장");
				//세션영역에 로그인 정보 저장
				session.setAttribute("USER_ID", dto.getId());
				session.setAttribute("USER_PW", dto.getPass());
				session.setAttribute("USER_NAME", dto.getName());
				session.setAttribute("USER_GRADE", dto.getGrade());
				//아이디저장 체크시 쿠키 저장
				if(save!=null) {
					makeCookie(req, resp, dto.getId());
				}
				else {
					makeCookie(req, resp, "");
				}
				resp.sendRedirect("./admin/main_admin.jsp");
			}
			//로그인하지 않았거나 관리자가 아닐때
			else {
	//			PrintWriter out = resp.getWriter(); 
	//			   out.println("<script>alert('관리자만 로그인 가능합니다');"
	//					     + " history.back(); "
	//					     + "</script>");
	//					   out.close();
				resp.sendRedirect("./admin/login.jsp");//관리자 로그인페이지로 이동
			}
		}
		//이거있으니 오류남!!
//		resp.sendRedirect("./admin/login.jsp"); //관리자 로그인페이지로 이동
	}
	
	public void makeCookie(HttpServletRequest req, HttpServletResponse resp, String save_id) {
		Cookie cookie = new Cookie("SAVE_ID", save_id);
		cookie.setPath(req.getContextPath());
		cookie.setMaxAge(3600);
		resp.addCookie(cookie);
	}
}
