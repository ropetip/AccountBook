<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<title>로그인</title>
<style>
.btn_gate.kakao span {
    display: inline-block;
    background: url(../resources/img/login/kakaotalk_sharing_btn_small.png) no-repeat left 14px;
    vertical-align: top;
    padding-left: 45px;
}

.btn_gate.kakao {
    background: #FFEB00;
    border: 1px solid #FFEB00;
}

.btn_gate {
    display: block;
    width: 100%;
    height: 60px;
    text-align: center;
    color: #323232;
    line-height: 61px;
    font-size: 16px;
    border-radius: 4px;
    margin: 0 0 14px 0;
}
</style>
<script>
$(document).ready(function () {
});
function doKakaoLogin() {
	const url = "https://kauth.kakao.com/oauth/authorize?client_id=${CLIENT_ID}&redirect_uri=${SERVER_URL}/oauth/kakao&response_type=code"; 
	location.href = url;
}
</script>

</head>

<body>
<main>
		<div class="container">

			<section class="section register min-vh-50 d-flex flex-column align-items-center justify-content-center py-4">
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

							<div class="card mb-3">

								<div class="card-body">

									<div class="pt-4 pb-2">
										<h5 class="card-title text-center pb-0 fs-4">간편하게 로그인을 시작합니다.</h5>
									</div>
									
									<div class="col-12">
										<p class="mt-3 text-center">
											<a onclick="doKakaoLogin();"><img height="60px" src="resources/img/login/kakao_login_large_narrow.png" /></a>
										</p>
									</div>

								</div>
							</div>

						</div>
					</div>
				</div>

			</section>

		</div>
</main>	
	<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
   <script src="resources/js/main.js"></script>
</body>

</html>