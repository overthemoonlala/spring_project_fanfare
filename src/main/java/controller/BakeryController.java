package controller;

import java.io.File;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Bakery;
import logic.BakeryMenu;
import logic.BakeryReview;
import logic.LikeBakery;
import logic.Reservation;
import logic.ShopService;
import logic.User;
import oracle.jdbc.driver.Message;

@Controller
@RequestMapping("bakery")
public class BakeryController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("*")//그외 모든 Get 방식 요청
	public ModelAndView getUser() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	
	@GetMapping("bakeryupdate")
	public ModelAndView bakeryupdate(@Param("userid") String userid, @Param("bakeryid") String bakeryid){
		ModelAndView mav = new ModelAndView ();
		Bakery bakery = service.bakerySelectOne(userid);
		User user = service.userSelectOne(userid);
		mav.addObject("user",user);
		mav.addObject("bakery",bakery);
		return mav;
	}
	@PostMapping("bakeryupdate")
	public ModelAndView bakeryupdate(@Valid Bakery bakery, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
				
		User loginUser = (User)session.getAttribute("loginUser");
		if(!loginUser.getUserid().equals(bakery.getUserid())) {
			bresult.reject("error.bakery.userid");
			mav.getModel().putAll(bresult.getModel());
			return mav;		
		}
		try {
			service.bakeryUpdate(bakery);
			mav.setViewName("redirect:../user/mypage?id="+loginUser.getUserid());
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("고객 정보 수정 실패", "update?id="+bakery.getUserid());
		}	
		return mav;
	}
	
	@GetMapping("reservation")
	public ModelAndView reservation(String id, HttpSession session){
		ModelAndView mav = new ModelAndView ();
		User user = service.userSelectOne(id);
		mav.addObject("user",user);
		List<Reservation> reservationlist = service.reservationBakery(id);
		mav.addObject("reservationlist",reservationlist);
		return mav;
	}

	
	@GetMapping("bakeryEntry")
	public ModelAndView loginCheckbakeryEntry(String id, HttpSession session){
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Bakery());
		return mav;
	}
	
	@PostMapping("bakeryEntry") 
	public ModelAndView bakeryEntry(@Valid Bakery bakery,BindingResult bresult,  HttpSession session, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		String userid = loginUser.getUserid();
		Map<String, Object> map = new HashMap<String,Object>();
		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.bakery");
			return mav;
		}
		try {
			service.bakeryInsert(bakery, userid, request);
			service.bakeryMenuInsert(bakery, request); 
			mav.addObject("bakery", bakery);
			
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.setViewName("redirect:../user/mypage?id="+loginUser.getUserid());
		return mav;
	}
	
	@GetMapping("bakerydetail")
	public ModelAndView bakerydetail(@Param("bakeryid") String bakeryid){
		ModelAndView mav = new ModelAndView ();
		Bakery bakery = service.bakerySelectbakeryid(bakeryid);
		List<BakeryMenu> bakerymenulist = service.bakerymenuSelect(bakeryid);
		System.out.println(bakerymenulist);
		mav.addObject("bakery", bakery);
		mav.addObject("bakerymenulist", bakerymenulist);
		return mav;
	}
	
	@PostMapping("bakerydetail")
	public ModelAndView bakerydetail(@Valid Bakery bakery, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		service.adminbakeryupdate(bakery.getBakeryid());
		mav.setViewName("close");
		return mav;
	}
	
	//----------------------------김수희------------------
	
	@RequestMapping("bakerylist")
	public ModelAndView bakerylist(Integer pageNum, String bakeryid, String pageid, 
			Integer adminchk, String userid, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1; 
		}
		
		if(pageid == null || pageid.equals("")) { 
			pageid = "1";
		}
		
		if(adminchk != null && adminchk == 1) {
			session.setAttribute("pageid", pageid);
			session.setAttribute("userid", userid);
			session.setAttribute("adminchk", adminchk);
		}
		int limit = 10;
		int listcount = service.blistcount();
		List<Bakery> bakerylist = service.bakerylist(pageNum, limit, pageid);
		int maxpage = (int)((double)listcount/limit + 0.95);
		int startpage = (int)((pageNum/10.0 + 0.9) - 1) * 10 + 1;
		int endpage = startpage + 9;
		if(endpage > maxpage) endpage = maxpage; 
		
		int bakeryno = listcount - (pageNum - 1) * limit;
		System.out.println("bakerylist:"+bakerylist);
		mav.addObject("pageid",pageid); 
		mav.addObject("userid",userid);       
		mav.addObject("bakeryid",bakeryid);
		mav.addObject("pageNum",pageNum);       
		mav.addObject("maxpage",maxpage);       
		mav.addObject("startpage",startpage);   
		mav.addObject("endpage",endpage);       
		mav.addObject("listcount",listcount);   
		mav.addObject("bakerylist",bakerylist);   
		mav.addObject("bakeryno",bakeryno);      
		return mav;
	}
	
	//CKEDITOR 모듈에서 이미지 파일 업로드
	@RequestMapping("imgupload")
	public String imgupload(MultipartFile upload, String CKEditorFuncNum,
				HttpServletRequest request, Model model) {
		String path = request.getServletContext().getRealPath("/")+"bakeryreview/imgfile/";
		File f = new File(path);
		if(!f.exists()) f.mkdirs();
		if(!upload.isEmpty()) { 
			File file = new File(path,upload.getOriginalFilename());
			try {
				upload.transferTo(file);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//업로드된 웹 어플리케이션 기준 파일의 절대 경로
		String fileName = request.getContextPath()+"/bakeryreview/imgfile/"
				+ upload.getOriginalFilename();
		model.addAttribute("fileName",fileName);
		model.addAttribute("CKEditorFuncNum",CKEditorFuncNum);
		return "ckedit";//뷰이름  /WEB-INF/view/ckedit.jsp
	}
	
	@GetMapping("bakeryinfo")
	public ModelAndView bakeryinfo(String bakeryid, String userid, Integer adminchk,
			String bname, Integer viewno, Integer menuid, Integer no,
			Integer likeno, Integer likestate,
			String menuname, Integer pageNum, HttpSession session) {
		
		ModelAndView mav = new ModelAndView(); 
		System.out.println(bakeryid);
		if(bakeryid != null) {
			Bakery bakeryinfo = service.getbakeryinfo(bakeryid);  
			service.breadcntadd(viewno);             
			System.out.println("bakeryinfo="+bakeryinfo);
			
			int ino=0; if(no != null) ino = no;
			   
			List<BakeryMenu> bakerymenu = service.bakerymenu(bakeryid,menuid,ino);
			LikeBakery likeBakery = service.likeBakery(bakeryid,userid);
			System.out.println("bakerymenu=" + bakerymenu);
		    mav.addObject("bakery",bakeryinfo);
		    mav.addObject("bakerymenu",bakerymenu);
		    mav.addObject("likeBakery",likeBakery);
		}
		
		//<bakerymenu>
		session.setAttribute("no", no);
		session.setAttribute("menuname", menuname);
		
		//<bakeryreview_write>
		mav.addObject("bakeryreview",new BakeryReview()); 
		
		//<bakeryreview_list>
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1; 
		}
		session.setAttribute("bakeryid", bakeryid);
		int limit = 5; 
		int rlistcount = service.rlistcount(bakeryid); 
		List<BakeryReview> bakeryreview_list = service.bakeryreview_list(pageNum,limit,bakeryid);
		int maxpage = (int)((double)rlistcount/limit + 0.95);
		int startpage = (int)((pageNum/5.0 + 0.9) - 1) * 5 + 1;
		int endpage = startpage + 4;
		if(endpage > maxpage) endpage = maxpage; 
		//화면에 보여주기 위한 게시물 번호
		int bakeryno = rlistcount - (pageNum - 1) * limit;
		System.out.println("bakeryreview_list:"+bakeryreview_list);
		mav.addObject("bakeryid",bakeryid);
		mav.addObject("bname",bname);
		mav.addObject("pageNum",pageNum);       //현재 페이지값
		mav.addObject("maxpage",maxpage);       //등록된 게시물의 건수에 따른 최대 페이지 갯수
		mav.addObject("startpage",startpage);   //화면에 표시될 시작 페이지번호
		mav.addObject("endpage",endpage);       //화면에 표시될 종료 페이지번호. 한화면에 10의 페이지 표시
		mav.addObject("rlistcount",rlistcount);   //게시판 종류별 등록된 게시물 건수
		mav.addObject("bakeryreview_list",bakeryreview_list);   //화면에 출력할 게시물 데이터 목록. 10개씩
		mav.addObject("bakeryno",bakeryno);       //페이지에 보여줄 게시물 시작 번호
		return mav; 
	}
	
	@PostMapping("review_write")
	public ModelAndView review_write(@Valid BakeryReview review,
		   BindingResult bresult, HttpServletRequest request,HttpSession session,
		   @RequestParam Map<String,String> req) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) { //유효성 검증시 오류가 존재하는 경우
			System.out.println(bresult.getModel());
			mav.getModel().putAll(bresult.getModel());// 오류 결과를 뷰의 데이터로 전달하기 위해 저장
			return mav;
		}
		
		String bakeryid = (String)request.getSession().getAttribute("bakeryid");
		review.setBakeryid(bakeryid);
		review.setIp(request.getRemoteAddr());
		service.review_write(review, request);//파일업로드, db에 등록
		mav.addObject("bakeryreview",new BakeryReview());
		mav.setViewName("redirect:bakeryinfo?bakeryid="+bakeryid);
		return mav;
	}
}
