package aop;


import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;


@Component	//객체화.
@Aspect		//AOP 기능 객체
public class UserLoginAspect {
	/*
	 * Pointcut : 핵심메서드 선택 방식 결정
	 * execution(* controller.User*.loginCheck*(..)) :
	 		controller 패키지의 클래스 중 이름이 User로 시작하는 모든 클래스
			매서드 중 이름이 loginCheck로 시작하는 모든 메서드  	
	 * args(..,session)	:
	 		매서드의 마지막 매개변수 자료형이 session인 메서드
	 * .. : 갯수에 상관없음.
	 
	 * Advice : aop 메서드의 실행 시점 설정
	 		@Around : Pointcut 메서드의 호출 전 userLoginCheck 메서드 먼저 호출
	 				  핵심 메서드 실행 전, 후에 aop메서드 실행
	 		@Before : 핵심 메서드 실행 전 aop 메서드 실행
	 		@AfterReturning : 핵심 메서드 정상 종료 후 aop 메서드 실행
	 		@AfterThrowing :  핵심 메서드 비정상 료 후(오류 발생시) aop 메서드 실행
	 		@After : 핵심 메서드 종료 후 aop 메서드 실행 
	 */
	@Around("execution(* controller.User*.loginCheck*(..)) && args(..,session)")
	public Object userLoginCheck(ProceedingJoinPoint joinPoint, HttpSession session) throws Throwable {
		// joinPoint : 실행되는 메서드의 순서를 관리하는 객체 
		// session : 핵심 매서드의 매개변수 중 session 객체
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser == null) { //로그인이 안된 상태 
			throw new LoginException("[userlogin]로그인 후 거래 하세요","login");
		}
		return joinPoint.proceed(); //다음 메서드 호출 
	}
	
	@Around("execution(* controller.User*.idCheck*(..)) && args(..,id,session)")
	public Object useridCheck(ProceedingJoinPoint joinPoint,String id, HttpSession session) throws Throwable {
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser == null) { 
			throw new LoginException("[idCheck]로그인 후 거래 하세요","login");
		} else if (!loginUser.getUserid().equals(id) && !loginUser.getUserid().equals("admin")) {
			throw new LoginException("[idCheck]본인 정보만 거래 가능합니다.","main");
		}
		return joinPoint.proceed(); 
	}
	
	
	
}
