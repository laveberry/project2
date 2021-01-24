package survlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import multi.BbsDAO;
import multi.BbsDTO;
import util.FileUtil;
import util.JavascriptUtil;

public class delete_ctrl extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");

		BbsDTO dto = new BbsDTO();
		BbsDAO dao = new BbsDAO();

		int num = Integer.parseInt(req.getParameter("num"));
		String flag = req.getParameter("flag");
		String menu = req.getParameter("menu");
		String nowPage = req.getParameter("nowPage");

		dto.setNum(num); 
		dto.setFlag(flag);

		//작성자 본인확인을 위해 기존 게시물 가져오기
		dto = dao.selectView(flag, num); 
		//세션 생성
		HttpSession session = req.getSession();
		
		String session_id = (String)session.getAttribute("USER_ID");
		//로그인 id와 게시물id 일치여부 확인
		if(session_id.equals(dto.getId())){
			int affected = dao.delete(dto);
			if(affected==1){
				//게시물 삭제성공시 첨부파일도 삭제
				String fileName = dto.getAttachedfile();
				//경로명, 파일명 전달하여 물리적경로에 저장된 파일 삭제
				FileUtil.deleteFile(req, "Upload", fileName);
				
				if(flag=="04") {
					JavascriptUtil.jsAlertLocation("삭제되었습니다", "../space/sub04.jsp?menu="+menu+"&flag="+flag+"&nowPage="+nowPage);
					
				}
				else {
					JavascriptUtil.jsAlertLocation("삭제되었습니다", "../space/boardList.jsp?menu="+menu+"&flag="+flag+"&nowPage="+nowPage);
				}
			} 
			else{
				JavascriptUtil.jsAlertLocation("삭제실패하였습니다", "history.go(-1)");
			}
		}
		else{
			JavascriptUtil.jsAlertBack("본인만 삭제 가능합니다");
		}
	}

}
