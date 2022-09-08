package controller;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import logic.Bakery;
import logic.ShopService;
import logic.User;

/*
 * @Comtroller : @Component(객체화) + 요청을 받아주는 클래스
  			매서드 리턴타입 : String => 뷰의 이름 리턴
  			매서드 리턴타입 : ModelAndView => 뷰의 전달할 객체 + 뷰의 이름 리턴
  			
 * @RestController : @Component(객체화) + 요청을 받아주는 클래스 + 클라이언트에 값을 전달
  			매서드 리턴타입 : String => 값 : 이전버전 @ResoponseBody
  			매서드 리턴타입 : Object => 값
 */
@RestController
@RequestMapping("ajax")
public class AjaxController {
	@Autowired
	ShopService service;
	
	@RequestMapping("idchk")
	public String idchk (String userid) {
		String chk = null;
		User user = service.userSelectOne(userid);
		if(user == null) chk = "false"; //등록된 회원이 없는 경우
		else chk = "true"; 
		return chk;
	}
	@RequestMapping("bakeryidchk")
	public String bakeryidchk (String bakeryid) {
		String chk = null;
		Bakery bakery = service.bakerySelectbakeryid(bakeryid);
		if(bakery == null) chk = "false"; //등록된 회원이 없는 경우
		else chk = "true"; 
		return chk;
	}
	// produces : 클라이언트에 한글 인코딩 방식 설정
	// text/plain : 순수 문자열(MIME 형식)
	@RequestMapping(value="select",produces="text/plain; charset=utf-8")
	public String select(String si, String gu, HttpServletRequest request) {
	BufferedReader fr = null;
		try {
			fr = new BufferedReader(new FileReader(request.getServletContext().getRealPath("/")+"file/sido.txt"));
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		}
		Set<String> set = new LinkedHashSet<>(); //(순서 유지 + 중복불가) 가능한 set 객체
		String data= null;
		if (si == null && gu == null) {
			try {
				while((data = fr.readLine()) != null) {
					String[] arr = data.split("\\s+");
					if(arr.length>=3) set.add(arr[0].trim());
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else if(gu == null) {  //si 파라미터 존재
			si = si.trim();
			try {
				while((data = fr.readLine()) != null) {
					String[] arr = data.split("\\s+");
					if(arr.length>=3 && arr[0].equals(si) && !arr[0].equals(arr[1])) {
						set.add(arr[1].trim());
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else { //si 파라미터, gu 파라미터 존재
			si = si.trim();
			gu = gu.trim();
			try {
				while((data = fr.readLine()) != null) {
					String[] arr = data.split("\\s+");
					if(arr.length>=3 && arr[0].equals(si) && arr[1].trim().equals(gu) && !arr[1].equals(arr[2])) {
						if(arr.length > 3) arr[2] += " " + arr[3];
						set.add(arr[2].trim());
					}
				}
			}catch(IOException e) {
				e.printStackTrace();
			}
		}
		List<String> list = new ArrayList(set);
		return list.toString();
	}
}