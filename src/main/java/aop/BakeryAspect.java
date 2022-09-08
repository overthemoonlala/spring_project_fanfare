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
public class BakeryAspect {
	@Around("execution(* controller.Bakery*.loginCheck*(..)) && args(..,session)")
	public Object userLoginCheck(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
		// joinPoint : 실행되는 메서드의 순서를 관리하는 객체 
		// session : 핵심 매서드의 매개변수 중 session 객체
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser == null) { //로그인이 안된 상태 
			throw new LoginException("[userlogin]로그인 후 거래 하세요","../user/login");
		}
		return joinPoint.proceed(); //다음 메서드 호출 
	}
}
