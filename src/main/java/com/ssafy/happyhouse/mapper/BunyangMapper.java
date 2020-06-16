package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.Bunyang;

@Mapper
public interface BunyangMapper {
	public List<Bunyang> getAllBunyang(@Param("offset") int offset, @Param("limit") int limit);
	public List<Bunyang> getBunyang();
	public int getAllBunyangCount();
	public List<Bunyang> getRecentlyBunyang();
}
