package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.dto.AreaDto;

public interface AreaService {

	public List<AreaDto> getAllSido();

	public List<AreaDto> getAllGugun(String sidocode);

	public List<AreaDto> getAllDong(String guguncode);

	public List<AreaDto> getAllInterestArea(String uid);

	public int addInterestArea(String uid, String dongcode, String dong);

	public int deleteInterestArea(String uid, String dongcode);

}
