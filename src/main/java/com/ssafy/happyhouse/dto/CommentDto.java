package com.ssafy.happyhouse.dto;

public class CommentDto {
	private int cid;
	private int bid;
	private String uid;
	private String content;
	private String regdt;
	public int getCid() {
		return cid;
	}
	public void setCid(int cid) {
		this.cid = cid;
	}
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdt() {
		return regdt;
	}
	public void setRegdt(String regdt) {
		this.regdt = regdt;
	}
	@Override
	public String toString() {
		return "CommentDto [cid=" + cid + ", bid=" + bid + ", uid=" + uid + ", content=" + content + ", regdt=" + regdt
				+ "]";
	}
}
