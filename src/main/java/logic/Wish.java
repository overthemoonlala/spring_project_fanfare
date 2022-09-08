package logic;


import java.util.Date;


public class Wish {
	String userid;
	String bakeryid;
	Date wishdate;
	String bname;
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getBakeryid() {
		return bakeryid;
	}
	public void setBakeryid(String bakeryid) {
		this.bakeryid = bakeryid;
	}
	public Date getWishdate() {
		return wishdate;
	}
	public void setWishdate(Date wishdate) {
		this.wishdate = wishdate;
	}
	
	
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	@Override
	public String toString() {
		return "Wish [userid=" + userid + ", bakeryid=" + bakeryid + ", wishdate=" + wishdate + "]";
	}
	
	
}
