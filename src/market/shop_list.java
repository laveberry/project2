package market;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.PagingUtil;

//쇼핑몰 리스트불러오기 서블렛
//@WebServlet("/market/shop_list")
public class shop_list extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		System.out.println("쇼핑몰 리스트 서블렛 시작");
		
		Map<String, Object> map = new HashMap<String, Object>();
		ShopDAO dao = new ShopDAO();
		
		//검색어 쿼리스트링 생성
		String addQueryString = "";
		//검색어 관련 파라미터 처리
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		//검색어가 있는경우 파라미터를 Map에 저장하고, 쿼리스트링 생성
		if(!(searchWord==null || searchWord.equals(""))){
			addQueryString += String.format("searchColumn=%s&searchWord=%s&", 
					searchColumn, searchWord);
			map.put("column", searchColumn);
			map.put("word", searchWord);
		}
		
		int nowPage = (req.getParameter("nowPage")==null ||
				req.getParameter("nowPage").equals("")) ?
					1 : Integer.parseInt(req.getParameter("nowPage"));
		//전체 상품수 카운트
		int totalCount = dao.shopCount(map);
		
		//페이지처리용 application객체생성
		ServletContext application = this.getServletContext();
		int pageSize=Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
		int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));
		int totalPage = (int)Math.ceil((double)totalCount/pageSize);
		int start = (nowPage-1) * pageSize;
		int end = pageSize;
		
		//Map 컬렉션에 데이터 저장
		map.put("start", start);
		map.put("end", end);
		map.put("totalPage", totalPage);
		map.put("nowPage", nowPage);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		
		String pagingImg = PagingUtil.pagingBS4(totalCount, 
				pageSize, blockPage, nowPage,
				"../market/shop_list?"+addQueryString);
		
		List<ShopDTO> list = dao.shopList(map);
		dao.close();
		req.setAttribute("list", list);
		req.setAttribute("map", map);
		req.setAttribute("nowPage", nowPage);
		req.setAttribute("pagingImg", pagingImg);
		
		//리스트페이지로 포워드(리퀘스트 영역공유)
		req.getRequestDispatcher("../market/sub01.jsp"+addQueryString).forward(req, resp);
	}
	
}
