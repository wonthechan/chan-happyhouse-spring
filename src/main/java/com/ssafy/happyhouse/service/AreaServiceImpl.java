package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.AreaDto;
import com.ssafy.happyhouse.mapper.AreaMapper;

@Service
public class AreaServiceImpl implements AreaService{
	@Autowired
	AreaMapper areaMapper;

	@Override
	public List<AreaDto> getAllSido() {
		return areaMapper.selectAllSido();
	}

	@Override
	public List<AreaDto> getAllGugun(String sidocode) {
		// TODO Auto-generated method stub
		return areaMapper.selectAllGugun(sidocode);
	}

	@Override
	public List<AreaDto> getAllDong(String guguncode) {
		return areaMapper.selectAllDong(guguncode);
	}

	@Override
	public List<AreaDto> getAllInterestArea(String uid) {
		return areaMapper.selectAllInterestArea(uid);
	}

	@Override
	public int addInterestArea(String uid, String dongcode, String dong) {
		return areaMapper.insertInterestArea(uid, dongcode, dong);
	}

	@Override
	public int deleteInterestArea(String uid, String dong) {
		return areaMapper.deleteInterestArea(uid, dong);
	}

}
