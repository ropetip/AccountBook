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
	
	private final static String NAMESPACE = "accbook.";
	
	public List<Map<String, Object>> getAccbookList(@RequestParam Map<String, Object> param) {
		
		List<Map<String, Object>> resultMap = sqlSession.selectList(NAMESPACE + "getAccbookList", param);

		return resultMap;
	}
}
