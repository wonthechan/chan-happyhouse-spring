package com.ssafy.happyhouse.dto;

public class ApartMontlyAvgDto {
	private String guName;
	private int dealMonth;
	private int avgDealPrice;
	public String getGuName() {
		return guName;
	}
	public void setGuName(String guName) {
		this.guName = guName;
	}
	public int getDealMonth() {
		return dealMonth;
	}
	public void setDealMonth(int dealMonth) {
		this.dealMonth = dealMonth;
	}
	public int getAvgDealPrice() {
		return avgDealPrice;
	}
	public void setAvgDealPrice(int avgDealPrice) {
		this.avgDealPrice = avgDealPrice;
	}
	@Override
	public String toString() {
		return "ApartMontlyAvgDto [guName=" + guName + ", dealMonth=" + dealMonth + ", avgDealPrice=" + avgDealPrice
				+ "]";
	}
}
