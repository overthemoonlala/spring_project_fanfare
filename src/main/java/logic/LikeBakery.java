package logic;


public class LikeBakery {
	private int likestate;
	private int likeno;
	private String bakeryid;
	private String userid;
	
	public int getLikestate() {
		return likestate;
	}
	public void setLikestate(int likestate) {
		this.likestate = likestate;
	}
	public String getBakeryid() {
		return bakeryid;
	}
	public int getLikeno() {
		return likeno;
	}
	public void setLikeno(int likeno) {
		this.likeno = likeno;
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
	@Override
	public String toString() {
		return "LikeBakery [likestate=" + likestate + ", likeno=" + likeno + ", bakeryid=" + bakeryid + ", userid="
				+ userid + "]";
	}
	
	
	
}
