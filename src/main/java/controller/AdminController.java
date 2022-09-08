package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.Bakery;
import logic.ShopService;
/*
 * AdminController의 모든 메서드들은 반드시 관리자로 로그인 해야 실행되도록 AOP 설정해야함
  1. 로그아웃 : 로그인 하세요. login 페이지로 이동
  2. 관리자가 아닌 경우 : 관리자만 거래 가능합니다. main 페이지로 이동
 
 */
@Controller
@RequestMapping("admin")
public class AdminController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("list")
	public ModelAndView list(Integer sort, HttpSession session) {
		 ModelAndView mav = new  ModelAndView();
		 List<Bakery> bakerylist = service.bakerylistSelect();
		 mav.addObject("bakerylist",bakerylist); 
		 return mav;
	}
}
