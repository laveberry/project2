package util;import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//쿠키 생성 및 저장
public class CookieUtil {
	
	public static void makeCookie(HttpServletRequest req, HttpServletResponse resp,
			String cId, String cPass, int time) {
		//쿠키객체 생성
		Cookie cookie = new Cookie(cId, cPass);
		//경로설정(전체사용)
		cookie.setPath(req.getContentType());
		//시간설정
		cookie.setMaxAge(time);
		//응답헤더에 쿠키추가 후 클라이언트로 전송
		resp.addCookie(cookie);
	}
}
