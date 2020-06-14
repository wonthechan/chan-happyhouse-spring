package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ssafy.happyhouse.dto.QnADto;
import com.ssafy.happyhouse.mapper.QnAMapper;

@Service
public class QnAServiceImpl implements QnAService {

	@Autowired
	private QnAMapper mapper;
	@Override
	public List<QnADto> retrieveQnA() {
		return mapper.selectQnA();
	}

	@Override
	public QnADto detailQnA(int no) {
		return mapper.selectQnAByNo(no);
	}

	@Override
	public boolean writeQnA(QnADto dto) {
		return mapper.insertQnA(dto) == 1;
	}

	@Override
	@Transactional
	public boolean updateQnA(QnADto dto) {
		return mapper.updateQnA(dto) == 1;
	}

	@Override
	@Transactional
	public boolean deleteQnA(int no) {
		return mapper.deleteQnA(no) == 1;
	}

}
