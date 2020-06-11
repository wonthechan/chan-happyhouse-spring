package com.ssafy.happyhouse.dto;

public class UserDto {
	
	private String uid;
	private String uname;
	private String uaddress;
	private String uphone;
	private String upassword;
	
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUaddress() {
		return uaddress;
	}
	public void setUaddress(String uaddress) {
		this.uaddress = uaddress;
	}
	public String getUphone() {
		return uphone;
	}
	public void setUphone(String uphone) {
		this.uphone = uphone;
	}
	public String getUpassword() {
		return upassword;
	}
	public void setUpassword(String upassword) {
		this.upassword = upassword;
	}
	@Override
	public String toString() {
		return "UserDto [uid=" + uid + ", uname=" + uname + ", uaddress=" + uaddress + ", uphone=" + uphone
				+ ", upassword=" + upassword + "]";
	}
	
}
