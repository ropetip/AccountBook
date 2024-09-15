package com.accountbook.common;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomErrorController implements ErrorController {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    // 설정할 제외할 리소스 경로 패턴
    private static final String[] IGNORED_PATH_PATTERNS = {
        "/resources/js/",
        "/resources/css/",
        "/resources/images/"
        // 필요한 패턴을 추가할 수 있습니다.
    };

    @RequestMapping(value = "/error")
    public String handleError(HttpServletRequest request, Model model) {
        // 에러 코드를 획득한다.
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

        // 요청된 URI를 가져옵니다.
        String requestURI = (String) request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI);
        if (requestURI == null) {
            requestURI = request.getRequestURI(); // 기본 요청 URI
        }

        // 에러 코드에 대한 상태 정보
        int statusCode = Integer.valueOf(status.toString());
        
        // 사용자 친화적인 메시지 설정
        String errorMessage = getErrorMessage(statusCode);

        // 특정 패턴에 대한 로그를 제외합니다.
        for (String pattern : IGNORED_PATH_PATTERNS) {
            if (requestURI.startsWith(pattern)) {
                break;
            }
        }

        // 에러 페이지에 표시할 정보
        model.addAttribute("status", statusCode);
        model.addAttribute("message", errorMessage);
        return "/error/error";
    }
    
    private String getErrorMessage(int statusCode) {
        switch (statusCode) {
            case 404:
                return "죄송합니다. 요청하신 페이지를 찾을 수 없습니다.";
            case 500:
                return "서버 내부 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.";
            default:
                return "문제가 발생했습니다. 관리자에게 문의해 주세요.";
        }
    }
}
