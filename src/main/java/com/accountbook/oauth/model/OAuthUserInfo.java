package com.accountbook.oauth.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class OAuthUserInfo {
	private Long id;
    private String connected_at;
    private Properties properties;
    private KakaoAccount kakao_account;

    @Data
    public static class Properties {
        private String nickname;
    }

    @Data
    public static class KakaoAccount {
        @JsonProperty("profile_nickname_needs_agreement")
        private boolean profileNicknameNeedsAgreement;
        private Profile profile;
        @JsonProperty("has_email")
        private boolean hasEmail;
        @JsonProperty("email_needs_agreement")
        private boolean emailNeedsAgreement;
        @JsonProperty("is_email_valid")
        private boolean isEmailValid;
        @JsonProperty("is_email_verified")
        private boolean isEmailVerified;
        @JsonProperty("email")
        private String email;
        @JsonProperty("id_token")
        public String idToken;
    }

    @Data
    public static class Profile {
        private String nickname;
        private String is_default_nickname;
    }
}
