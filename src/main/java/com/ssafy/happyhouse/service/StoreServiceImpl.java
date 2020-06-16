package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.StoreInfo;
import com.ssafy.happyhouse.mapper.StoreMapper;

@Service
public class StoreServiceImpl implements StoreService{
	@Autowired
	StoreMapper storeMapper;

	@Override
	public List<StoreInfo> findStoresByDong(String dongcode, int offset, int limit) {
		return storeMapper.selectStoresByDong(dongcode, offset, limit);
	}

	@Override
	public int searchStoresTotalCnt(String dongcode) {
		return storeMapper.selectStoresTotalCnt(dongcode);
	}

	@Override
	public StoreInfo getEveryDetail(int no) {
		return storeMapper.selectEveryDetail(no);
	}
}
