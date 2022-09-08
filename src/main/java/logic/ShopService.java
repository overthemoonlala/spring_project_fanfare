package logic;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BakeryDao;
import dao.BoardDao;
import dao.ReservationDao;
import dao.UserDao;
import dao.WishDao;

@Service
public class ShopService {
	@Autowired
	UserDao userDao;
	@Autowired
	BakeryDao bakeryDao;
	@Autowired
	WishDao wishDao;
	@Autowired
	ReservationDao reservationDao;
	@Autowired
	private BoardDao boardDao;

	//User
	public User userSelectOne(String userid) {
		return userDao.selectOne(userid);
	}
	public void userUpdate(User user) {
		userDao.update(user);
	}
	public void userChgPassword(String userid, String chgpass) {
		userDao.passwordupdate(userid, chgpass);
	}

	public void userDelete(String userid) {
		userDao.delete(userid);
	}

	public List<User> userlistSelect() {
		return userDao.userlistSelect();
	}
	public void userInsert(@Valid User user) {
		userDao.insert(user);

	}
	public String getSearch(User user, String url) {
		return userDao.search(user,url) ;
	}

	
	//bakery
	public Bakery bakerySelectOne(String userid) {
		return bakeryDao.bakerySelectOne(userid);
	}
	public Bakery bakerySelectbakeryid(String bakeryid) {
		return bakeryDao.bakerySelectbakeryid(bakeryid);
	}
	public void bakeryUpdate(Bakery bakery) {
		bakeryDao.update(bakery);
	}
	public void bakeryInsert(@Valid Bakery bakery, String userid, HttpServletRequest request) {
		//파일 업로드
		if(bakery.getBakeryimg() != null && !bakery.getBakeryimg().isEmpty()) {
			uploadFileCreate(bakery.getBakeryimg(), request, "bakery/file/");
			bakery.setFileurl(bakery.getBakeryimg().getOriginalFilename());
		}
		bakeryDao.insert(bakery, userid);
	}

	public void bakeryMenuInsert(Bakery bakery, HttpServletRequest request) {
		bakery.setMenufileurl(new ArrayList<String>());
		//파일 업로드
		for (int i=0;i<bakery.getMenuname().length;i++) {
			if(bakery.getMenuimg().get(i) != null && !bakery.getMenuimg().get(i).isEmpty()) {
				uploadFileCreate(bakery.getMenuimg().get(i), request, "bakery/menu/file/");
				bakery.getMenufileurl().add(bakery.getMenuimg().get(i).getOriginalFilename());
			}
			bakeryDao.bakeryMenuInsert(bakery.getBakeryid(), 
					 bakery.getMenufileurl().get(i), bakery.getMenuinfo()[i], bakery.getMenuname()[i]);			
		}
	}

	public List<Bakery> bakerylistSelect() {
		return bakeryDao.bakerylistSelect();
	}

	public void adminbakeryupdate(String bakeryid) {
		bakeryDao.adminbakeryupdate(bakeryid);
	}

	public List<BakeryMenu> bakerymenuSelect(String bakeryid) {
		return bakeryDao.bakerymenuSelect(bakeryid);
	}
	
	//------------------------김수희------------------------
	
	public int blistcount() {
		return bakeryDao.count();
	}

	public List<Bakery> bakerylist(Integer pageNum, int limit, String pageid) {
		return bakeryDao.list(pageNum, limit,pageid);
	}

	public Bakery getbakeryinfo(String bakeryid) {
		return bakeryDao.bakeryinfo(bakeryid); 
	}

	public void breadcntadd(Integer viewno) {
		bakeryDao.readcntadd(viewno);
	}
  
	public void review_write(BakeryReview bakeryreview, HttpServletRequest request) {
		if(bakeryreview.getFile1() != null && !bakeryreview.getFile1().isEmpty()) {//업로드된 파일이 존재
			uploadFileCreate(bakeryreview.getFile1(), request, "bakeryreview/file/");//파일 업로드
			bakeryreview.setFileurl(bakeryreview.getFile1().getOriginalFilename());  //업로드된 파일의 원래이름
		}
		//db에 insert
		bakeryDao.review_write(bakeryreview);
		
	}

	public List<BakeryReview> bakeryreview_list(Integer pageNum, int limit, String bakeryid) {
		return bakeryDao.review_list(pageNum,limit,bakeryid);
	}

	public List<BakeryMenu> bakerymenu(String bakeryid, Integer no, Integer menuid) {
		return bakeryDao.bakerymenu(bakeryid,no,menuid);
		
	}

	public BakeryReview getBakeryReview(Integer no) {
		return bakeryDao.selectOne2(no);
	}
	
	public int rlistcount(String bakeryid) {
		return bakeryDao.rcount(bakeryid);
	}
	
	public Bakery getBakeryUserid(String userid) {
		return bakeryDao.selectOne3(userid);
	}

	public LikeBakery likeBakery(String bakeryid, String userid) {
		return bakeryDao.likeBakery(bakeryid,userid);
	}

	
	
    
	
    
	// wish
	public List<Wish> wishlistSelect(String id) {
		return wishDao.wishlistSelect(id);
	}
	public Wish wishSelectOne(@Param("userid") String userid, @Param("bakeryid") String bakeryid) {

		return wishDao.wishSelectOne(userid, bakeryid);
	}

	public void deleteWish(@Param("userid") String userid, @Param("bakeryid") String bakeryid) {
		wishDao.deleteWish(userid, bakeryid);
	}

	// reservation
	public List<Reservation> reservationSelect(String id) {
		return reservationDao.reservationlist(id);
	}

	public List<Reservation> reservationBakery(String id) {
		return reservationDao.reservationBakery(id);
	}

	public Reservation reservationSelectOne(@Param("userid") String userid, @Param("bakeryid") String bakeryid) {
		return reservationDao.reservationSelectOne(userid, bakeryid);
	}

	public void deleteReservation(@Param("userid") String userid, @Param("bakeryid") String bakeryid) {
		System.out.println("shop : " + userid + "," + bakeryid);
		reservationDao.deleteReservation(userid, bakeryid);
	}

	

	
	

	private void uploadFileCreate(MultipartFile file, HttpServletRequest request,String upath) {
		//file : 업로드된 파일의 내용 저장
		//request : 요청객체
		//upath : 파일위치
		String orgFile = file.getOriginalFilename(); //업로드된 파일의 원래 이름
		//업로드될 폴더의 절대경로 
		String uploadPath = request.getServletContext().getRealPath("/") + upath;
		File fpath = new File(uploadPath); 
		if(!fpath.exists()) fpath.mkdirs(); //폴더 생성
		try {
			//transferTo : file(업로드되는 파일 내용) 을 업로드폴더의 원본파일이름으로 저장 
			file.transferTo(new File(uploadPath + orgFile)); 
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	

	

	
	
	//board
	public int boardcount(String boardid) {
		return boardDao.count(boardid);
	}

	public List<Board> boardlist(Integer pageNum, int limit, String boardid) {
		return boardDao.list(pageNum,limit,boardid);
	}

	public void boardwrite(Board board, HttpServletRequest request) {
		if(board.getFile1() != null && !board.getFile1().isEmpty()) { //   ε              .
			uploadFileCreate(board.getFile1(),request,"board/file/"); //        ε 
			board.setFileurl(board.getFile1().getOriginalFilename()); //   ε                ̸ 
		}
		boardDao.write(board);
		
	}

	public Board getBoard(Integer num) {
		return boardDao.selectOne(num);
	}

	public void readcntadd(Integer num) {
		boardDao.readcntadd(num);
		
	}

	public void boardUpdate(Board board, HttpServletRequest request) {
		if(board.getFile1() != null && !board.getFile1().isEmpty()) { // ÷                   
			uploadFileCreate(board.getFile1(), request, "board/file/");	//         ε 
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		boardDao.update(board);
	}

	public void boardReply(@Valid Board board) {
		boardDao.grpStepAdd(board);
		boardDao.reply(board);
	}

	public void boardDelete(int num) {
		boardDao.delete(num);
		
	}
	
}
