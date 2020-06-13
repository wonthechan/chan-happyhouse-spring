package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.happyhouse.dto.NoticeDto;
import com.ssafy.happyhouse.dto.QnADto;
import com.ssafy.happyhouse.mapper.NoticeMapper;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeMapper mapper;
	@Override
	public List<NoticeDto> retrieveNotice() {
		return mapper.selectNotice();
	}

	@Override
	public NoticeDto detailNotice(int no) {
		return mapper.selectNoticeByNo(no);
	}

	@Override
	public boolean writeNotice(NoticeDto dto) {
		return mapper.insertNotice(dto) == 1;
	}

	@Override
	@Transactional
	public boolean updateNotice(NoticeDto dto) {
		return mapper.updateNotice(dto) == 1;
	}

	@Override
	@Transactional
	public boolean deleteNotice(int no) {
		return mapper.deleteNotice(no) == 1;
	}

}
