package com.accountbook.accbook;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class AccbookController {

	Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private AccbookService accbookService;
	
	// 세션 속성을 Map에 추가하는 헬퍼 메서드
	public void addSessionAttributesToParam(Map<String, Object> param, HttpServletRequest request) {
        HttpSession session = request.getSession();
        Enumeration<String> sessionAttributeNames = session.getAttributeNames();
        
        while (sessionAttributeNames.hasMoreElements()) {
            String attributeName = sessionAttributeNames.nextElement();
            Object attributeValue = session.getAttribute(attributeName);
            param.put(attributeName, attributeValue);
        }
    }
	
	@RequestMapping("/accbookList.do")
	public String accBookList(Model model) {
		return "/accbook/accbook-list";
	}
	
	@RequestMapping("/getAccbookList.do")
	@ResponseBody 
	public List<Map<String, Object>> getAccbookList(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		// 세션 속성을 param에 추가
        addSessionAttributesToParam(param, request);
        
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
		return "/accbook/accbook-detail";
	}
	
	@RequestMapping("/saveAccbook.do")
	@ResponseBody
	public  Map<String, Object> saveAccbook(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		// 세션 속성을 param에 추가
        addSessionAttributesToParam(param, request);
        
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String accId = param.get("accId").toString();
		if("".equals(accId)) {
			resultMap = accbookService.insertAccbook(param);	
		} else {
			resultMap = accbookService.updateAccbook(param);	
		}
		
		return resultMap;
	}
	
	@RequestMapping("/deleteAccbook.do")
	@ResponseBody
	public  Map<String, Object> deleteAccbook(@RequestParam Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = accbookService.deleteAccbook(param);	
		return resultMap;
	}
}
