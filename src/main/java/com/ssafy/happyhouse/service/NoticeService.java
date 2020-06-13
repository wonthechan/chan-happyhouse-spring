package com.ssafy.happyhouse.service;

import java.util.List;

import com.ssafy.happyhouse.dto.NoticeDto;

public interface NoticeService {

	List<NoticeDto> retrieveNotice();

	NoticeDto detailNotice(int no);

	boolean writeNotice(NoticeDto dto);

	boolean updateNotice(NoticeDto dto);

	boolean deleteNotice(int no);

}
