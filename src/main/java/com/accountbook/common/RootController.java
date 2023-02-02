package com.accountbook.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RootController {

	Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/")
	public String index(Model model) {
		
		 return "main";
	}
	
}
