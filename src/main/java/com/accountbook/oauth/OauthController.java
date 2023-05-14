package com.accountbook.oauth;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonParser;

@Controller
public class OauthController {
	
	Logger log = LoggerFactory.getLogger(getClass());
	public static String API_KEY = "26bdf2ba577fd4cfec9386de14115d38";
	
	@ResponseBody
	@GetMapping("/oauth/kakao")
	public void kakaoCalllback(@RequestParam String code) {
		//https://kauth.kakao.com/oauth/authorize?client_id=26bdf2ba577fd4cfec9386de14115d38&redirect_uri=http://localhost:9090/oauth/kakao&response_type=code
		log.info("code : " + code);
	}
	
	public String getKakaoAccessToken(String code) {

		String accessToken = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";

		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로 설정
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// POST 요처에 필요로 요구하는 파라미터를 스트림을 통해 전송
			BufferedWriter bw = new BufferedWriter((new OutputStreamWriter(conn.getOutputStream())));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id={code}");
			sb.append("&redirect_uri=http://localhost:8080/api/oauth/kakao");
			sb.append("&code=" + code);
			bw.write(sb.toString());
			bw.flush();

			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			log.info("responseCode : " + responseCode);

			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			String result = getRequestResult(conn);

			// Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);

			accessToken = element.getAsJsonObject().get("access_token").getAsString();

			log.info("access_token : " + accessToken);

			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return accessToken;
	}
}
