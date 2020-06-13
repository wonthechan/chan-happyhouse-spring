package com.ssafy.happyhouse.dto;

public class NoticeDto {
	private int no;
	private String uid;
	private String title;
	private String content;
	private String regdt;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
		return "QnADto [no=" + no + ", uid=" + uid + ", title=" + title + ", content=" + content + ", regdt=" + regdt
				+ "]";
	}
}
