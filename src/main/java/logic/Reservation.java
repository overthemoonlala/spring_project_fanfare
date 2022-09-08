package logic;

import java.util.Date;

public class Reservation {
	private int no;
	private String userid;
	private int prenum;
	private Date predate;
	private String bakeryid;
	private String bname;
	private String name;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getPrenum() {
		return prenum;
	}
	public void setPrenum(int prenum) {
		this.prenum = prenum;
	}
	public Date getPredate() {
		return predate;
	}
	public void setPredate(Date predate) {
		this.predate = predate;
	}
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
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	@Override
	public String toString() {
		return "Reservation [no=" + no + ", userid=" + userid + ", prenum=" + prenum + ", predate=" + predate
				+ ", bakeryid=" + bakeryid + ", bname=" + bname + "]";
	}
	
	
}
