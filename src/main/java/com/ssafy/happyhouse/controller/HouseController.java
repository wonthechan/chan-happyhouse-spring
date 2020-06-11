package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.dto.HouseDeal;
import com.ssafy.happyhouse.dto.HouseInfo;
import com.ssafy.happyhouse.dto.HousePageBean;
import com.ssafy.happyhouse.service.HouseService;

import io.swagger.annotations.ApiOperation;


@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/houses")
public class HouseController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(QnAController.class);
	
	@Autowired
	private HouseService houseService;
	
	
	@ApiOperation(value = "검색 결과 모든 아파트의 정보를 반환한다.", response = List.class)
	@PostMapping(value="/search")
	public ResponseEntity<List<HouseDeal>> search(@RequestBody Map<String,String> params) throws Exception {
		
		logger.debug("house search - 호출");
		
		String order = params.get("order");
		int pageNo = Integer.parseInt(params.get("pageNo"));
		String searchField = params.get("searchField");
		String searchText = params.get("searchText");
		
		List<HouseDeal> result = null;
		boolean[] searchType={true, true, false, false};		
		HousePageBean bean = new HousePageBean();
		bean.setSearchType(searchType);
		
		switch(searchField) {
		case "dong":
			bean.setDong(searchText);
			break;
		case "aptName":
			bean.setAptName(searchText);
			break;
		}
		
		bean.setPageNo(pageNo*10);
		if(order.equals("")) {
			result = houseService.search(bean);
		}else {
			bean.setOrder(order);
			result = houseService.searchOrderByDeal(bean);	
		}
		
		return new ResponseEntity<List<HouseDeal>>(result, HttpStatus.OK);
	}
	
	
	@ApiOperation(value = "검색 결과 모든 아파트의 개수를 반환한다.", response = Integer.class)
	@PostMapping(value="/count")
	public ResponseEntity<Integer> searchCount(@RequestBody Map<String,String> params) throws Exception {
		
		logger.debug("house searchCount - 호출");
		
		String searchField = params.get("searchField");
		String searchText = params.get("searchText");
		
		int totalCnt=0;
		boolean[] searchType={true, true, false, false};		
		HousePageBean bean = new HousePageBean();
		bean.setSearchType(searchType);
		
		switch(searchField) {
		case "dong":
			bean.setDong(searchText);
			break;
		case "aptName":
			bean.setAptName(searchText);
			break;
		}
		
		totalCnt = houseService.searchCount(bean);
		
		return new ResponseEntity<Integer>(totalCnt, HttpStatus.OK);
	}
	

	@ApiOperation(value = "아파트 번호에 해당하는 아파트 정보를 반환한다.", response = HouseDeal.class)
	@GetMapping(value = "/detail/{no}")
   	public ResponseEntity<HouseDeal> detail(@PathVariable int no) throws Exception {
		
		logger.debug("house detail - 호출");
		HouseDeal result = houseService.detail(no);
		
		String aptname = result.getAptName();
		String img = houseService.searchAptImg(aptname);
		result.setImg(img);
		
		return new ResponseEntity<HouseDeal>(result, HttpStatus.OK);
	
	}
	
	@ApiOperation(value = "검색 결과 아파트들을 중복 없이 반환한다.", response = List.class)
	@PostMapping(value="/map")
	public ResponseEntity<List<HouseInfo>> map(@RequestBody Map<String,String> params) throws Exception {

		logger.debug("house map - 호출");
		
		String searchField = params.get("searchField");
		String searchText = params.get("searchText");
		
		List<HouseInfo> result = null;
		boolean[] searchType={true, true, false, false};		
		HousePageBean bean = new HousePageBean();
		bean.setSearchType(searchType);
		
		switch(searchField) {
		case "dong":
			bean.setDong(searchText);
			break;
		case "aptName":
			bean.setAptName(searchText);
			break;
		}
		result = houseService.searchDistinct(bean);
		
		return new ResponseEntity<List<HouseInfo>>(result, HttpStatus.OK);
}
	
	
}
