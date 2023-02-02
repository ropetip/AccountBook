package com.accountbook.accbook;

import java.util.List;
import java.util.Map;

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
	
	 private final static String NAMESPACE = "Accbook.";
	
	public List<Map<String, Object>> getAccbookList(@RequestParam Map<String, Object> param) {
		
		List<Map<String, Object>> listmap = sqlSession.selectList(NAMESPACE + "getList");

		return listmap;
	}
	
}
