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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.dto.UserDto;
import com.ssafy.happyhouse.service.KakaoApiService;
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
	private UserService  userService;

	@Autowired
	private KakaoApiService kakao;

	//@RequestBody로 수정을...해야하는데...어떻게..?
	@ApiOperation(value = "카카오 계정으로 로그인을 시도하고 성공시 세션에 아이디와 이름을 (userDto로)저장한다.", response = String.class) 
	@PostMapping(value="/login/kakao")
	public ResponseEntity<UserDto> login(@RequestBody Map <String,String> map, HttpSession session) {
		
		
		logger.debug("user kakao login - 호출");
		String access_token = map.get("access_token");
		HashMap<String, Object> userInfo = kakao.getUserInfo(access_token);
		UserDto userDto = new UserDto();
		
	
		//클라이언트의 이메일이 존재할 때 세션에 해당 계정과 토큰 등록
		if (userInfo.get("email") != null) {
			 
			String id = (String)userInfo.get("email");
			id = id.substring(0,id.indexOf("@"));
			
			userDto.setUid(id);
			userDto.setUname((String)userInfo.get("nickname"));
			
			if(userService.idCheck(id)==0) {
				userService.join(userDto);
			}
			
			session.setAttribute("userDto", userDto);
		    session.setAttribute("access_Token", access_token);
		  }
		
		 return new ResponseEntity<UserDto>(userDto, HttpStatus.OK);
		 
	}
	
	@ApiOperation(value = "유저 아이디와 패스워드로 로그인을 시도하고, 성공시 세션에 userDto로 정보를 저장한다.", response = String.class)
	@PostMapping(value="/login")
	public ResponseEntity<UserDto> login(@RequestBody UserDto user, HttpSession session) throws Exception {
	
	logger.debug("user login - 호출");
	Map<String, String> loginMap = new HashMap<String, String>();
    loginMap.put("uid", user.getUid());
    loginMap.put("upassword", user.getUpassword());
    UserDto userDto = userService.login(loginMap);
    
    //if( userDto == null ) {
    //	return new ResponseEntity<String>(FAIL, HttpStatus.OK);
    //}
    session.setAttribute("userDto", userDto);
	//return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
    System.out.println(userDto);
    return new ResponseEntity<UserDto>(userDto, HttpStatus.OK);
	}
	

	
	@ApiOperation(value = "사용자의 uid와 uname 정보가 일치할 때만 비밀번호를 반환한다.", response = String.class)
	@GetMapping(value="/{findid}/{findname}")
	public ResponseEntity<String> findPw(@PathVariable String findid, @PathVariable String findname) {
		
		logger.debug("user findPw - 호출");
		Map<String, String> map = new HashMap<String, String>();
		map.put("uid", findid);
	    map.put("uname", findname);
		String upassword = userService.findPw(map);
		
		if( upassword == null ) {
			return new ResponseEntity<String>(HttpStatus.NO_CONTENT);
	    }
	        
	    return new ResponseEntity<String>(upassword, HttpStatus.OK);
	    
		
		
	}
	@ApiOperation(value = " 사용자가 마이페이지에서 정보를 수정하고,입력한 비밀번호가 사용자 정보와 일치할때 수정한다.", response = String.class)
	@PutMapping(value = "/update")
	public ResponseEntity <String> update(@RequestBody UserDto dto,HttpSession session) throws Exception {
		
		logger.debug("user update - 호출");
		
		int total = userService.update(dto);
		
		if (total==0) {
   			return new ResponseEntity<String>(FAIL, HttpStatus.OK);
   		}
		session.setMaxInactiveInterval(0);
		session.setAttribute("userDto", dto);
   		return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
   	}
	
	@ApiOperation(value = "사용자의 아이디와 비밀번호를 받아 DB에 회원 정보가 일치하면 삭제한다.", response = String.class)
	@DeleteMapping(value = "/delete")
	public ResponseEntity <String> delete(@RequestBody Map<String,String> params) throws Exception {
		logger.debug("user delete - 호출");
		Map<String, String> map = new HashMap<String, String>();
	    map.put("uid", params.get("uid"));
	    map.put("upassword", params.get("upassword"));
	    
		int total = userService.delete(map);
		
		
   		if (total==0) {
   			return new ResponseEntity<String>(FAIL, HttpStatus.OK);
   		}
   		
   		return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
		
	}
	
	@ApiOperation(value = "사용자의 정보를 받아 회원 가입한다.", response = String.class)
	@PostMapping(value = "/join")
   	public ResponseEntity <String> join(@RequestBody UserDto dto) throws Exception {
		logger.debug("user join - 호출");
		int total = userService.join(dto);

   		if (total==0) {
   			return new ResponseEntity<String>(FAIL, HttpStatus.OK);
   		}
   	
   		return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
   	}
	
	
	
}
