<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>

<title>회원가입</title>

<script>
$(document).ready(function () {
	/* document.querySelector('form').addEventListener('submit', function(event) {
		if (!event.target.checkValidity()) {
			event.preventDefault(); // 폼 제출 방지
			document.querySelector('button[type="submit"]').classList.add('invalid'); // :invalid 클래스 추가
		}
	}); */
});

function doLogin() {
	CO.ajaxSubmit("/oauth/kakao", data, (result) => {
  		// 성공 콜백 함수
    	alert(result.result_msg);
    	hideModal("dataModal");
    	doSearch();
  	}, (xhr, status, error) => {
  		// 실패 콜백 함수
  	    alert("서버와의 통신이 실패하였습니다. (" + error + ")");
  	});
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
											<label for="yourName" class="form-label">Your Name</label> <input type="text" name="name" class="form-control" id="yourName" required>
											<div class="invalid-feedback">Please, enter your name!</div>
										</div>

										<div class="col-12">
											<label for="yourEmail" class="form-label">Your Email</label> <input type="email" name="email" class="form-control" id="yourEmail" required>
											<div class="invalid-feedback">Please enter a valid Email adddress!</div>
										</div>

										<div class="col-12">
											<label for="yourUsername" class="form-label">Username</label>
											<div class="input-group has-validation">
												<span class="input-group-text" id="inputGroupPrepend">@</span> <input type="text" name="username" class="form-control" id="yourUsername" required>
												<div class="invalid-feedback">Please choose a username.</div>
											</div>
										</div>

										<div class="col-12">
											<label for="yourPassword" class="form-label">Password</label> <input type="password" name="password" class="form-control" id="yourPassword" required>
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
												Already have an account? <a onclick="doLogin();">Log in</a>
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