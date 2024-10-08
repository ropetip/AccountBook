package com.accountbook.oauth.model;

import lombok.Data;

@Data
public class OAuthToken {
	private String access_token;
	private String token_type;
	private String refresh_token;
	private String expires_in;
	private String scope;
	private String refresh_token_expires_in;
	private String id_token;
}
