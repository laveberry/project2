package survlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import multi.BbsDAO;
import util.FileUtil;

public class download_ctrl extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("파일다운로드 서블릿 실행");
		//폼값받기
		String attachedfile = req.getParameter("attachedfile");
//		String changefile = req.getParameter("changefile");
		
		String num = req.getParameter("num");
		
		//서버에저장된파일명 : changefile
//		FileUtil.download(req, resp, "/Upload", changefile, attachedfile);
		
		//파일명 변경하지않고 다운로드
		FileUtil.download(req, resp, "/Upload", attachedfile, "2차플젝 이미지.jpg");
		
		BbsDAO dao = new BbsDAO();
		dao.downCountPlus(num);
		
		
		dao.close();
	}
}
