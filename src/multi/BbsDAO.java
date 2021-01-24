package multi;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.sql.DataSource;

public class BbsDAO {

	Connection con;
	PreparedStatement psmt;
	ResultSet rs;

	// 인자생성자1
	public BbsDAO(String driver, String url, String id, String pw) {
		try {
			Class.forName(driver);
			// DB에 연결된 정보를 멤버변수에 저장
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB연결성공(인자생성자)");
		} catch (Exception e) {
			System.out.println("DB연결실패(인자생성자)");
			e.printStackTrace();
		}
	}

	// 인자생성자2 : application내장객체는 javax.servlet.ServletContext타입
	public BbsDAO(ServletContext ctx) {
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

	public BbsDAO() {
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

	// 인자생성자3 : 커넥션풀(DBCP)을 이용한 DB연결. 확인해보기!
//	public BbsDAO() {
//		try {
//			Context initctx = new InitialContext();
//			//이건 안바꿔도되남..?
//			Context ctx = (Context)initctx.lookup("java:comp/env");
//			DataSource source = (DataSource)ctx.lookup("jdbc_mariadb");
//			con = source.getConnection();
//			
//			System.out.println("DBCP 연결성공");
//		} 
//		catch (Exception e) {
//			System.out.println("DBCP 연결실패");
//			e.printStackTrace();
//		}
//	}

	// 자원해제
	public void close() {
		try {
			if (rs != null)
				rs.close();
			if (psmt != null)
				psmt.close();
			if (con != null)
				con.close();
		} catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}

	// 게시물의 갯수를 카운트
	public int getTotalRecordCount(Map map) {
		int totalCount = 0;
		try {
			String sql = "SELECT COUNT(*) FROM multi_board WHERE flag = " + map.get("flag") + " ";

			if (map.get("Word") != null) {
				sql += " AND " + map.get("Column") + " " + " LIKE '%" + map.get("Word") + "%' ";
			}

			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
		}
		return totalCount;
	}

	
	//페이지처리를 위한 전체게시물(레코드) 수 카운트
	public int getTotalRecordCountSearch(Map<String, Object> map) {

		System.out.println("게시물 카운트 시작");
		// 게시물의 갯수는 최초 0으로 초기화
		int totalCount = 0;
		// 기본쿼리문(전체레코드를 대상으로 함)
		try {
			String query = "SELECT COUNT(*) FROM multi_board B "
					+ " 	INNER JOIN membership M "
					+ "		ON B.id=M.id " 
					+ "		WHERE flag= " + map.get("flag") + " ";

			if (map.get("word") != null) {
				query += " AND " + map.get("column") + " " + " LIKE '%" + map.get("word") + "%' ";
			}
			System.out.println("query=" + query);
			System.out.println("카운트flag=" + map.get("flag"));
			// 쿼리 실행후 결과값 반환
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
			System.out.println("카운트 성공");
			System.out.println("totalCount=" + totalCount);
		} catch (Exception e) {
			System.out.println("카운트 시 오류발생");
		}
		return totalCount;
	}
	
	//관리자용) 페이지처리를 위한 전체게시물(레코드) 수 카운트
	public int getTotalRecordCountSearch2(Map<String, Object> map) {

		System.out.println("게시물 카운트 시작");
		// 게시물의 갯수는 최초 0으로 초기화
		int totalCount = 0;
		// 기본쿼리문(전체레코드를 대상으로 함)
		try {
			String query = "SELECT COUNT(*) FROM multi_board B "
					+ " 	INNER JOIN membership M "
					+ "		ON B.id=M.id ";

			if (map.get("word") != null) {
				query += " WHERE " + map.get("column") + " " + " LIKE '%" + map.get("word") + "%' ";
			}
			System.out.println("query=" + query);
			// 쿼리 실행후 결과값 반환
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
			System.out.println("카운트 성공");
			System.out.println("totalCount=" + totalCount);
		} catch (Exception e) {
			System.out.println("카운트 시 오류발생");
		}
		return totalCount;
	}
	

	//리스트 불러오기(페이지처리O)
	public List<BbsDTO> selectListPageSearch(Map<String, Object> map) {
		
		List<BbsDTO> bbs = new Vector<BbsDTO>();
		String query = "SELECT * FROM multi_board B " 
				+ " INNER JOIN membership M "
				+ "	ON B.id = M.id WHERE flag="+ map.get("flag") + " ";
		//검색어가 있을경우
		if (map.get("word") != null) {
			query += " AND " + map.get("column") + " "
				+ " LIKE '%" + map.get("word") + "%' ";
		}
		query += " ORDER BY num DESC LIMIT ?, ? ";

		System.out.println("리스트불러오기"+query);

		int start = Integer.parseInt(map.get("start").toString());
		int end = Integer.parseInt(map.get("end").toString());
		
		System.out.println("리스트flag=" + map.get("flag"));
		System.out.println("start=" + start);
		System.out.println("end=" + end);

		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			rs = psmt.executeQuery();

			while (rs.next()) {
				//결과셋을 DTO객체에 담음
				BbsDTO dto = new BbsDTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setAttachedfile(rs.getString("attachedfile"));
				dto.setDowncount(rs.getInt("downcount"));
				dto.setVisitcount(rs.getInt("visitcount"));
				dto.setFlag(rs.getString("flag"));
				//리스트 담기
				bbs.add(dto);
				System.out.println("리스트 불러오기 성공");
			}
		} catch (Exception e) {
			System.out.println("리스트 불러오기 중 오류");
			e.printStackTrace();
		}
		return bbs;
	}
	
	//관리자리스트 불러오기
	public List<BbsDTO> selectListAdmin(Map<String, Object> map) {

		List<BbsDTO> bbs = new Vector<BbsDTO>();
		String query = "SELECT * FROM multi_board B " 
				+ " INNER JOIN membership M "
				+ "	ON B.id = M.id ";
				
//		검색어가 있을경우
		if (map.get("word") != null) {
			query += " WHERE " + map.get("column") + " "
				+ " LIKE '%" + map.get("word") + "%' ";
		}
		query += " ORDER BY num DESC LIMIT ?, ? ";

		int start = Integer.parseInt(map.get("start").toString());
		int end = Integer.parseInt(map.get("end").toString());
		
		System.out.println("start=" + start);
		System.out.println("end=" + end);

		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, start);
			psmt.setInt(2, end);
			rs = psmt.executeQuery();
			
			while (rs.next()) {
				BbsDTO dto = new BbsDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setFlag(rs.getString("flag"));
				dto.setAttachedfile(rs.getString("attachedfile"));
				dto.setTitle(rs.getString("title"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getInt("visitcount"));
				dto.setContent(rs.getString("content"));
				dto.setDowncount(rs.getInt("downcount"));

				bbs.add(dto);
				System.out.println("관리자 리스트 불러오기 성공");
			}
		} catch (Exception e) {
			System.out.println("리스트 불러오기 중 오류");
			e.printStackTrace();
		}
		return bbs;
	}
	
	
	//메인 리스트 불러오기
	public List<BbsDTO> mainList(String flag, int end) {

		List<BbsDTO> bbs = new Vector<BbsDTO>();
		String query = "SELECT * FROM multi_board B " 
				+ " INNER JOIN membership M "
//				+ "	ON B.id = M.id ORDER BY num ";
//		+ "	ON B.id = M.id WHERE flag= ? ORDER BY num LIMIT 1, ? ";
		+ "	ON B.id = M.id WHERE flag= ? ORDER BY num DESC LIMIT 0, ? ";
		//LIMIT 0부터 시작!!!

		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, flag);
			psmt.setInt(2, end);
			rs = psmt.executeQuery();

			while (rs.next()) {
				BbsDTO dto = new BbsDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setAttachedfile(rs.getString("attachedfile"));
				dto.setDowncount(rs.getInt("downcount"));
				dto.setVisitcount(rs.getInt("visitcount"));
				dto.setFlag(rs.getString("flag"));

				bbs.add(dto);
				System.out.println("메인 리스트 불러오기 성공");
			}
		} catch (Exception e) {
			System.out.println("리스트 불러오기 중 오류");
			e.printStackTrace();
		}
		return bbs;
	}
	
	
	// 글쓰기
	public int insertWrite(BbsDTO dto) {
		int affected = 0;
		System.out.println("글쓰기 시작");
		try {
			String sql = "INSERT INTO multi_board " + " (id, title, content, attachedfile, flag) "
					+ " VALUES (?, ?, ?, ?, ?) ";

			System.out.println("dao=" + dto.getId());
			System.out.println("글쓰기="+dto.getTitle());
			System.out.println("글쓰기="+dto.getContent());
			System.out.println("글쓰기="+dto.getAttachedfile());
			System.out.println("글쓰기="+dto.getFlag());

			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getAttachedfile());
			psmt.setString(5, dto.getFlag());

			affected = psmt.executeUpdate();
			if (affected == 1)
				System.out.println("글쓰기 성공");
			else
				System.out.println("글쓰기 실패");
		} catch (Exception e) {
			System.out.println("글쓰기 중 예외발생");
			e.printStackTrace();
		} finally {
			close();
		}
		return affected;
	}

	// 수정하기
	public int updateEdit(BbsDTO dto) {
		int affected = 0;
		try {
			String query = "UPDATE multi_board SET"
					+ " title=? , content=? , attachedfile=? "
					+ " WHERE num=? ";

			System.out.println("수정하기1");
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getAttachedfile());
			psmt.setInt(4, dto.getNum());
			System.out.println("수정하기2");
			System.out.println("수정dao title"+dto.getTitle());
			
			affected = psmt.executeUpdate();
			
			if(affected==1) {
				System.out.println("수정하기 성공");
			}
			else {
				System.out.println("수정하기 실패");
			}
		} catch (Exception e) {
			System.out.println("게시물 수정중 오류발생");
			e.printStackTrace();
		}
		return affected;
	}

	// 게시물 뷰
	public BbsDTO selectView(String flag, int num) {// 이거 int로 변환해야하는지 확인하기

		BbsDTO dto = new BbsDTO();
		try {
			String sql = "SELECT *  FROM multi_board B " 
					+ " INNER JOIN membership M on B.id = M.id "
					+ " WHERE flag=? AND num = ? ";

			psmt = con.prepareStatement(sql);
			psmt.setString(1, flag);
			psmt.setInt(2, num);
			
			System.out.println("게시물불러오기중 flag="+flag);
			
			rs = psmt.executeQuery();
			if (rs.next()) {
				dto.setFlag(rs.getString("flag"));
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getInt("visitcount"));
				dto.setAttachedfile(rs.getString("attachedfile"));
				dto.setDowncount(rs.getInt("downcount"));
				dto.setContent(rs.getString("content"));
				dto.setCal(rs.getString("cal"));
				System.out.println("게시물불러오기 성공");
			}
		} catch (Exception e) {
			System.out.println("게시물 불러오기 중 오류");
			e.printStackTrace();
		}
		return dto;
	}

	// 게시물 삭제
	public int delete(BbsDTO dto) {
		
		System.out.println("게시물 삭제 시작");
		
		int affected = 0;
		try {
			String sql = " DELETE FROM multi_board WHERE num = ? AND flag = ? ";
			
			System.out.println("삭제num="+dto.getNum());
			System.out.println("삭제flag="+dto.getFlag());
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, dto.getNum());
			psmt.setString(2, dto.getFlag());

			affected = psmt.executeUpdate();
			System.out.println("게시물 삭제성공");
		} catch (Exception e) {
			System.out.println("게시물 삭제중 오류발생");
			e.printStackTrace();
		}
		return affected;
	}
	


	// 조회수 증가
	public void updateVisitCount(int num, String flag) {
		
		int result = 0;
		System.out.println("조회수증가 시작");
		
		String sql = "UPDATE multi_board SET "
				+ " visitcount=visitcount+1 "
				+ " WHERE flag =? and num =? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, flag);
			psmt.setInt(2, num);
			psmt.executeUpdate();
			if(result==1) {
				System.out.println("조회수증가 성공");
			}
		} catch (Exception e) {
			System.out.println("조회수증가 예외발생");
			e.printStackTrace();
		}
	}
	
	//파일 다운로드 횟수 증가
	public void downCountPlus(String num) {
		
		int result = 0;
		
		String sql = "UPDATE multi_board SET downcount=downcount+1 WHERE num=? ";
		try {
			System.out.println("파일 다운로드 카운트 dao 시작");
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);
			psmt.executeUpdate();
			
			if(result==1) {
				System.out.println("다운로드 카운트 성공");
			}
		} catch (Exception e) {
			System.out.println("다운로드 카운트중 오류");
		}
	}
	
	//캘린더 상세보기
	public BbsDTO calView (Map map) {
		String sql = " SELECT * FROM multi_board WHERE cal="+map.get("cal");
		
		BbsDTO dto = new BbsDTO();
		try {
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			//정보 가져오기
			if(rs.next()) {
				dto.setContent(rs.getString("content"));
				dto.setFlag(rs.getString("flag"));
				dto.setAttachedfile("attachedfile");
				dto.setCal(rs.getString("cal"));
			}
			
		} catch (Exception e) {
			System.out.println("달력상세보기 중 오류");
		}
		return dto;
	}
	
	//캘린더 상세내용 입력
	public int calControl(String id, String content, String cal) {
		
		int result = 0;
		//신규내용이면 Insert, 기존 달력내용 있으면 UPDATE
		String sql = "INSERT INTO multi_board (id, title, content, cal, flag) "
		+ " VALUES (?, '달력', ?, ?, '02') "
		+ "ON DUPLICATE KEY UPDATE "
		+ " id=? ,title='달력' ,content=?, flag='02' ";
		//이건 왜 안될까요 ???★★★★★★★★★★★★
//		+ " id='"+id+"',title='달력' ,content=?, flag='02' ";
		
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, content);
			psmt.setString(3, cal);
			psmt.setString(4, id);
			psmt.setString(5, content);
			
			
			System.out.println("id="+id);
			System.out.println("dao Content="+content);
			System.out.println("dao cal="+cal);
			
			result = psmt.executeUpdate();
			if(result==1) {
				System.out.println("달력내용입력 성공");
			}
			else {
				System.out.println("달력내용입력 실패");
			}
		} catch (Exception e) {
			System.out.println("달력 상세내용 입력 중 오류");
			e.printStackTrace();
		}
		return result;
	}
}
