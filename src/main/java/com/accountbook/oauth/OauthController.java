package com.accountbook.oauth;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.accountbook.config.GlobalConfig;

@Controller
public class OAuthController {
	
	Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private GlobalConfig config;
	
	@GetMapping("/oauth/kakao")
	@ResponseBody
	public String kakaoCallback(String code) {
		// POST 방식으로 key=value 데이터를 요청 (카카오쪽으로)
		// 이 때 필요한 라이브러리가 RestTemplate을 쓰면 http요청을 편하게 할 수 있다.
		RestTemplate rt = new RestTemplate();
		
		// HTTP POST를 요청할 때 보내느 데이터(body)를 설명해주는 헤더도 만들어 같이 보내준다.
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// body 데이터를 담을 오브젝트인 MultiValueMap을 만들어보자
		// body는 보통 key, value의 쌍으로 이루어지기 때문에 자바에서 제공해주는 MultiValueMap 타입을 사용한다.
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", config.getOauthKakaoClientId());
		params.add("redirect_uri", config.getServerUrl()+"/oauth/kakao");
		params.add("code", code);
		
		// 요청하기 위해 헤더(Header)와 데이터(Body)를 합친다.
		// kakaoTokenRequest는 데이터(Body)와 헤더(Header)를 Entity가 된다.
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);
		
		// POST 방식으로 Http 요청한다. 그리고 response 변수의 응답 받는다.
		ResponseEntity<String> response = rt.exchange(
				"https://kauth.kakao.com/oauth/token", // https://{요청할 서버 주소}
				HttpMethod.POST, // 요청할 방식
				kakaoTokenRequest, // 요청할 때 보낼 데이터
				String.class // 요청 시 반환되는 데이터 타입
		);
		
		System.out.println(response);
		
		return "카카오 토큰 요청 완료 : 토큰 요청에 대한 응답 : "+response;
	}
}
