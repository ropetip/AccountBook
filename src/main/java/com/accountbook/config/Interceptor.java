package com.accountbook.config;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class Interceptor implements HandlerInterceptor {
	
	Logger log = LoggerFactory.getLogger(getClass());
	
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	// 세션에서 로그인 정보를 확인합니다.
        HttpSession session = request.getSession(false); // 세션이 없을 때는 새로 만들지 않음
        
        // 세션이 없으면 401 상태 코드로 응답
        if (session == null || session.getAttribute("usrId") == null) {
        	// AJAX 요청인지 확인
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            	log.info("no Session 401 Error");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401 상태 코드
                return false; // 요청 차단
            } else {
	        	// 스크립트를 작성하여 alert 후 리다이렉트
	            response.setContentType("text/html;charset=UTF-8");
	            response.setCharacterEncoding("UTF-8"); // 응답 인코딩 설정
	            response.getWriter().write("<script>alert('세션이 만료되었습니다. 다시 로그인 해주세요.'); window.location.href='/login.do';</script>");
	            response.getWriter().flush();
	            
	            return false; // 요청 차단
            }
        }

        return true;
    }
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }
}
