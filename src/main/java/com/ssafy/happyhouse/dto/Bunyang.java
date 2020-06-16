package com.ssafy.happyhouse.dto;

public class Bunyang {

	private int bid;
	private String bname;
	private String bstate;
	private String bdate;
	private String btype;
	private String blocation;

	public int getBid() {
		return bid;
	}

	public void setBid(int bid) {
		this.bid = bid;
	}

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public String getBstate() {
		return bstate;
	}

	public void setBstate(String bstate) {
		this.bstate = bstate;
	}

	public String getBdate() {
		return bdate;
	}

	public void setBdate(String bdate) {
		this.bdate = bdate;
	}

	public String getBtype() {
		return btype;
	}

	public void setBtype(String btype) {
		this.btype = btype;
	}

	public String getBlocation() {
		return blocation;
	}

	public void setBlocation(String blocation) {
		this.blocation = blocation;
	}

	@Override
	public String toString() {
		return "Bunyang [bid=" + bid + ", bname=" + bname + ", bstate=" + bstate + ", bdate=" + bdate + ", btype="
				+ btype + ", blocation=" + blocation + "]";
	}

}
