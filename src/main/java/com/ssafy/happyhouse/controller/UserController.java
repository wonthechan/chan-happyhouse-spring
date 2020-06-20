package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.dto.UserDto;
import com.ssafy.happyhouse.service.UserService;

import io.swagger.annotations.ApiOperation;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/users")
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(QnAController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";

	@Autowired
	private UserService userService;

	@ApiOperation(value = "유저 아이디와 패스워드로 로그인을 시도하고, 성공시 세션에 userDto로 정보를 저장한다.", response = UserDto.class)
	@PostMapping(value = "/login")
	public ResponseEntity<UserDto> login(@RequestBody UserDto user, HttpSession session) throws Exception {

		logger.debug("user login - 호출");
		Map<String, String> loginMap = new HashMap<String, String>();
		loginMap.put("uid", user.getUid());
		loginMap.put("upassword", user.getUpassword());
		UserDto userDto = userService.login(loginMap);

		session.setAttribute("userDto", userDto);
		System.out.println(userDto);
		return new ResponseEntity<UserDto>(userDto, HttpStatus.OK);
	}

	@ApiOperation(value = "사용자의 uid와 uname 정보가 일치할 때만 비밀번호를 반환한다.", response = String.class)
	@GetMapping(value = "/{findid}/{findname}")
	public ResponseEntity<String> findPw(@PathVariable String findid, @PathVariable String findname) throws Exception {

		logger.debug("user findPw - 호출");
		Map<String, String> map = new HashMap<String, String>();
		map.put("uid", findid);
		map.put("uname", findname);
		String upassword = userService.findPw(map);

		if (upassword == null) {
			return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
		}

		return new ResponseEntity<String>(upassword, HttpStatus.OK);

	}

	@ApiOperation(value = " 사용자가 마이페이지에서 정보를 수정하고,입력한 비밀번호가 사용자 정보와 일치할때 수정한다.", response = String.class)
	@PutMapping(value = "/update")
	public ResponseEntity<String> update(@RequestBody UserDto dto, HttpSession session) throws Exception {

		logger.debug("user update - 호출");

		int total = userService.update(dto);

		if (total == 0) {
			return new ResponseEntity<String>(FAIL, HttpStatus.OK);
		}
		session.setMaxInactiveInterval(0);
		session.setAttribute("userDto", dto);
		return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
	}

	@ApiOperation(value = "사용자의 아이디와 비밀번호를 받아 DB에 회원 정보가 일치하면 삭제한다.", response = String.class)
	@DeleteMapping(value = "/delete")
	public ResponseEntity<String> delete(@RequestBody UserDto dto) throws Exception {
		logger.debug("user delete - 호출");

		Map<String, String> map = new HashMap<String, String>();
		map.put("uid", dto.getUid());
		map.put("upassword", dto.getUpassword());
		System.out.println(dto);
		int total = userService.delete(map);

		if (total == 0) {
			return new ResponseEntity<String>(FAIL, HttpStatus.OK);
		}

		return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);

	}

	@ApiOperation(value = "사용자의 정보를 받아 회원 가입한다.", response = String.class)
	@PostMapping(value = "/join")
	public ResponseEntity<String> join(@RequestBody UserDto dto) throws Exception {
		logger.debug("user join - 호출");
		int total = 0;

		if (userService.idCheck(dto.getUid()) == 0) {
			total = userService.join(dto);
		}
		if (total == 0) {
			return new ResponseEntity<String>(FAIL, HttpStatus.OK);
		}
		System.out.println("success");
		return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
	}

}
