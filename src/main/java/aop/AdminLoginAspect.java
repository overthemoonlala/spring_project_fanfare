package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;


@Component //객체화
@Aspect //AOP 클래스로 사용함
public class AdminLoginAspect {
	@Around("execution(* controller.Admin*.*(..)) && args(..,session)")
	public Object adminCheck(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser == null) { //로그인이 안된 상태 
			throw new LoginException("[adminCheck]로그인 후 거래 하세요","../user/login");
		} else if(!loginUser.getUserid().equals("admin")){
			throw new LoginException("[adminCheck]관리자만 거래 가능합니다.","../user/main");
		}
		return joinPoint.proceed(); 
	}
}
