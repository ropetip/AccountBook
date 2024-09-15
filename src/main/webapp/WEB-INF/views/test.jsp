<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="resources/js/main.js"></script>
<script>
$(document).ready(function () {
});

function doCrawling() {
	const data = {};
	data.url = "http://alm.emro.co.kr/issues/?filter=13906";
	CO.ajaxSubmit("getCrawling.do", data, (result) => {
		// 성공 콜백 함수
		if (result.status === 'error') {
            // 오류 메시지 표시
            alert("Error: " + result.message);
        } else {            
        	document.getElementById("content").innerHTML = result.data;

        }
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
				
					<!-- 본문 영역 -->
					<div class="col-12">
						<p class="mt-3 text-center">
							<a onclick="doCrawling();">크롤링</a>
						</p>
						
						<div id="content">
						
						</div>
						
					</div>
						
				</div>
			</div>

		</section>

	</div>
</main>	
	<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
</body>

</html>