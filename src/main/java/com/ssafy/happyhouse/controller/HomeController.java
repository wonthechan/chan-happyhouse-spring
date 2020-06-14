package com.ssafy.happyhouse.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.dto.UserDto;
import com.ssafy.happyhouse.service.KakaoApiService;

import io.swagger.annotations.ApiOperation;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(QnAController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
	
	
	@ApiOperation(value = "메인 페이지로 이동.", response = String.class)
	@RequestMapping(value="/")
	public String moveToIndexPage() throws Exception{
		logger.debug("moveToIndexPage - 호출");
		return "index";
	}
	
	@ApiOperation(value = "관심지역 페이지로 이동.", response = String.class)
	@GetMapping("/interest-area/register")
	public String moveToInterestAreaRegisterPage(HttpSession session) throws Exception {
		logger.debug("moveToInterestAreaRegisterPage - 호출");
		UserDto userDto = (UserDto)session.getAttribute("userDto");
		session.setAttribute("uid", userDto.getUid());
		return "etc/interestarea";
	}
	
	@ApiOperation(value = "상권 조회 페이지로 이동", response = String.class)	
	@GetMapping("/store")
	public String moveToStoreListPage(HttpSession session) throws Exception {
		logger.debug("moveToStoreListPage - 호출");
		if (session.getAttribute("userDto") == null) {
			return "index";
		}
		return "etc/storeinfo";
	}
	
	@ApiOperation(value = "회원 가입 페이지로 이동", response = String.class)	
	@GetMapping("/users/join")
	public String moveToUserJoinPage() throws Exception {
		logger.debug("moveToUserJoinPage - 호출");
		return "user/join";
	}
	
	@ApiOperation(value = "마이 페이지로 이동", response = String.class)	
	@RequestMapping(value="/users/mypage")
	public String mypage() {
		logger.debug("mypage - 호출");
		return "user/mypage";
	}

	@ApiOperation(value = "로그아웃", response = String.class)	
	@GetMapping(value="/users/logout")
	public String logout(HttpSession session) {
		logger.debug("logout - 호출");
		session.invalidate();
		return "redirect:/";
	}
	
	@ApiOperation(value = "qna 페이지로 이동", response = String.class)	
	@RequestMapping(value="/qna")
	public String qna() {
		logger.debug("qna - 호출");
		return "redirect:/resource/qna/index.html";
	}

	
}


