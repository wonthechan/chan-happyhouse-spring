package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.dto.AreaDto;
import com.ssafy.happyhouse.service.AreaService;

import io.swagger.annotations.ApiOperation;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/areas")
public class AreaController {
	
	private static final Logger logger = LoggerFactory.getLogger(QnAController.class);
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
	
	@Autowired
	private AreaService areaService; 

	@ExceptionHandler
	public ModelAndView handler(Exception ex) { // 예외 처리
		ModelAndView  mav = new ModelAndView("error/errorHandler");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}

	@ApiOperation(value = "시도 데이터 조회", response = List.class)
	@GetMapping(value = "/sido")
	public List<AreaDto> getAllSido() throws Exception {
		logger.debug("getAllSido - 호출");
		return areaService.getAllSido();
	}
	
	
	@ApiOperation(value = "구군 데이터 조회 (시도 코드 해당하는)", response = List.class)
	@GetMapping(value = "/gugun/{sidocode}")
	public List<AreaDto> getAllGugun(@PathVariable String sidocode) throws Exception {
		logger.debug("getAllGugun - 호출");
		return areaService.getAllGugun(sidocode);
	}
	
	
	@ApiOperation(value = "동 데이터 조회", response = List.class)
	@GetMapping(value = "/dong/{guguncode}")
	public List<AreaDto> getAllDong(@PathVariable String guguncode) throws Exception {
		logger.debug("getAllDong - 호출");
		return areaService.getAllDong(guguncode);
	}
    
	@ApiOperation(value = "유저가 등록한 관심지역 조회", response = List.class)
   	@GetMapping(value = "/interest/{uid}")
   	public List<AreaDto> getAllInterestArea(@PathVariable String uid) throws Exception {
		logger.debug("getAllInterestArea - 호출");
		return areaService.getAllInterestArea(uid);
   	}
	
	@ApiOperation(value = "관심 지역 등록", response = Integer.class)
   	@PostMapping(value = "/interest")
   	public int addInterestArea(@RequestBody Map<String,String> params) {
   	
		logger.debug("addInterestArea - 호출");
		
   		String uid = params.get("uid");
   		String dongcode = params.get("dongcode");
   		String dong = params.get("dong");
   		
		return areaService.addInterestArea(uid, dongcode, dong);
	}
	
	
	@ApiOperation(value = "관심 지역 삭제", response = Integer.class)
   	@DeleteMapping(value = "/interest")
   	public int deleteInterestArea(@RequestBody Map<String,String> params) {
		logger.debug("deleteInterestArea - 호출");
   		String uid = params.get("uid");
   		String dongcode = params.get("dongcode");
   		
   		return areaService.deleteInterestArea(uid, dongcode);
   	}
}
