package com.ssafy.happyhouse.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HouseInfo;
import com.ssafy.happyhouse.dto.HousePageBean;
import com.ssafy.happyhouse.mapper.HouseMapper;

@Service
public class HouseServiceImpl implements HouseService{
	
	@Autowired
	HouseMapper houseMapper;
	
	//HouseDeal
	public int searchCount(HousePageBean bean) {
		return houseMapper.searchCount(bean);
	}
	public List<HouseDeal> search(HousePageBean bean){
		return houseMapper.search(bean);
	}
	public List<HouseDeal> searchOrderByDeal(HousePageBean bean){
		return houseMapper.searchOrderByDeal(bean);
	}
	public HouseDeal detail(int no){
		return houseMapper.detail(no);
	}
	
	//HouseInfo
	public String searchAptImg(String aptName) {
		return houseMapper.searchAptImg(aptName);
	}
	public List<HouseInfo> searchDistinct(HousePageBean bean){
		return houseMapper.searchDistinct(bean);
	}
}
