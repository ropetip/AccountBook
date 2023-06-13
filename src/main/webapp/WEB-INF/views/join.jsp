<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>

<title>회원가입</title>

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
										<h5 class="card-title text-center pb-0 fs-4">Create an Account</h5>
										<p class="text-center small">Enter your personal details to create account</p>
									</div>

									<form class="row g-3 needs-validation" novalidate>
										<div class="col-12">
											<label for="yourName" class="form-label">닉네임</label> <input type="text" name="name" class="form-control" id="yourName" required>
											<div class="invalid-feedback">Please, enter your name!</div>
										</div>

										<div class="col-12">
											<label for="yourEmail" class="form-label">이메일</label>
											<input type="email" name="email" class="form-control" id="yourEmail" required>
											<div class="invalid-feedback">Please enter a valid Email adddress!</div>
										</div>


										<div class="col-12">
											<label for="yourPassword" class="form-label">패스워드</label> <input type="password" name="password" class="form-control" id="yourPassword" required>
											<div class="invalid-feedback">Please enter your password!</div>
										</div>
										
										<div class="col-12">
											<label for="yourPassword" class="form-label">패스워드 확인</label> <input type="password" name="password" class="form-control" id="yourPassword" required>
											<div class="invalid-feedback">Please enter your password!</div>
										</div>

										<div class="col-12">
											<div class="form-check">
												<input class="form-check-input" name="terms" type="checkbox" value="" id="acceptTerms" required> <label class="form-check-label" for="acceptTerms">I agree and accept the <a href="#">terms and conditions</a></label>
												<div class="invalid-feedback">You must agree before submitting.</div>
											</div>
										</div>
										<div class="col-12">
											<button class="btn btn-primary w-100" type="submit">Create Account</button>
										</div>
										<div class="col-12">
											<p class="small mb-0">
												Already have an account? 
												<a onclick="doKakaoLogin();"><img height="38px" src="resources/img/kakao_login_medium_narrow.png"/></a>
											</p>
										</div>
									</form>

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