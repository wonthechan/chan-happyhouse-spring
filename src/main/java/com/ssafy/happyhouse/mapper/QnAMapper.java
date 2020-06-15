package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.dto.CommentDto;
import com.ssafy.happyhouse.dto.QnADto;

@Mapper
public interface QnAMapper {

	List<QnADto> selectQnA();

	QnADto selectQnAByNo(int no);

	int insertQnA(QnADto dto);

	int updateQnA(QnADto dto);

	int deleteQnA(int no);

	List<CommentDto> selectComment(int no);

	int insertComment(CommentDto dto);

	int updateComment(CommentDto dto);

	int deleteComment(int cid);

}
