package controller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import exception.BoardException;
import logic.Board;
import logic.ShopService;


@Controller  
@RequestMapping("board")  
public class BoardController {
	@Autowired  
	ShopService service;
	
	// ▶리스트
	@RequestMapping("list")
	public ModelAndView list(Integer pageNum,String boardid,HttpSession session) { 
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) { //자유게시판으로 가게하기
		   pageNum = 1; //pageNum파라미터가 없는 경우 1
		}
		if(boardid == null || boardid.equals("")) {
			boardid = "1"; //boardid파라미터가 없는 경우 "1"로 초기화
		}
		session.setAttribute("boardid", boardid); //boardid값 session에 등록하기
		
		String boardName=null; //boardname 생성 후 초기화
		switch(boardid) { 
		case "1" : boardName = "공지사항"; break;
		case "2" : boardName = "자유게시판"; break;
		case "3" : boardName = "QNA"; break;
		}
		
		int limit = 10; //한페이지에 보여질 게시물의 건수
		int listcount = service.boardcount(boardid); //게시판 구분별 전체 게시물 등록 건수  
		List<Board> boardlist = service.boardlist(pageNum,limit,boardid); //페이지에 출력할 게시물 목록 

		//페이징처리를 위한 데이터 
		int maxpage = (int)((double)listcount/limit + 0.95);//최대 필요한 페이지 수
		int startpage = (int)((pageNum/10.0 + 0.9) - 1) * 10 + 1;//화면에 표시할 페이지의 시작 번호
		int endpage = startpage + 9;  //10개의 페이지로 표시 
		if(endpage > maxpage) endpage = maxpage;
		int boardno = listcount - (pageNum - 1) * limit;
		
		mav.addObject("boardid",boardid);      //게시판 종류
		mav.addObject("boardName", boardName); //게시판 이름 
		mav.addObject("pageNum", pageNum);     //현재페이지값. 
		mav.addObject("maxpage", maxpage);     //등록된 게시물의 건수에 따른 최대 페이지 갯수
		mav.addObject("startpage", startpage); //화면에 표시될 시작 페이지번호 
		mav.addObject("endpage", endpage);  //화면에 표시될 종료 페이지번호. 한화면에 10의 페이지 표시
		mav.addObject("listcount", listcount); //게시판 종류별 등록된 게시물 건수
		mav.addObject("boardlist", boardlist); //화면에 출력할 게시물 데이터 목록. 10개씩 
		mav.addObject("boardno", boardno);     //페이지에 보여줄 게시물 시작 번호 
		return mav;
	}	
	
	
	@GetMapping("write")
	public ModelAndView getBoard(HttpSession session) {
		ModelAndView mav = new ModelAndView(); 
		String boardid = (String)session.getAttribute("boardid");
		if(boardid == null) boardid="1";
		String boardName = null;
		switch(boardid) {
		case "1" :  boardName="공지사항"; break;
		case "2" :  boardName="자유게시판"; break;
		case "3" :  boardName="QNA"; break;
		}
		mav.addObject("board",new Board()); 
		mav.addObject("boardName",boardName); 
		return mav; 
	}
	
	
	
	/* Post 방식 : write
	 * 1. 유효성 검증
	 * 2. 파일 업로드 
	 *    db의 board테이블에 내용 저장
	 * 3. 등록 성공 : list로 
	 *    등록 실패 : write로     
	 */
	@PostMapping("write")
	public ModelAndView write(@Valid Board board, BindingResult bresult,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			System.out.println(bresult.getModel());
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		String boardid = (String)request.getSession().getAttribute("boardid");
		if (boardid == null)
			 boardid = "1";
		board.setBoardid(boardid);
		board.setIp(request.getRemoteAddr());
		service.boardwrite(board,request); //2 파일 업로드, db 저장
		// 뷰를 list로 재요청하기
		mav.setViewName("redirect:list?boardid="+boardid);
		return mav;                       
	}


	// ▶imgupload 이미지 업로드
	//CKEDITOR 모듈에서 이미지 파일 업로드.
		@RequestMapping("imgupload")
		public String imgupload(MultipartFile upload, String CKEditorFuncNum, HttpServletRequest request,Model model ) {
			String path = request.getServletContext().getRealPath("/") + "board/imgfile/";
			File f =new File(path);
			if(!f.exists()) f.mkdirs(); //업로드 폴더가 없으면, 폴더 생성
			if(!upload.isEmpty()) { 
				File file = new File(path,upload.getOriginalFilename());
				try {
					upload.transferTo(file); //파일 생성
				}catch (Exception e) {
					e.printStackTrace();
				}
			}
			// 웹 어플리케이션 기준 업로드된 파일의 절대 경로
			String fileName = request.getContextPath() + "/board/imgfile/" 
			               + upload.getOriginalFilename();
			model.addAttribute("fileName",fileName);
			model.addAttribute("CKEditorFuncNum",CKEditorFuncNum);
			return "ckedit"; //뷰이름.  /WEB-INF/view/ckedit.jsp
		}
	
		
		
	// ▶detail
	@GetMapping("detail")  
	public ModelAndView detail(Integer num) {
		ModelAndView mav = new ModelAndView();
		if (num != null) {
		    Board board = service.getBoard(num); //db에서 게시물내용 조회
		    service.readcntadd(num);  //조회수 증가 
		    mav.addObject("board", board);
		}    
		return mav;  
	}	
	
	
	// ▶update, reply,delete
	@GetMapping({"update","reply"})  
	public ModelAndView update(Integer num) {
		//num : update 요청시는 수정될 게시물 번호
		//      reply 요청시는 답변을 작성할 원글의 게시물 번호 
		ModelAndView mav = new ModelAndView();
		if (num != null) {
		    Board board = service.getBoard(num); //db에서 게시물내용 조회
		    mav.addObject("board", board);
		}    
		return mav;  
	}	

	
	// ▶reply
	@PostMapping("update")
	public ModelAndView update(@Valid Board board,BindingResult bresult,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		Board dbBoard =	service.getBoard(board.getNum());
		if(!board.getPass().equals(dbBoard.getPass())) { //비밀번호 오류. 
			throw new BoardException("비밀번호가 틀립니다.",	"update?num="+board.getNum());
		}
		try {
			board.setFileurl(request.getParameter("file2")); //수정전 파일 정보 
			service.boardUpdate(board, request);
			mav.setViewName("redirect:detail?num="+board.getNum());
		} catch (Exception e) {
			e.printStackTrace();
			throw new BoardException("게시글 수정을 실패 했습니다.","update?num="+board.getNum());
		}
		return mav;
	}	
	
	
	
	@PostMapping("reply")
	public ModelAndView reply (@Valid Board board,BindingResult bresult,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			//board.getNum() : 원글의 num 값
			//dbBoard : 원글의 데이터 값
			Board dbBoard = service.getBoard(board.getNum());
			Map<String, Object> map = bresult.getModel();
			Board b = (Board)map.get("board");
			b.setSubject(dbBoard.getSubject()); //원글의 제목으로 변경
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		try {
			String boardid = (String)request.getSession().getAttribute("boardid");
			if(boardid == null) 
				throw new BoardException("게시판을 선택하세요.","list?boardid=1");
			board.setBoardid(boardid);
			board.setIp(request.getRemoteAddr());
			service.boardReply(board);
			mav.setViewName("redirect:list?boardid="+boardid);
		} catch (Exception e) {
			e.printStackTrace();
	        throw new BoardException("답변 등록시 오류 발생.","reply?num="+board.getNum());
		}
		return mav;
	}
	
	
	@GetMapping("*")  //화면 출력
	public String getView() {
		return null;
	}
	
	
	@GetMapping("delete")
	public ModelAndView delete() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Board());
		return mav;
	}
	
	
	@PostMapping("delete")
	public ModelAndView delete(Board board, BindingResult bresult){
		ModelAndView mav = new ModelAndView();
		try {
			Board dbboard = service.getBoard(board.getNum());
			if(!board.getPass().equals(dbboard.getPass())) { //비밀번호 검증 
				bresult.reject("error.login.password"); 
				return mav;
			}
			service.boardDelete(board.getNum());
			mav.setViewName("redirect:list?boardid="+dbboard.getBoardid());
		}catch (Exception e) {
			e.printStackTrace();
			throw new BoardException("게시물 삭제 실패", "delete?num="+board.getNum());
		}		
	    return mav;
    }
	
}
