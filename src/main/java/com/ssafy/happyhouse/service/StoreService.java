package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.dto.StoreInfo;

public interface StoreService {

	public List<StoreInfo> findStoresByDong(String dongcode, int offset, int limit);

	public int searchStoresTotalCnt(String dongcode);

	public StoreInfo getEveryDetail(int no);

}
