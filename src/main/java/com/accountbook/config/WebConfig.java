package com.accountbook.config;

import java.util.concurrent.TimeUnit;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer{
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/**")
				  .addResourceLocations("classpath:/templates/")
				  .setCacheControl(CacheControl.maxAge(10, TimeUnit.MINUTES));
	}

	@Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new Interceptor()).excludePathPatterns("/", "/oauth/**", "/resources/**", "/login**", "/join**", "/error**");
    }
	
	@Bean
	FilterRegistrationBean<SitemeshConfig> sitemeshBean() {
		FilterRegistrationBean<SitemeshConfig> filter = new FilterRegistrationBean<SitemeshConfig>();
		filter.setFilter(new SitemeshConfig());
		return filter;
	}
	
	@Bean
	GlobalConfig config() {
		return new GlobalConfig();
	}
	@Bean
	SessionParamConfig sessionParameterInjector() {
	    return new SessionParamConfig();
	}
}
