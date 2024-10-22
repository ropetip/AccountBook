package com.accountbook.run;

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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class RunController {

	Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private RunService runService;

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
	
	@GetMapping("/runList.do")
	public String runList(Model model) {
		return "/run/run-list";
	}
	
	@PostMapping("/getRunList.do")
	@ResponseBody 
	public List<Map<String, Object>> getRunList(@RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request) {
		addSessionAttributesToParam(param, request);
		List<Map<String, Object>> resultListMap = runService.getRunList(param);
		return resultListMap;
	}
	
	@PostMapping("/runDetail.do")
	public String runDetailList(@RequestParam Map<String, Object> param, Model model) {
		return "/run/run-detail";
	}
	
	@PostMapping("/getRunDetail.do")
	@ResponseBody 
	public Map<String, Object> getRunDetail(@RequestParam Map<String, Object> param, HttpSession session, HttpServletRequest request) {
		// 세션 속성을 param에 추가
        addSessionAttributesToParam(param, request);
		Map<String, Object> resultMap = runService.getRunDetail(param);
		return resultMap;
	}

	@PostMapping("/saveRun.do")
	@ResponseBody
	public  Map<String, Object> saveRun(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		// 세션 속성을 param에 추가
        addSessionAttributesToParam(param, request);
        
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String runId = (String)param.get("runId");
		if("".equals(runId)) {
			resultMap = runService.insertRun(param);	
		} else {
			resultMap = runService.updateRun(param);	
		}
		
		return resultMap;
	}
	
	@PostMapping("/deleteRun.do")
	@ResponseBody
	public  Map<String, Object> deleteRun(@RequestParam Map<String, Object> param, HttpServletRequest request) {
		// 세션 속성을 param에 추가
        addSessionAttributesToParam(param, request);
        
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap = runService.deleteRun(param);
		
		return resultMap;
	}
}
