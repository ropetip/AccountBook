<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문제 발생</title>
    <!-- Vendor CSS Files -->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="resources/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet"/>
    
      <style>
        body {
            background: #f5f5f5; /* 흰색 배경 */
            color: #333;
            font-family: 'Roboto', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }
        .error-content {
            text-align: center;
            max-width: 80%;
            padding: 20px;
            background: #fff; /* 흰색 배경 */
            border-radius: 8px; /* 모서리 둥글게 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 약간의 그림자 */
        }
        .error-content .icon {
            font-size: 8rem; /* Large icon size */
            color: #f39c12; /* 밝은 색상 */
            margin-bottom: 20px;
        }
        .error-content h1 {
            font-size: 4rem; /* Large title size */
            color: #e74c3c; /* 에러 색상 */
            margin-bottom: 20px; /* 헤더와 본문 사이 간격 */
            font-weight: bold;
        }
        .error-content p {
            font-size: 1.5rem; /* Large text size */
            color: #333; /* 어두운 색상 */
            margin: 20px 0; /* 본문과 버튼 사이 간격 */
        }
        .btn-primary {
            background: #3498db; /* 버튼 색상 */
            border: none;
            padding: 15px 30px;
            font-size: 1.25rem;
            border-radius: 50px; /* 둥근 버튼 */
            color: #fff;
            text-decoration: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: background 0.3s, transform 0.3s;
        }
        .btn-primary:hover {
            background: #2980b9; /* 버튼 호버 색상 */
            transform: scale(1.05);
        }
        @media (max-width: 768px) {
            .error-content .icon {
                font-size: 6rem;
            }
            .error-content h1 {
                font-size: 3rem;
            }
            .error-content p {
                font-size: 1.2rem;
            }
            .btn-primary {
                font-size: 1rem;
                padding: 10px 20px;
            }
        }
    </style>
</head>
<body>
    <div class="error-content">
        <h1>${status} 에러</h1>
        <p>${message}</p>
        <div style="margin-top: 40px"><a id="countdown" href="/" class="btn btn-primary">3초 후 메인 페이지로 돌아갑니다.</a></div>
        <script>
        	let countdownNumber = 3;
        	let countdownElement = document.querySelector("#countdown");
        	
        	let countdownInterval = setInterval(() => {
				countdownElement.textContent = countdownNumber + "초 후 메인 페이지로 돌아갑니다.";
				countdownNumber--;

				if(countdownNumber < 0) {
					clearInterval(countdownInterval);
					window.location.href = "/";	
				}
			}, 1000);
        </script>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/2.11.6/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
</body>
</html>
