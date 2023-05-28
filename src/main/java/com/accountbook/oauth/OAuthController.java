package com.accountbook.oauth;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.accountbook.config.GlobalConfig;
import com.accountbook.oauth.model.OAuthToken;
import com.accountbook.oauth.model.OAuthUserInfo;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class OAuthController {
	
	Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private GlobalConfig config;
	
	OAuthToken oauthToken = null;
	
	@GetMapping("/oauth/kakao")
	public String kakaoCallback(String code, Model model, HttpSession session) {
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
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		try {
			oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		System.out.println("카카오 엑세스 토큰: "+oauthToken.getAccess_token());
		
		RestTemplate rt2 = new RestTemplate();

		// HTTP POST를 요청할 때 보내느 데이터(body)를 설명해주는 헤더도 만들어 같이 보내준다.
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Authorization", "Bearer "+oauthToken.getAccess_token());
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest2 = new HttpEntity<>(headers2);
		
		// POST 방식으로 Http 요청한다. 그리고 response 변수의 응답 받는다.
		ResponseEntity<String> response2 = rt2.exchange(
				"https://kapi.kakao.com/v2/user/me", // https://{요청할 서버 주소}
				HttpMethod.POST, // 요청할 방식
				kakaoTokenRequest2, // 요청할 때 보낼 데이터
				String.class // 요청 시 반환되는 데이터 타입
		);
		
		ObjectMapper objectMapper2 = new ObjectMapper();
		OAuthUserInfo oauthUserInfo = null;
		
		try {
			oauthUserInfo = objectMapper2.readValue(response2.getBody(), OAuthUserInfo.class);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		System.out.println(oauthUserInfo.getKakao_account().getEmail());
		
		session.setAttribute("oauth_email", oauthUserInfo.getKakao_account().getEmail());
		session.setAttribute("oauth_nickname", oauthUserInfo.getProperties().getNickname());
		session.setAttribute("accessToken", oauthToken.getAccess_token());
		
		return "redirect:/";
	}
	
	@RequestMapping("/oauth/kakao/logout")
	public String logout(String code, Model model, HttpSession session) {
		String accessToken = (String)session.getAttribute("accessToken");
		System.out.println("accessToken=>"+accessToken);
		// POST 방식으로 key=value 데이터를 요청 (카카오쪽으로)
		// 이 때 필요한 라이브러리가 RestTemplate을 쓰면 http요청을 편하게 할 수 있다.
		RestTemplate rt = new RestTemplate();
		
		// HTTP POST를 요청할 때 보내느 데이터(body)를 설명해주는 헤더도 만들어 같이 보내준다.
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer "+accessToken);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// body 데이터를 담을 오브젝트인 MultiValueMap을 만들어보자
		// body는 보통 key, value의 쌍으로 이루어지기 때문에 자바에서 제공해주는 MultiValueMap 타입을 사용한다.
		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
		params.add("client_id", config.getOauthKakaoClientId());
		params.add("logout_redirect_uri", config.getServerUrl()+"/oauth/kakao/logout");
		
		// 요청하기 위해 헤더(Header)와 데이터(Body)를 합친다.
		// kakaoTokenRequest는 데이터(Body)와 헤더(Header)를 Entity가 된다.
		//HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);
		/*
		// POST 방식으로 Http 요청한다. 그리고 response 변수의 응답 받는다.
		ResponseEntity<String> response = rt.exchange(
				"https://kapi.kakao.com/v1/user/unlink", // https://{요청할 서버 주소}
				HttpMethod.GET, // 요청할 방식
				kakaoTokenRequest, // 요청할 때 보낼 데이터
				String.class // 요청 시 반환되는 데이터 타입
		);*/
		
		session.invalidate();
		
		return "redirect:/";
	}
}
