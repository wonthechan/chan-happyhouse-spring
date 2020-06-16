package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.dto.ApartMontlyAvgDto;
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
	private static final String SUCCESS = "success";
	private static final String FAIL = "fail";
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
		
		bean.setPageNo(pageNo*12);
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
		result.setImg("@/img/apt/".concat(img));
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
	@ApiOperation(value = "관심 아파트의 정보를 받아 등록한다.", response = String.class)
	@PostMapping(value="/interest/insert")
	public ResponseEntity<String> insertInterestHouse(@RequestBody Map<String,String> params) throws Exception {

		logger.debug("house interest insertInterestHouse - 호출");
		String uid = params.get("uid");
   		int no = Integer.parseInt(params.get("no"));
   		System.out.println(uid+" "+no);
		int total = houseService.interestInsert(uid,no);
		
		if (total==0) {
   			return new ResponseEntity<String>(FAIL, HttpStatus.OK);
   		}
   		return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
	}
	
	
	@ApiOperation(value = "관심 아파트 삭제", response = String.class)
   	@DeleteMapping(value = "/interest/delete/{uid}/{no}")
   	public ResponseEntity<String> deleteInterestHouse(@PathVariable String uid,@PathVariable int no) throws Exception{
		logger.debug("house interest deleteInterestHouse - 호출");
   		int total = houseService.interestDelete(uid,no);
   		
   		if (total==0) {
   			return new ResponseEntity<String>(FAIL, HttpStatus.OK);
   		}
   		return new ResponseEntity<String>(SUCCESS, HttpStatus.OK);
   	}
	
	
	@ApiOperation(value = "등록된 유저의 관심 아파트 조회", response = List.class)
   	@GetMapping(value = "/interest/{uid}")
   	public ResponseEntity<List<HouseDeal>> interestFindAll(@PathVariable String uid) throws Exception {
		logger.debug("findAllInterestHouse - 호출");
		List<HouseDeal> result = houseService.interestFindAll(uid);
		
		return new ResponseEntity<List<HouseDeal>>(result, HttpStatus.OK);
   	}
	
	@ApiOperation(value = "2019년 서울시 자치구 월별 평균 아파트 거래 금액 조회", response = List.class)
   	@GetMapping(value = "/apart/montly/avg")
	public ResponseEntity<List<ApartMontlyAvgDto>> searchApartMonthlyAvg() throws Exception {
		logger.debug("searchApartMonthlyAvg - 호출");
		List<ApartMontlyAvgDto> result = houseService.searchApartMonthlyAvg();
		
		return new ResponseEntity<List<ApartMontlyAvgDto>>(result, HttpStatus.OK);
   	}
}
