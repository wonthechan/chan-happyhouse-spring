package com.ssafy.happyhouse.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HouseInfo;
import com.ssafy.happyhouse.dto.HousePageBean;

@Mapper
public interface HouseMapper {
	
	//HouseDeal
	public int searchCount(HousePageBean bean);
	public List<HouseDeal> search(HousePageBean bean);
	public List<HouseDeal> searchOrderByDeal(HousePageBean bean);
	public HouseDeal detail(int no);
	
	//HouseInfo
	public String searchAptImg(String aptName);
	public List<HouseInfo> searchDistinct(HousePageBean bean);
}
