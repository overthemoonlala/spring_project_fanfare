package logic;

import java.util.Date;
import java.util.List;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class BakeryMenu {
	String menuname;
	MultipartFile menuimg;
	String menufileurl;
	String menuinfo;
	int no;
	int menuid;
	public String getMenuname() {
		return menuname;
	}
	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}
	public MultipartFile getMenuimg() {
		return menuimg;
	}
	public void setMenuimg(MultipartFile menuimg) {
		this.menuimg = menuimg;
	}
	public String getMenufileurl() {
		return menufileurl;
	}
	public void setMenufileurl(String menufileurl) {
		this.menufileurl = menufileurl;
	}
	public String getMenuinfo() {
		return menuinfo;
	}
	public void setMenuinfo(String menuinfo) {
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
	
	
}


