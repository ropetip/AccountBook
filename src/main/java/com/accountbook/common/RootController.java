package com.accountbook.common;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.accountbook.config.GlobalConfig;

@Controller
public class RootController {

	Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private GlobalConfig config;
	
	@RequestMapping("/")
	public String index(Model model) {
		return "main";
	}
	
	@RequestMapping("/join.do")
	public String join(Model model) {
		
		model.addAttribute("CLIENT_ID", config.getOauthKakaoClientId());
		model.addAttribute("SERVER_URL", config.getServerUrl());
		
		return "join";
	}
	
	
}
