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
        
        if (session == null || session.getAttribute("usrId") == null) {
        	// 401 Unauthorized 상태 코드를 설정하여 클라이언트가 처리할 수 있게 함
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("Unauthorized: Session expired");
            response.getWriter().flush();
            
            return false; // 요청 중단
        }
        
        return true;
    }
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }
}
