package com.accountbook.accbook;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;


@Service
@Transactional
public class AccbookService {

	Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
    private SqlSessionTemplate sqlSession;
	
	private final static String NAMESPACE = "accbook.";
	
	public List<Map<String, Object>> getAccbookList(@RequestParam Map<String, Object> param) {
		
		List<Map<String, Object>> resultMap = sqlSession.selectList(NAMESPACE + "getAccbookList", param);

		return resultMap;
	}
	
	public List<Map<String, Object>> getCommonCode(@RequestParam Map<String, Object> param) {
		
		List<Map<String, Object>> resultMap = sqlSession.selectList(NAMESPACE + "getCommonCode", param);
		System.out.println(resultMap.toString());
		return resultMap;
	}
	
	public Map<String, Object> insertAccbook(@RequestParam Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		UUID uuid = UUID.randomUUID();
        String uniqueId = uuid.toString();
		param.put("accId", uniqueId);
		
		int cnt = sqlSession.insert(NAMESPACE + "insertAccbook", param);
		if(cnt > 0) {
			resultMap.put("result_code", "S");
			resultMap.put("result_msg", "저장되었습니다.");
		} else {
			resultMap.put("result_code", "E");
			resultMap.put("result_msg", "저장에 실패하였습니다.");
		}
		return resultMap;
	}
	
	public Map<String, Object> updateAccbook(@RequestParam Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		int cnt = sqlSession.update(NAMESPACE + "updateAccbook", param);
		if(cnt > 0) {
			resultMap.put("result_code", "S");
			resultMap.put("result_msg", "저장되었습니다.");
		} else {
			resultMap.put("result_code", "E");
			resultMap.put("result_msg", "저장에 실패하였습니다.");
		}
		return resultMap;
	}
	
	public Map<String, Object> deleteAccbook(@RequestParam Map<String, Object> param) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		int cnt = sqlSession.delete(NAMESPACE + "deleteAccbook", param);
		if(cnt > 0) {
			resultMap.put("result_code", "S");
			resultMap.put("result_msg", "삭제되었습니다.");
		} else {
			resultMap.put("result_code", "E");
			resultMap.put("result_msg", "삭제에 실패하였습니다.");
		}
		return resultMap;
	}
}
