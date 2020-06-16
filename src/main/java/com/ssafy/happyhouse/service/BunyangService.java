package com.ssafy.happyhouse.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.Bunyang;

public interface BunyangService {

	public List<Bunyang> getAllBunyang(int offset, int limit);
	public int getAllBunyangCount();
	public List<Bunyang> getBunyang();
	public List<Bunyang> getRecentlyBunyang();
}
