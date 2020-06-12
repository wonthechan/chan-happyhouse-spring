package com.ssafy.happyhouse.service;

import java.util.HashMap;

public interface KakaoApiService {
	public String getAccessToken(String authorize_code);
	public HashMap<String, Object> getUserInfo (String access_Token);
}
