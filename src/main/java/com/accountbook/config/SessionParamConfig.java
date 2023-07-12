package com.accountbook.config;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

public class SessionParamConfig implements HandlerMethodArgumentResolver {

    @Autowired
    private HttpSession session;

    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        return parameter.getParameterType().equals(String.class) && parameter.hasParameterAnnotation(SessionAttribute.class);
    }

    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer modelAndViewContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        SessionAttribute sessionAttribute = parameter.getParameterAnnotation(SessionAttribute.class);
        String attributeName = sessionAttribute.value();
        String sessionValue = (String) session.getAttribute(attributeName);
        return "g." + sessionValue;
    }
}