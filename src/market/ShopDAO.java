package market;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

public class ShopDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	//DB연결을 위한 인자생성자1
	public ShopDAO() {
		String driver = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://127.0.0.1:3306/suamil_db";
		try {
			Class.forName(driver);
			String id = "suamil_user"; // 2.ID정보
			String pw = "1234"; // 3.PW정보
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB연결성공(디폴트생성자)");
		} catch (Exception e) {
			System.out.println("DB연결실패(디폴트생성자)");
			e.printStackTrace();
		}
	}
	
	//인자생성자2 : application내장객체는 javax.servlet.ServletContext타입
	public ShopDAO(ServletContext ctx) {
		try {
			Class.forName(ctx.getInitParameter("MariaJDBCDriver"));
			String id = ctx.getInitParameter("MariaUser");
			String pw = ctx.getInitParameter("MariaPass");
			con = DriverManager.getConnection(ctx.getInitParameter("MariaConnectURL"), id, pw);
			System.out.println("DB연결성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//자원해제
	public void close() {
		try {
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		} catch (Exception e) {
			System.out.println("자원해제 오류");
		}
	}
	
	//상품갯수 카운트
	public int shopCount(Map<String, Object> map) 
	{
		System.out.println("상품갯수 카운트 시작");
		int totalCount = 0;
		
		String sql = "SELECT COUNT(*) FROM shop_products ";
		//검색결과가 있을경우
		if(map.get("word")!=null) {
			sql += " WHERE "+ map.get("column")
				+ " LIKE '%"+map.get("word")+"%' ";
		}
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
			
			System.out.println("카운트갯수="+totalCount);
		}
		catch (Exception e) {
			System.out.println("상품갯수 카운트시 오류발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	//상품리스트 불러오기
	public List<ShopDTO> shopList(Map<String, Object> map) {
		
		System.out.println("상품리스트 불러오기 시작");
		
		List<ShopDTO> list = new ArrayList<ShopDTO>();
		String sql = "SELECT * FROM shop_products ";
		
		//검색결과가 있을경우
		if(map.get("word")!=null) {
			sql += " WHERE "+ map.get("column")
				+ " LIKE '%"+map.get("word")+"%' ";
		}
		sql += " ORDER BY idx DESC LIMIT ?, ? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setInt(1,  Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2, Integer.parseInt(map.get("end").toString()));
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				ShopDTO dto = new ShopDTO();
				dto.setIdx(rs.getInt("idx"));
				dto.setImage(rs.getString("image"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setPrice(rs.getInt("price"));
				dto.setSaved_money(rs.getInt("saved_money"));
				dto.setManual(rs.getString("manual"));

				list.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("상품리스트 오류");
			e.printStackTrace();
		}
		return list;
	}
	
	//상품뷰
	public ShopDTO shopView(int idx) { 
		//try안에 선언하면 리턴 불가
		ShopDTO dto = new ShopDTO();
		String query = "SELECT * FROM shop_products WHERE idx = ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, idx);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setIdx(rs.getInt("idx"));
				dto.setImage(rs.getString("image"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setPrice(rs.getInt("price"));
				dto.setSaved_money(rs.getInt("saved_money"));
				dto.setManual(rs.getString("manual"));
			}
		}
		catch (Exception e) {
			System.out.println("상품뷰 오류");
		}
		return dto;
	}
	
	//장바구니에 물건담기
	public int basketAdd(String id, int idx, int count, int sum) {
		int result = 0;
		
		String sql = "INSERT INTO shop_basket (id, idx, count, sum) "
				+ " VALUES (?, ?, ?, ?)";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, idx);
			psmt.setInt(3, count);
			psmt.setInt(4, sum);
			result = psmt.executeUpdate();
			if(result==1) {
				System.out.println("장바구니 물건담기 성공");
			}
		}
		catch (Exception e) {
			System.out.println("장바구니 물건담기 중 오류발생");
		}
		return result;
	}
	
	//담아서 리스트화 하기 payResult==n인 값만 불러오기
	public List<ShopDTO> basketList(String id){
		//정보저장을 위한 리스트 생성
		List<ShopDTO> list = new ArrayList<ShopDTO>();
		
		String sql = "SELECT * FROM shop_basket WHERE id=? AND payResult='n'";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ShopDTO dto = new ShopDTO();
				dto.setId(rs.getString("id"));
				dto.setIdx(rs.getInt("idx"));
				dto.setCount(rs.getInt("count"));
				dto.setSum(rs.getInt("sum"));
				dto.setPayResult(rs.getString("payResult"));
				
				list.add(dto);
			}
		}
		catch (Exception e) {
		}
		return list;
	}
	
	//장바구니 리스트 삭제하기
	public void basketDelete(String id, int idx) {
		int result = 0;
		String sql = "DELETE FROM shop_basket WHERE id=? AND idx=? ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, idx);
			result = psmt.executeUpdate();
			if(result==1) System.out.println("삭제성공");
		} 
		catch (Exception e) {
			System.out.println("장바구니 삭제 오류");
			e.printStackTrace();
		}
	}
	
	//구매했을때는 payResult를 y로 변경
	public int basketOrder(String id, int idx) {
		int result=0;
		
		String sql = "UPDATE shop_basket SET payResult='y' WHERE id=? AND idx=? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, idx);
			result = psmt.executeUpdate();
			if(result==1) {
				System.out.println("y변경 성공");
			}
		} catch (Exception e) {
			System.out.println("장바구니 구매y변경 오류");
		}
		return result;
	}
	
	//상품주문시 주문정보
	public int order(String product, String user, String address, String pay) {
		int result = 0;
		String sql = "INSERT INTO shop_ordering "
					+ " (product_data,user_data,shop_address,pay_type) "
					+ "	VALUES (?, ?, ?, ?)";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, product);
			psmt.setString(2, user);
			psmt.setString(3, address);
			psmt.setString(4, pay);
			
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("주문시 오류");
		}
		return result;
	}
}
