package com.accountbook.accbook;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
	@ResponseBody 
	public List<Map<String, Object>> getAccbookList(@RequestParam Map<String, Object> param) {
		List<Map<String, Object>> resultListMap = accbookService.getAccbookList(param);
		return resultListMap;
	}
	
	@RequestMapping("/getCommonCode.do")
	@ResponseBody
	public  List<Map<String, Object>> getCommonCode(@RequestParam Map<String, Object> param) {
		List<Map<String, Object>> resultListMap = accbookService.getCommonCode(param);
		return resultListMap;
	}
	
	@RequestMapping("/accbookDetail.do")
	public String accbookDetail(HttpServletRequest req) {
		System.out.println(req.getParameter("board_type"));
		System.out.println(req.getParameter("BOARD_TYPE"));
		return "/accbook/m-accbook-detail";
	}
	
	@RequestMapping("/saveAccbook.do")
	@ResponseBody
	public  Map<String, Object> saveAccbook(@RequestParam Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String accId = param.get("accId").toString();
		if("".equals(accId)) {
			resultMap = accbookService.insertAccbook(param);	
		} else {
			resultMap = accbookService.updateAccbook(param);	
		}
		
		return resultMap;
	}
}
