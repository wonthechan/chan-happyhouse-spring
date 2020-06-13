package com.ssafy.happyhouse.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.dto.NoticeDto;
import com.ssafy.happyhouse.dto.QnADto;

@Mapper
public interface NoticeMapper {

	List<NoticeDto> selectNotice();

	NoticeDto selectNoticeByNo(int no);

	int insertNotice(NoticeDto dto);

	int updateNotice(NoticeDto dto);

	int deleteNotice(int no);

}
