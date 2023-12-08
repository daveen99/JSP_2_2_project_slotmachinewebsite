<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
    <style>
		.container {
			display: flex;
			justify-content: center;
			align-content: center;
		}
    </style>
</head>
<body>
<%
	if (session.getAttribute("name") != null) {
%>
    <div class="container">
        <div class="box">
            <div class="text">반갑습니다 <%=session.getAttribute("name") %>님, 좋은 하루 되십시오!</div>
        </div>
    </div>
<%
	} else {
%>
    <div class="container">
        <div class="box">
            <div class="text">로그인이 필요한 서비스입니다.</div>
        </div>
    </div>
<%
	}
%>    
</body>
</html>