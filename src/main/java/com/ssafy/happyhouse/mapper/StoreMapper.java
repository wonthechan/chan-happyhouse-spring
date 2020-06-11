package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.StoreInfo;

@Mapper
public interface StoreMapper {

	public int selectStoresTotalCnt(String dongcode);

	public List<StoreInfo> selectStoresByDong(@Param("dongcode") String dongcode, @Param("offset") int offset, @Param("limit") int limit);

	public StoreInfo selectEveryDetail(int no);

}
