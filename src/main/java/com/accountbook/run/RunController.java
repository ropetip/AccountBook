package com.accountbook.run;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class RunController {

	Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private RunService runService;
	
	@GetMapping("/runList.do")
	public String accBookList(Model model) {
		return "/run/run-list";
	}
	
	@GetMapping("/getrunList.do")
	@ResponseBody 
	public List<Map<String, Object>> getAccbookList(@RequestParam Map<String, Object> param, HttpSession session) {
		param.put("usrId", (String)session.getAttribute("oauth_email"));
		List<Map<String, Object>> resultListMap = runService.getAccbookList(param);
		return resultListMap;
	}
	
	@GetMapping("/runDetail.do")
	public String runDetailList(@RequestParam Map<String, Object> param, Model model) {
		model.addAttribute("param", param);
		return "/run/run-detail";
	}
}
