package com.ssafy.happyhouse.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.dto.UserDto;
import com.ssafy.happyhouse.mapper.UserMapper;

@Service
public class UserServiceImpl implements UserService{
	@Autowired
	UserMapper userMapper;
	
	public UserDto login(Map<String, String> map) {
		return userMapper.login(map);
	}

	public String findPw(Map<String, String> map) {
		return userMapper.findPw(map);
	}

	public int delete(Map<String, String> map) {
		return userMapper.delete(map);
	}
	
	public int join(UserDto dto) {
		return userMapper.join(dto);
	}
	public int update(UserDto dto) {
		return userMapper.update(dto);
	}
	
}
