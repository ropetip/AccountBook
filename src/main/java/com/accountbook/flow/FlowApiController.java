package com.accountbook.flow;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Flow Api를 활용하여 Flow 알림 기능을 하는 Controller
 */
@Controller
public class FlowApiController {

	// private final Logger log =
	// LoggerFactory.getLogger(this.getClass().getSimpleName());
	private static final Logger log = LoggerFactory.getLogger("========Log=========");

	/**
	 * jira 이슈 및 comment 등록 시 해당 정보를 받는다.
	 * 
	 * @param param
	 */
	@RequestMapping(value = "jiraWebhookReceiver.do")
	public @ResponseBody void getJiraApi(@RequestBody Map param) {
		JSONObject jsonObject = new JSONObject(param);
		JSONObject issue = jsonObject.getJSONObject("issue");
		String jiraNo = (String) issue.get("key");

		log.info("jsonObject===>" + jsonObject.toString());

		Map<String, Object> map = new HashMap<String, Object>();

		String BOT_ID = "testbot";
		String[] RCVR_USER_ID = { "jlee@emro.co.kr" };
		String CNTN = "테스트";
		String PREVIEW_LINK = "http://alm.emro.co.kr/browse/" + jiraNo;
		String PREVIEW_TTL = "제목";

		for (int i = 0; i < RCVR_USER_ID.length; i++) {
			map.put("BOT_ID", BOT_ID);
			map.put("RCVR_USER_ID", RCVR_USER_ID[i]);
			map.put("CNTN", CNTN);
			map.put("PREVIEW_LINK", PREVIEW_LINK);
			map.put("PREVIEW_TTL", PREVIEW_TTL);
			map.put("PREVIEW_CNTN", CNTN);

			send(map);
		}
	}

	/**
	 * Flow로 알림을 보낸다.
	 * 
	 * @param map
	 * @return
	 */
	public static String send(Map<String, Object> map) {

		JSONObject mReqMsg = new JSONObject();
		String strReqJsonMsg;
		String strRsltString = "";

		String API_KEY = "FLOW_BOT_NOTI_API";
		String CNTS_CRTC_KEY = "20210824-d3c5eb06-b3b1-4f6e-9ba7-a61e2b71c78f";

		mReqMsg.put("API_KEY", API_KEY);
		mReqMsg.put("CNTS_CRTC_KEY", CNTS_CRTC_KEY);
		mReqMsg.put("REQ_DATA", map);

		strReqJsonMsg = mReqMsg.toString();

		try {
			String data = "JSONData=" + URLEncoder.encode(strReqJsonMsg, "UTF-8");
			URL myUrl = new URL("https://flow.emro.co.kr/MGateway");
			HttpURLConnection con = (HttpURLConnection) myUrl.openConnection();
			con.setRequestMethod("POST");
			con.setDoOutput(true);
			con.setUseCaches(false);
			con.setConnectTimeout(1000);

			try (AutoCloseable conc = con::disconnect) {
				try (DataOutputStream dos = new DataOutputStream(con.getOutputStream())) {
					dos.writeBytes(data);
					dos.flush();
				}
				try (InputStream ips = con.getInputStream();
						BufferedReader in = new BufferedReader(new InputStreamReader(ips, "UTF-8"))) {
					String line;
					StringBuilder sb = new StringBuilder();
					while ((line = in.readLine()) != null) {
						sb.append(line);
					}
					strRsltString = sb.toString();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return strRsltString;
	}
}