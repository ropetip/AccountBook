package com.accountbook.run;

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
public class RunService {

	Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
    private SqlSessionTemplate sqlSession;
	
	private final static String NAMESPACE = "run.";
	
	public List<Map<String, Object>> getRunList(@RequestParam Map<String, Object> param) {
		List<Map<String, Object>> resultMap = sqlSession.selectList(NAMESPACE + "getRunList", param);
		return resultMap;
	}
	
	public Map<String, Object> getRunDetail(@RequestParam Map<String, Object> param) {
		Map<String, Object> resultMap = sqlSession.selectOne(NAMESPACE + "getRunDetail", param);
		System.out.println("resultMap=>"+resultMap.toString());
		return resultMap;
	}
	
	public Map<String, Object> insertRun(@RequestParam Map<String, Object> param) {
        
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		UUID uuid = UUID.randomUUID();
        String uniqueId = uuid.toString();
		param.put("runId", uniqueId);
		
		int cnt = sqlSession.insert(NAMESPACE + "insertRun", param);
		if(cnt > 0) {
			resultMap.put("result_code", "S");
			resultMap.put("result_msg", "저장되었습니다.");
		} else {
			resultMap.put("result_code", "E");
			resultMap.put("result_msg", "저장에 실패하였습니다.");
		}
		return resultMap;
	}
	
	public Map<String, Object> updateRun(@RequestParam Map<String, Object> param) {
        
		Map<String, Object> resultMap = new HashMap<String, Object>();

		int cnt = sqlSession.update(NAMESPACE + "updateRun", param);
		if(cnt > 0) {
			resultMap.put("result_code", "S");
			resultMap.put("result_msg", "저장되었습니다.");
		} else {
			resultMap.put("result_code", "E");
			resultMap.put("result_msg", "저장에 실패하였습니다.");
		}
		return resultMap;
	}
}
