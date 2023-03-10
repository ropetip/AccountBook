package com.accountbook.accbook;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class AccbookController {

	Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private AccbookService accbookService;
	
	@RequestMapping("/accbookList.do")
	public String accBookList(Model model) {
		
		return "/accbook/m-accbook-list";
	}
	
	@RequestMapping("/getAccbookList.do")
	public @ResponseBody List<Map<String, Object>> getAccbookList(@RequestParam Map<String, Object> param) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Map<String, Object>> resultList = accbookService.getAccbookList(map);
		return resultList;
	}
}
