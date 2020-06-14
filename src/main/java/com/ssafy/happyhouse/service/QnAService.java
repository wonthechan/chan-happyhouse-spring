package com.ssafy.happyhouse.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.QnADto;

public interface QnAService {

	List<QnADto> retrieveQnA();

	QnADto detailQnA(int no);

	boolean writeQnA(QnADto dto);

	boolean updateQnA(QnADto dto);

	boolean deleteQnA(int no);

}
