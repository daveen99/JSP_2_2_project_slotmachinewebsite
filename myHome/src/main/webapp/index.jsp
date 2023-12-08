<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pagefile=request.getParameter("page");
	if (pagefile==null) {pagefile="newitem";}
%>
<html>

<head>
<meta charset="UTF-8">
<title>홈페이지</title>
<link rel="icon" href="cookie.svg">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<style>
	html, body {
		margin: 0;
		padding: 0;
		height: 100%;
	}

	table {
		margin : auto;
		width : 960px;
		height: 100vh;
	}
	#top {
		text-align: right;

	}
	#center {
		height: 80%;
	}
	#left {
		min-width: 200px; 
	}
</style>
</head>
<body>
<table class="table table-striped">
	<tr>
		<td height="80" colspan=3 align=left id="top">
			<jsp:include page="top.jsp"/>
		</td>
	</tr>
	<tr>
		<td width="20%" align=right valign=top id="left"><br>
			<jsp:include page="left.jsp"/>
		</td>
		<td colspan=2 align=center id="center">
			<jsp:include page='<%=pagefile+".jsp" %>'/>
		</td>
	</tr>
	<tr>
		<td width="100%" height="40" colspan="3">
			<jsp:include page="bottom.jsp"/>
		</td>
	</tr>
</table>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        var pagefile = "<%= pagefile %>";
        var centerTd = document.getElementById("center");
        
        if (pagefile === "newitem") {
            document.querySelector(".new").checked = true;
            centerTd.style.backgroundColor = "oldlace";

        } else if (pagefile === "bestitem") {
            document.querySelector(".best").checked = true;
            centerTd.style.backgroundColor = "azure";
        }
    });
</script>
</body>
</html>