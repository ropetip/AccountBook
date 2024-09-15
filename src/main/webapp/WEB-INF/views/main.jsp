<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String oauth_email = (String)session.getAttribute("oauth_email");
	String oauth_nickname = (String)session.getAttribute("oauth_nickname");
%>
<!DOCTYPE html>
<html>
<head>
<script>
$(document).ready(function () {
});
</script>
</head>

<body>
	
	어서오세요. 여기는 개인 공간입니다.<br>
	모델에서 받은 텍스트: <%=oauth_email%>, <%=oauth_nickname%> 
</body>

</html>