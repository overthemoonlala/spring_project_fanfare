package logic;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class BakeryReview {
	private int no;
	private String bakeryid;
	private String userid;
	private String subject;
	private String content;
	private Date regdate;
	private MultipartFile file1; //파일의 정보 저장하는 변수. 파일의 이름과 프로퍼티이름이 같아야함.
	private String fileurl;
	private String ip;
	private int readcnt;
	private int grp;
	private int grplevel;
	private int grpstep;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getBakeryid() {
		return bakeryid;
	}
	public void setBakeryid(String bakeryid) {
		this.bakeryid = bakeryid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	public String getFileurl() {
		return fileurl;
	}
	public void setFileurl(String fileurl) {
		this.fileurl = fileurl;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public int getGrplevel() {
		return grplevel;
	}
	public void setGrplevel(int grplevel) {
		this.grplevel = grplevel;
	}
	public int getGrpstep() {
		return grpstep;
	}
	public void setGrpstep(int grpstep) {
		this.grpstep = grpstep;
	}
	@Override
	public String toString() {
		return "BakeryReview [no=" + no + ", bakeryid=" + bakeryid + ", userid=" + userid + ", subject=" + subject
				+ ", content=" + content + ", regdate=" + regdate + ", file1=" + file1 + ", fileurl=" + fileurl
				+ ", ip=" + ip + ", readcnt=" + readcnt + ", grp=" + grp + ", grplevel=" + grplevel + ", grpstep="
				+ grpstep + "]";
	}
	
	
	
	
}