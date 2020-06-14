package com.ssafy.happyhouse.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.dto.UserDto;

@Mapper
public interface UserMapper {
	

	public UserDto login(Map<String, String> map);
	public int delete(Map<String, String> map);
	public String findPw(Map<String, String> map);
	public int join(UserDto dto);
	public int update(UserDto dto);
	public int idCheck(String uid);
}
