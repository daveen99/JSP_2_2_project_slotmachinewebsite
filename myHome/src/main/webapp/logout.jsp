<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>	
	
	
	<script>
	if(confirm("정말 로그아웃 하시겠습니까?")) {
		<%
		session.invalidate();
		%>
		alert("로그아웃 되었습니다.");
		location.href="index.jsp";
	} else {
		window.history.back();
	}
	</script>



</body>
</html>