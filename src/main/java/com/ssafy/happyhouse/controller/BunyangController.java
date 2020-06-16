package com.ssafy.happyhouse.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.dto.Bunyang;
import com.ssafy.happyhouse.service.BunyangService;

import io.swagger.annotations.ApiOperation;


@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/bunyang")
public class BunyangController {
	
	private static final Logger logger = LoggerFactory.getLogger(QnAController.class);
	
	@Autowired
	private BunyangService bunyangService; 

	@ApiOperation(value = "한 페이지의 모든 분양정보를 가져온다. ", response = List.class)
	@GetMapping("/all/{offset}/{limit}")
	public List<Bunyang> getAllBunyang(@PathVariable int offset, @PathVariable int limit) throws Exception {
		logger.debug("getAllBunyang - 호출");
		List<Bunyang> result = bunyangService.getAllBunyang(offset, limit);
		return result;
	}
	
	@ApiOperation(value = "모든 분양정보를 가져온다. ", response = List.class)
	@GetMapping("/all")
	public List<Bunyang> getBunyang() throws Exception {
		logger.debug("getBunyang - 호출");
		List<Bunyang> result = bunyangService.getBunyang(); 
		for(Bunyang b : result) {
			switch(b.getBstate()) {
			case "오픈":
				b.setBstate("kit__utils__donut kit__utils__donut--danger");
				break;
			case "공고":
				b.setBstate("kit__utils__donut kit__utils__donut--primary");
				break;
			case "접수":
				b.setBstate("kit__utils__donut kit__utils__donut--orange");
				break;
			case "발표":
				b.setBstate("kit__utils__donut kit__utils__donut--success");
				break;
			case "계약":
				b.setBstate("kit__utils__donut kit__utils__donut--info");
				break;
			}
		}		
		return result;
	}
	
	@ApiOperation(value = "모든 분양정보의 개수를 가져온다. ", response = Integer.class)
	@GetMapping("/count")
	public int getAllBunyangCount() throws Exception {
		logger.debug("getAllBunyangCount - 호출");
		return bunyangService.getAllBunyangCount();
	}
	
	@ApiOperation(value = "최신 분양정보 3개를 가져온다. ", response = List.class)
	@GetMapping("/recently")
	public List<Bunyang> getRecentlyBunyang() throws Exception {
		logger.debug("getRecentlyBunyang - 호출");
		return bunyangService.getRecentlyBunyang();
	}
	
	
}

	