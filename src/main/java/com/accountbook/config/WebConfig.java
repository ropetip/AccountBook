package com.accountbook.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer{
	
	@Bean
	public FilterRegistrationBean<SitemeshConfig> sitemeshBean() {
		FilterRegistrationBean<SitemeshConfig> filter = new FilterRegistrationBean<SitemeshConfig>();
		filter.setFilter(new SitemeshConfig());
		return filter;
	}
}
