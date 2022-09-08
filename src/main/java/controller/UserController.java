package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Bakery;
import logic.Reservation;
import logic.ShopService;
import logic.User;
import logic.Wish;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("*")//그외 모든 Get 방식 요청
	public ModelAndView getUser() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	
	//--------------------------지나 작업-------------------
	@PostMapping("userEntry") // POST 방식으로 user/userEntry url 요청시
	public ModelAndView userEntry(@Valid User user, BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			// reject : 뷰의 globalErrors의 내용으로 저장
			bresult.reject("error.input.user");
			return mav;
		}
		try {
			if (!user.getPass().equals(user.getPassCheck())) {
				bresult.reject("error.notequal.pass");
				mav.getModel().putAll(bresult.getModel());
				return mav;
			}
		
			service.userInsert(user);
			mav.addObject("user", user);
			// userid가 기본키 설정됨.userid가 중복된 경우 예외 발생
		
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			bresult.reject("error.duplicate.user");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.setViewName("redirect:login");
		return mav;
	}

	@PostMapping("login")
	public ModelAndView login(@Valid User user, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		if(bresult.hasErrors()) { 
			
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.login"); 
			return mav; 
		}
		 
		User dbUser = service.userSelectOne(user.getUserid());
		if (dbUser == null) {
			bresult.reject("error.login.id");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		if (user.getPass().equals(dbUser.getPass())) {
			session.setAttribute("loginUser", dbUser);
		} else {
			bresult.reject("error.login.password");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.setViewName("redirect:fanfare1?id=" + user.getUserid());
		return mav;
	}
	
	// loginCheck*로 시작하는 메서드 명 실행시 로그인 여부 검증하기 => AOP 사용
	@RequestMapping("logout")
	public String loginChecklogout(HttpSession session) {
		session.invalidate();
		return "redirect:login"; // view 리턴
	}

	// http://localhost:8088/springmvc1/user/main
	// http://localhost:8088/springmvc1/user/password
	@RequestMapping({ "main", "password" })
	public String loginCheckmain(HttpSession session) {
		return null; // url과 같은 이름의 view 리턴 : user/main.jsp
	}
	
	@PostMapping("{url}search")
	public ModelAndView search(User user, BindingResult bresult, @PathVariable String url) {
		ModelAndView mav = new ModelAndView();
		String code = "error.userid.search";
		String title = "아이디";
		if (user.getEmail() == null || user.getEmail().equals("")) {
			// rejectValue : 컬럼별로 오류메세지 저장
			// <form: errors path ="email" /> 영역에 오류 메시지 출력
			bresult.rejectValue("email", "error.required"); // @Vaild에서 처리해주는 방식.
		}
		if (user.getTel() == null || user.getTel().equals("")) {
			// <form: errors path ="phoneno" /> 영역에 오류 메세지 출력
			bresult.rejectValue("tel", "error.required");
		}
		if (url.equals("pw")) {
			title = "비밀번호";
			code = "error.password.search";
			if (user.getUserid() == null || user.getUserid().equals("")) {
				// <form: errors path ="userid" /> 영역에 오류 메시지 출력
				bresult.rejectValue("userid", "error.required");
			}
		}
		if (bresult.hasErrors()) { // rejectValue 함수로 오류가 존재
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		String result = null;
		result = service.getSearch(user, url);
		// EmptyResultDataAccessException : mybatis에서 발생되지 않는 예외. spring jdbc에서 발생
		if (result == null) {
			// <spring:message code="${error.code}" />영역에 표시됨
			bresult.reject(code); // globals오류
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.addObject("result", result);
		mav.addObject("title", title);
		mav.setViewName("search");
		return mav;

	}
	
	//-------------------------은빈 작업-----------------------
	
	@RequestMapping("mypage")
	public ModelAndView idCheckmypage(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView ();
		
		User user = service.userSelectOne(id);
		Bakery bakery = service.bakerySelectOne(id);
		List<Wish> wishlist = service.wishlistSelect(id);
		List<User> userlist = service.userlistSelect();
		mav.addObject("user",user);
		mav.addObject("bakery",bakery);		
		mav.addObject("wishlist",wishlist);
		mav.addObject("userlist",userlist);

		return mav; 
	}
	@GetMapping({"update","delete","password"})
	public ModelAndView idCheckupdate(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView ();
		User user = service.userSelectOne(id);
		mav.addObject("user",user);
		return mav; 
	}
	
	@PostMapping("update")
	public ModelAndView update(@Valid User user, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		System.out.println(loginUser);
		//1. 유효성 검증
		if(bresult.hasErrors()) {
			System.out.println("error");
			mav.getModel().putAll(bresult.getModel());
			return mav; 
		}
		//2. 비밀번호 검증
		System.out.println(loginUser);
		if(!loginUser.getPass().equals(user.getPass())) {
			bresult.reject("error.login.password");
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		//3. userid에 해당하는 고객 정보 수정
		try {
			service.userUpdate(user);
			if(user.getUserid().equals(loginUser.getUserid()))
				session.setAttribute("loginUser", user);
			mav.setViewName("redirect:fanfare1?id="+user.getUserid());
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("고객 정보 수정 실패", "update?id="+user.getUserid());
		}
		return mav;
	}
	@PostMapping("password")
	public ModelAndView password(@RequestParam Map<String,String> req, HttpSession session) {
		
		User loginUser = (User)session.getAttribute("loginUser");
		System.out.println(req);
		//req.get("password") : 현재 비밀번호
		//loginUser.getPassword()) : 등록된 비밀번호
		if(!req.get("password").equals(loginUser.getPass())) {
			throw new LoginException("비밀번호 오류 입니다", "password");
		}
		ModelAndView mav = new ModelAndView();
		try {
			//req.get("chgpass") : 변경할 비밀번호
			service.userChgPassword(loginUser.getUserid(), req.get("chgpass"));
			loginUser.setPass(req.get("chgpass")); 
			mav.setViewName("redirect:fanfare1?id="+loginUser.getUserid());
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("비밀번호 수정시 오류가 있습니다", "password");
		}
		return mav; 
	}
	
		
	@PostMapping("delete")
	public ModelAndView delete(String password, String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		System.out.println(userid);
		if(userid.equals("admin")) {
			throw new LoginException("관리자는 탈퇴는 불가합니다", "main");
		}
		
		User loginUser = (User)session.getAttribute("loginUser");
		if(!password.equals(loginUser.getPass())) {
			throw new LoginException("비밀번호를 확인하세요", "delete?id="+userid);

		} 
		try {
			service.userDelete(userid);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("탈퇴시 오류발생", "delete?id="+userid);

		}
		if(loginUser.getUserid().equals("admin")) {
			mav.setViewName("redirect:mypage?id=admin");
		} else {
			mav.setViewName("redirect:login");
			session.invalidate();
		}
		return mav;
	}
	
	
	@GetMapping("deleteForm")
	public ModelAndView deleteForm(@Param("userid") String userid, @Param("bakeryid") String bakeryid) {
		ModelAndView mav = new ModelAndView ();
		Reservation reservation = service.reservationSelectOne(userid, bakeryid);
		mav.addObject("reservation", reservation);
		return mav; 
	}
	@PostMapping("deleteForm")
	public ModelAndView deleteForm(String userid, String bakeryid, HttpSession session) {
		ModelAndView mav = new ModelAndView ();
		
		try {
			System.out.println("controller : " + userid + "," + bakeryid);
			service.deleteReservation(userid, bakeryid);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("삭제시 오류발생", "deleteForm?id="+userid + "&&bakeryid=" +bakeryid);

		}
		mav.setViewName("close");
		return mav; 
	}
	
	@GetMapping("deleteWishForm")
	public ModelAndView deleteWishForm(@Param("userid") String userid, @Param("bakeryid") String bakeryid) {
		ModelAndView mav = new ModelAndView ();
		System.out.println("controller : " + userid + "," + bakeryid);
		Wish wish = service.wishSelectOne(userid, bakeryid);
		mav.addObject("wish", wish);
		return mav; 
	}
	@PostMapping("deleteWishForm")
	public ModelAndView deleteWishForm(String userid, String bakeryid, HttpSession session) {
		ModelAndView mav = new ModelAndView ();
		
		try {
			System.out.println("controller : " + userid + "," + bakeryid);
			service.deleteWish(userid, bakeryid);
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("삭제시 오류발생", "deleteWishForm?id="+userid + "&&bakeryid=" +bakeryid);
		}
		mav.setViewName("close");
		return mav; 
	}
	
	
	@GetMapping("myreservation")
	public ModelAndView idCheckmyreservation(String id, HttpSession session){
		ModelAndView mav = new ModelAndView ();
		List<Reservation> reservationlist = service.reservationSelect(id);
		User user = service.userSelectOne(id);
		mav.addObject("user",user);
		mav.addObject("reservationlist",reservationlist);
		return mav;
	}
	
}
