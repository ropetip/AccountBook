package com.accountbook.test;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestController {

	Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/test.do")
	public String accBookList(Model model) {
		return "test";
	}
	// TODO: Visualping으로 카톡알림 가자
	@RequestMapping("getCrawling.do")
    @ResponseBody
    public Map<String, Object> getCrawling(@RequestParam Map<String, Object> param, HttpSession session) {
        Map<String, Object> resultMap = new HashMap<>();
        
        // URL 파라미터를 받아옵니다.
        String url = (String) param.get("url");
        
        if (url == null || url.isEmpty()) {
        	resultMap.put("status", "error");
            resultMap.put("message", "URL parameter is missing or empty.");
            return resultMap;
        }
        String loginUrl = "http://alm.emro.co.kr/login.jsp";
        
        try {
        	 // 로그인 요청
            Connection.Response loginResponse = Jsoup.connect(loginUrl)
                    .data("username", "jlee@emro.co.kr")
                    .data("password", "1111")
                    .method(Connection.Method.POST)
                    .execute();

            // 로그인 세션 쿠키 추출
            Map<String, String> cookies = loginResponse.cookies();
            
            // Jsoup을 사용하여 URL의 HTML 문서를 가져옵니다.
            Document doc = Jsoup.connect(url)
                .userAgent("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36")
                .header("Accept-Language", "en-US,en;q=0.5")
                .header("Referer", "http://alm.emro.co.kr")
                .timeout(10 * 1000)
                .cookies(cookies)
                .get();
            
            // Document를 HTML 문자열로 변환합니다.
            String htmlContent = doc.html();
            
            System.out.println("htmlContent=>"+htmlContent);
            System.out.println("cookies==>"+cookies);
            
            // JSON 문자열을 Map에 담아 반환합니다.
            resultMap.put("status", "success");
            resultMap.put("data", htmlContent);
            
			/*// ObjectMapper를 사용하여 HTML 문자열을 JSON으로 직렬화합니다.
			ObjectMapper objectMapper = new ObjectMapper();
			ObjectNode objNode = objectMapper.createObjectNode();
			objNode.put("data", htmlContent);
			
			// JSON 문자열로 변환합니다.
			String jsonString = objectMapper.writeValueAsString(objNode);*/

            
        } catch (IOException e) {
            e.printStackTrace();
            resultMap.put("status", "error");
            resultMap.put("error", "An error occurred while fetching the URL.");
        }

        return resultMap;
    }
	
	
}
