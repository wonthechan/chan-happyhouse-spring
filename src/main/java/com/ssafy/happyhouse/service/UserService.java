package com.ssafy.happyhouse.service;

import java.util.Map;

import com.ssafy.happyhouse.dto.UserDto;

public interface UserService {
	
	public UserDto login(Map<String, String> map);
	public int delete(Map<String, String> map);
	public String findPw(Map<String, String> map);
	public int join(UserDto dto);
	public int update(UserDto dto);
	public int idCheck(String uid);
}
