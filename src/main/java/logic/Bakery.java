package logic;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class Bakery {
	@Size(min=3,max=10,message="아이디는 3자이상 10자 이하로 입력하세요.")
	String bakeryid;
	@NotEmpty(message="사용자 이름은 필수 입니다.")
	String bname;
	String bakeryinfo;
	MultipartFile bakeryimg; 
	String fileurl;
	@NotEmpty(message="위치정보는 필수 입니다.")
	String location;
	String opentime;
	String closetime;
	String dayoff;
	String bakerytel;
	int likeno;
	int viewno;
	Date regdate;
	Date updateDate;
	String userid;
	String pass;
	String adminchk;
	
	//김수희
	String pageid;
	
	//bakerymenu
	String[] menuname;
	List<MultipartFile> menuimg;
	List<String> menufileurl;
	String[] menuinfo;
	int no;
	int menuid;
	
	public String getBakeryid() {
		return bakeryid;
	}
	public void setBakeryid(String bakeryid) {
		this.bakeryid = bakeryid;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getBakeryinfo() {
		return bakeryinfo;
	}
	public void setBakeryinfo(String bakeryinfo) {
		this.bakeryinfo = bakeryinfo;
	}
	public String getLocation() { 
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getOpentime() {
		return opentime;
	}
	public void setOpentime(String opentime) {
		this.opentime = opentime;
	}
	public String getClosetime() {
		return closetime;
	}
	public void setClosetime(String closetime) {
		this.closetime = closetime;
	}
	public String getDayoff() {
		return dayoff;
	}
	public void setDayoff(String dayoff) {
		this.dayoff = dayoff;
	}
	public String getBakerytel() {
		return bakerytel;
	}
	public void setBakerytel(String bakerytel) {
		this.bakerytel = bakerytel;
	}
	public int getLikeno() {
		return likeno;
	}
	public void setLikeno(int likeno) {
		this.likeno = likeno;
	}
	public int getViewno() {
		return viewno;
	}
	public void setViewno(int viewno) {
		this.viewno = viewno;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getAdminchk() {
		return adminchk;
	}
	public void setAdminchk(String adminchk) {
		this.adminchk = adminchk;
	}
	public MultipartFile getBakeryimg() {
		return bakeryimg;
	}
	public void setBakeryimg(MultipartFile bakeryimg) {
		this.bakeryimg = bakeryimg;
	}
	public String getFileurl() {
		return fileurl;
	}
	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}
	
	//김수희
	public String getPageid() {
		return pageid;
	}
	public void setPageid(String pageid) {
		this.pageid = pageid;
	}	
	
	
	
	
	//bakerymenu
	
	public String[] getMenuname() {
		return menuname;
	}
	public void setMenuname(String[] menuname) {
		this.menuname = menuname;
	}
	public List<MultipartFile> getMenuimg() {
		return menuimg;
	}
	public void setMenuimg(List<MultipartFile> menuimg) {
		this.menuimg = menuimg;
	}
	public List<String> getMenufileurl() {
		return menufileurl;
	}
	public void setMenufileurl(List<String> menufileurl) {
		this.menufileurl = menufileurl;
	}
	public String[] getMenuinfo() {
		return menuinfo;
	}
	public void setMenuinfo(String[] menuinfo) {
		this.menuinfo = menuinfo;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getMenuid() {
		return menuid;
	}
	public void setMenuid(int menuid) {
		this.menuid = menuid;
	}
	
	
	
	@Override
	public String toString() {
		return "Bakery [bakeryid=" + bakeryid + ", bname=" + bname + ", bakeryinfo=" + bakeryinfo + ", bakeryimg="
				+ bakeryimg + ", location=" + location + ", opentime=" + opentime + ", closetime=" + closetime
				+ ", dayoff=" + dayoff + ", bakerytel=" + bakerytel + ", likeno=" + likeno + ", viewno=" + viewno
				+ ", regdate=" + regdate + ", updateDate=" + updateDate + ", userid=" + userid + "]";
	}
	
	
}


