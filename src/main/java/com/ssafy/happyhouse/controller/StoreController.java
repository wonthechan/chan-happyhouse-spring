package com.ssafy.happyhouse.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.dto.StoreInfo;
import com.ssafy.happyhouse.service.StoreService;

import io.swagger.annotations.ApiOperation;


@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/stores")
public class StoreController {
	
	private static final Logger logger = LoggerFactory.getLogger(QnAController.class);
	
	@Autowired
	private StoreService storeService; 

	@ExceptionHandler
	public ModelAndView handler(Exception ex) { // 예외 처리
		ModelAndView  mav = new ModelAndView("error/errorHandler");
		mav.addObject("msg", ex.getMessage());
		ex.printStackTrace();
		return mav;
	}
	
	@ApiOperation(value = "동이름으로 상권 조회 (offset과 limit 지정).", response = List.class)
	@GetMapping("/{dongcode}/{offset}/{limit}")
	public List<StoreInfo> searchStores(@PathVariable String dongcode, @PathVariable int offset, @PathVariable int limit) throws Exception {
		logger.debug("searchStores - 호출");
		return storeService.findStoresByDong(dongcode, offset, limit);
	}
	
	@ApiOperation(value = "동이름으로 상권 조회 결과 행 개수 반환 (동이름에 한글이 포함된 경우 프론트에서 인코딩 후 넘겨줘야 함)", response = Integer.class)
	@GetMapping("/count/{dongcode}")
	public int searchStoresTotalCnt(@PathVariable String dongcode) throws Exception {
		logger.debug("searchStoresTotalCnt - 호출");
		return storeService.searchStoresTotalCnt(dongcode);
	}
	
	@ApiOperation(value = "상점 no값을 통해 상세 정보 반환", response = StoreInfo.class)
	@GetMapping("/{no}")
	public StoreInfo getEveryDetail(@PathVariable int no) throws Exception {
		logger.debug("getEveryDetail - 호출");
		return storeService.getEveryDetail(no);
	}
}
