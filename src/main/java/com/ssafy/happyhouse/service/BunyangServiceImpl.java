package com.ssafy.happyhouse.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.Bunyang;
import com.ssafy.happyhouse.mapper.BunyangMapper;

@Service
public class BunyangServiceImpl implements BunyangService{
	@Autowired
	BunyangMapper bunyangMapper;
	public List<Bunyang> getAllBunyang(int offset, int limit){
		return bunyangMapper.getAllBunyang(offset, limit);
	}
	public List<Bunyang> getBunyang(){
		return bunyangMapper.getBunyang();
	}
	public int getAllBunyangCount() {
		return bunyangMapper.getAllBunyangCount();
	}
	public List<Bunyang> getRecentlyBunyang(){
		return bunyangMapper.getRecentlyBunyang();
	}
}
