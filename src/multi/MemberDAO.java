package multi;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import com.sun.org.apache.bcel.internal.generic.RETURN;

public class MemberDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	//기본생성자를 통한 DB연결
	public MemberDAO() {
		String driver = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://127.0.0.1:3306/suamil_db";
		try {
			Class.forName(driver);
			String id = "suamil_user"; //2.ID정보
			String pw = "1234"; //3.PW정보
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB연결성공(디폴트생성자)");
		}
		catch (Exception e) {
			System.out.println("DB연결실패(디폴트생성자)");
			e.printStackTrace();
		}
	}
	
	//application내장객체를 이용한 DB연결
	public MemberDAO(ServletContext ctx) {
		try {
			Class.forName(ctx.getInitParameter("MariaJDBCDriver"));
			String url = ctx.getInitParameter("MariaConnectURL");
			String mid = ctx.getInitParameter("MariaUser");
			String mpw = ctx.getInitParameter("MariaPass");
			
			con = DriverManager.getConnection(url, mid, mpw);
		}
		catch (Exception e) {
		}
	}
	
	public MemberDAO(String driver, String url, String id, String pw) {
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("마리아DB연결 성공");
		}
		catch (Exception e) {
			System.out.println("마리아DB연결 실패");
			e.printStackTrace();
		}
	}
	
	//자원해제
	public void close(){
		try {
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		}
		catch (Exception e) {
			System.out.println("자원해제 실패");
		}
	}
	
	//아이디 중복체크
	public int idCheck(String id) {
		int affected = 0;
		try {
			String sql = "SELECT COUNT(*) FROM membership WHERE id=? ";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			if(rs.next()) {
				affected = rs.getInt(1);
				System.out.println("중복아이디 있음");
			}
			else {
				System.out.println("중복아이디 없음");
			}
		}
		catch (Exception e) {
			System.out.println("아이디 중복확인 중 오류");
		}
		return affected;
	}
	
	//테스트됨
	public void test(String id, String name) throws SQLException {
		String sql = " INSERT INTO test (id, name) VALUES (?, ?) ";
		System.out.println("id");
		System.out.println("name");
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, name);
			
			rs = psmt.executeQuery();
	}
	
	
	//아이디찾기
	public String idSearch(String name, String email)  {
		
		String isId="";
		System.out.println("넘어온 이름= "+ name);
		System.out.println("넘어온 메일= "+ email);
		
		String sql = "SELECT id FROM membership "
				+ " WHERE name=? AND email=?  ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, name);
			psmt.setString(2, email);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				isId = rs.getString("id");
				System.out.println("isId="+isId);
				System.out.println("아이디찾기 성공");
			}
			else {
				System.out.println("일치아이디 없음");
			}
		}
		catch (SQLException e) {
			System.out.println("아이디찾기 중 오류");
		}
		finally {
			close();
		}
		return isId;
	}
	
	//비밀번호 찾기
	public String pwSearch(String id, String name, String email) {
		String idPw = "";
		try {
			String query = "SELECT pass FROM membership "
					+ " WHERE id=? AND name=? AND email=? ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, name);
			psmt.setString(3, email);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				idPw = rs.getString("pass");
				System.out.println("비번찾기  성공");
			}
			else
				System.out.println("비번찾기 실패_회원아님");
		}
		catch (SQLException e) {
			System.out.println("비번찾기 오류");
		}
		return idPw;
	}
	
	//로그인 확인1(사용안함)
//	public boolean isMember(String id, String pw) {
//		String sql = " SELECT * FROM membership "
//				+ " WHERE id=? AND pass=? ";
//		
//		int isMember = 0;
//		boolean isFlag = false;
//		
//		try {
//			psmt = con.prepareStatement(sql);
//			psmt.setString(1, id);
//			psmt.setString(2, pw);
//			
//			rs = psmt.executeQuery();
//			rs.next();
//			//첫번째 결과값 얻어오기
//			isMember = rs.getInt(1);
//			//결과값으로 회원여부 확인
//			if(isMember==1) {//정보일치
//				isFlag = true;
//			}
//			else {//정보 불일치
//				isFlag = false;
//			}
//		}
//		catch (Exception e) {
//			System.out.println("로그인 오류");
//			isFlag = false;
//		}
//		finally {close();}
//		
//		return isFlag;
//	}
	
	//로그인확인2(사용)
	public MemberDTO getMemberDTO(String uid, String upw) {
		
		MemberDTO dto = new MemberDTO();
		//결과값 반환해줄 컬럼만 select 한다
		String query =  " SELECT * FROM membership "
				+ " WHERE id=? AND pass=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upw);
			
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("dto에 담기시작");
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setGrade(rs.getString("grade"));
			}
			else {
				System.out.println("로그인 결과값 없음");
			}
		}
		catch (Exception e) {
//			System.out.println("로그인2 오류");
//			e.printStackTrace();
		}
		return dto;
	}
	
	//아이디/비번찾기 용
	public Map<String, String> getMemberMap(String id, String email) {
		
		//회원정보를 저장할 Map컬렉션 생성
		Map<String, String> maps = new HashMap<String, String>();
		
		//회원정보를 가져오기 위한 쿼리문 작성
		String query = "SELECT id, pass, name FROM "
				+ " membership WHERE id= ? AND email= ? ";
		try {
			//prepare 객체생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, id);
			psmt.setString(2, email);
			//쿼리실행
			rs = psmt.executeQuery();
			//오라클이 반환해준 ResultSet을 통해 결과값이 있는지 확인
			if(rs.next()) {
				//회원정보가 있다면 put()을 통해 정보를 저장한다.
				maps.put("id", rs.getString("id"));
				maps.put("pass", rs.getString("pass"));
				maps.put("name", rs.getString("name"));
				maps.put("email", rs.getString("email"));
			}
			else {
				System.out.println("동일한 아이디/이메일 없음");
			}
		}
		catch (Exception e) {
			System.out.println("아이디찾기 오류");
			e.printStackTrace();
		}
		return maps;
	}
	
	
	//로그인방법3 : DTO객체 대신 Map컬렉션에 회원정보를 저장후 반환한다.
	public Map<String, String> getMemberMap2(String id, String pass) {
		
		//회원정보를 저장할 Map컬렉션 생성
		Map<String, String> maps = new HashMap<String, String>();
		
		//회원정보를 가져오기 위한 쿼리문 작성
		String query = "SELECT * FROM "
				+ " membership WHERE id= ? AND pass= ? ";
		try {
			//prepare 객체생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, id);
			psmt.setString(2, pass);
			//쿼리실행
			rs = psmt.executeQuery();
			//오라클이 반환해준 ResultSet을 통해 결과값이 있는지 확인
			if(rs.next()) {
				//회원정보가 있다면 put()을 통해 정보를 저장한다.
				maps.put("id", rs.getString("id"));
				maps.put("pass", rs.getString("pass"));
				maps.put("name", rs.getString("name"));
				maps.put("email", rs.getString("email"));
				maps.put("grade", rs.getString("grade"));
			}
			else {
				System.out.println("회원정보찾기 결과없음");
			}
		}
		catch (Exception e) {
			System.out.println("회원정보찾기 오류2");
			e.printStackTrace();
		}
		return maps;
	}
	
	
	//회원정보 불러오기
	public MemberDTO getMember(String id) {
		
		MemberDTO dto = new MemberDTO();
		//회원정보를 가져오기 위한 쿼리문 작성
		String query = "SELECT * FROM "
				+ " membership WHERE id= ?";
		try {
			//prepare 객체생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, id);
			//쿼리실행
			rs = psmt.executeQuery();
			//오라클이 반환해준 ResultSet을 통해 결과값이 있는지 확인
			if(rs.next()) {
				//회원정보가 있다면 put()을 통해 정보를 저장한다.
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setGrade(rs.getString("grade"));
				dto.setPhoneNum(rs.getInt("phoneNum"));
				
				System.out.println("회원정보 불러오기 성공");
			}
			else {
				System.out.println("회원정보 불러오기 결과없음");
			}
		}
		catch (Exception e) {
			System.out.println("회원정보 불러오기 오류");
			e.printStackTrace();
		}
		return dto;
	}
	
	
	//아이디 중복체크
	public boolean checkId(String cId) {
		boolean result = false;
		int isId = 0;
		
		try {
			String query = " SELECT * FROM membership WHERE id = ? ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, cId);
			rs = psmt.executeQuery();
			
			rs.next();
			isId = rs.getInt(1);
			
			if(isId==1) {
				result = true;
				System.out.println("중복아이디 있음");
			}
			else {
				result = false;
				System.out.println("중복아이디 없음");
			}
		}
		catch (Exception e) {
			System.out.println("아이디 중복체크 중 오류");
			e.printStackTrace();
		}
		finally {close();}
		return result;
	}
	
	
	
	
	//회원가입
	public int regist(String id, String pass, String name, String email,
			String teleNum, String phoneNum,String address) {
		int affected = 0;
		try {
			String query = " INSERT INTO membership "
					+ " (id, pass, name, email, teleNum, phoneNum, address) "
					+ " VALUES (?, ?, ?, ? ,?, ?, ?);";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pass);
			psmt.setString(3, name);
			psmt.setString(4, email);
			psmt.setInt(5, Integer.parseInt(teleNum));
			psmt.setInt(6, Integer.parseInt(phoneNum));
			psmt.setString(7, address);
			
			affected = psmt.executeUpdate();
			if(affected==1) {
				System.out.println("회원가입 성공");
			}
			else {
				System.out.println("회원가입 실패");
			}
		} 
		catch (NumberFormatException e) {
			System.out.println("NumberFormatException 예외발생");
		}
		catch (Exception e) {
			System.out.println("회원가입 오류");
			e.printStackTrace();
		}
		finally {
			close();
		}
		return affected;
	}
	
	
	//회원정보수정
	public int updatePeople(Map<String, Object>map) {
		int affected = 0;
		try {
			String query = " UPDATE membership "
					+ " SET pass=?, name=?, email=?, phoneNum=?, address=?, "
					+ " grade=? WHERE id= ?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("pass").toString());
			psmt.setString(2, map.get("name").toString());
			psmt.setString(3, map.get("email").toString());
			psmt.setInt(4, Integer.parseInt(map.get("phoneNum").toString()));
			psmt.setString(5, map.get("address").toString());
			psmt.setString(6, map.get("grade").toString());
			psmt.setString(7, map.get("id").toString());
			
			System.out.println("dao주소"+map.get("address").toString());
			
			affected = psmt.executeUpdate();
			if(affected==1) {
				System.out.println("회원수정 성공");
			}
			else {
				System.out.println("회원수정 실패");
			}
		}
		catch (Exception e) {
			System.out.println("회원수정 오류");
			e.printStackTrace();
		}
		return affected;
	}
	
	//회원삭제
	public int deletePeople(String id) {
		int result = 0;
		
		String sql = "DELETE FROM membership WHERE id=? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("회원삭제중 오류");
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	//관리자 리스트 불러오기
	public List<MemberDTO> adminPeople(Map<String, Object> map) {
		
		List<MemberDTO> bbs = new Vector<MemberDTO>();
		
		System.out.println("관리자 리스트 불러오기 ㅅ ㅣ작");
		
		String sql = "SELECT * FROM membership ";
		
		if (map.get("word") != null) {
			sql += " WHERE " + map.get("column") + " " + " LIKE '%" + map.get("word") + "%' ";
		}
		sql += " ORDER BY regidate DESC LIMIT ?, ? ";
		
		try {
			psmt = con.prepareStatement(sql);
			
			int start = Integer.parseInt(map.get("start").toString());
			int end = Integer.parseInt(map.get("end").toString());	
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				//얘를 안에 넣어줘야함!!!★★★★
				MemberDTO dto = new MemberDTO();
				
				System.out.println("관리자리스트 담기 시작");
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPhoneNum(rs.getInt("phoneNum"));
				dto.setAddress(rs.getString("address"));
				dto.setEmail(rs.getString("email"));
				dto.setGrade(rs.getString("grade"));
				
				System.out.println("관리자리스트 담기 완료");
				
				bbs.add(dto);
				
				System.out.println("관리자dao="+rs.getString("id"));
				System.out.println("관리자dao="+rs.getString("email"));
			}
		}
		catch (Exception e) {
			System.out.println("관리자리스트 담기 중 오류");
		}
		return bbs;
	}
	
	// 회원수 카운트
	public int getTotalPeopleCount(Map map) {
		int totalCount = 0;
		try {
			String sql = "SELECT COUNT(*) FROM membership ";

			if (map.get("Word") != null) {
				sql += " WHERE " + map.get("Column") + " "
					+ " LIKE '%" + map.get("Word") + "%' ";
			}

			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
			System.out.println("회원카운트 완료");
		} catch (Exception e) {
			System.out.println("회원카운트중 오류");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	
	
	
	
//	public MemberDTO adminPeople() {
//		
//		MemberDTO dto = new MemberDTO();
//		
//		String sql = " SELECT * FROM membership WHERE grade='02' ";
//		try {
//			psmt = con.prepareStatement(sql);
//			rs = psmt.executeQuery();
//			dto.setId(rs.getString("id"));
//			dto.setName(rs.getString("name"));
//			dto.setEmail(rs.getString("email"));
//			dto.setAddress(rs.getString("adress"));
//			dto.setPhoneNum(rs.getInt("phoneNum"));
//		} catch (Exception e) {
//			System.out.println("관리자항목 불러오기중 오류");
//		}
//		return dto;
//	}
	
	
}
