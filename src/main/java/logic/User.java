package logic;


import javax.validation.constraints.Email;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class User {
	@Size(min=3,max=10,message="아이디는 3자이상 10자 이하로 입력하세요.")
	private String userid;
	@Size(min=3,max=10,message="비밀번호는 3자이상 10자 이하로 입력하세요.")
	private String pass;
	@NotEmpty(message="비밀번호확인을 입력하세요.")
	private String passCheck;
	@NotEmpty(message="사용자 이름은 필수 입니다.")
	private String name;
	@NotNull(message="전화번호를 입력하세요.")
	private String tel; 
	@NotEmpty(message="email은 필수 입니다.")
	@Email(message="email 형식으로 입력하세요")
	private String email;
	private Integer type;
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	
	public String getPassCheck() {
		return passCheck;
	}
	public void setPassCheck(String passCheck) {
		this.passCheck = passCheck;
	}
	@Override
	public String toString() {
		return "User [userid=" + userid + ", pass=" + pass + ", passCheck=" + passCheck + ", name=" + name
				+ ", tel=" + tel + ", email=" + email + ", type=" + type + "]";
	}

	
	


	
}
