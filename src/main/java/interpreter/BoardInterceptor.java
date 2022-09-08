package interpreter;
import java.net.URLEncoder;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import logic.User;
public class BoardInterceptor  extends HandlerInterceptorAdapter{
	@Override   //BoardController.getBoard() 메서드 실행 전 호출되는 메서드 
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler)	throws Exception {
		HttpSession session = request.getSession();
		String boardid = (String)session.getAttribute("boardid"); //게시판 종류
		User login = (User) session.getAttribute("loginUser");    //로그인 정보
		if(boardid == null || boardid.equals("1"))
		   if (login == null || !login.getUserid().equals("admin")) {			
			String msg = URLEncoder.encode("관리자만 등록 가능합니다.", "UTF-8");
			response.sendRedirect
			   (request.getContextPath()+"/board/list?boardid="+boardid+"&msg="+msg);
			return false;  //BoardController.getBoard() 메서드 실행 안함. 
		}		
		return true;  // BoardController.getBoard() 메서드 실행 
	}
}
