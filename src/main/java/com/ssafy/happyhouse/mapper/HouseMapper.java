package com.ssafy.happyhouse.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.ApartMontlyAvgDto;
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
	public int interestInsert(@Param("uid") String uid, @Param("no") int no);
	public int interestDelete(@Param("uid") String uid, @Param("no") int no);
	public List<HouseDeal> interestFindAll(String uid);
	public int visitHouseDeal(@Param("uid") String uid, @Param("no") int no);
	public int visitHouseDealDelete(String uid);
	public int visitHouseDealCount(String uid);
	public List<HouseDeal> visitHouseDealSelect(String uid);
	
	//HouseInfo
	public String searchAptImg(String aptName);
	public List<HouseInfo> searchDistinct(HousePageBean bean);
	public List<ApartMontlyAvgDto> selectApartMonthlyAvg();
}
