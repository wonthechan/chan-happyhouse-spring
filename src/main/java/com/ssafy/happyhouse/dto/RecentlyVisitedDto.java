package com.ssafy.happyhouse.dto;

public class RecentlyVisitedDto {
	private int rid;
	private String uid;
	private int no;
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public RecentlyVisitedDto() {}
	public RecentlyVisitedDto(int rid, String uid, int no) {
		super();
		this.rid = rid;
		this.uid = uid;
		this.no = no;
	}
	
}
