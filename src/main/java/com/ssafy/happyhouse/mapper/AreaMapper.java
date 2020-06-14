package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ssafy.happyhouse.dto.AreaDto;

@Mapper
public interface AreaMapper {

	public List<AreaDto> selectAllSido();

	public List<AreaDto> selectAllGugun(String sidocode);

	public List<AreaDto> selectAllDong(String guguncode);

	public List<AreaDto> selectAllInterestArea(String uid);

	public int insertInterestArea(@Param("uid") String uid, @Param("dongcode") String dongcode, @Param("dong") String dong);

	public int deleteInterestArea(@Param("uid") String uid, @Param("dongcode") String dongcode);

}
