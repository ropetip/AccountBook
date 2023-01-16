package com.accountbook.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RootController {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@GetMapping("/")
	public String main(Model model) {
		
		return "main";
	}
	
	
}
