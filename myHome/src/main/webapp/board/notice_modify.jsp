<%@page import="beans.Notice"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	Notice article = (Notice)request.getAttribute("article");
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

<meta charset="UTF-8"> 
	<title>공지사항 수정</title>
	<script type="text/javascript">
		function modifyboard(){
			modifyform.submit();
		}
	</script>
	<style type="text/css">
h2 {
	text-align: center;
	margin-top: 50px;
	margin-bottom: 50px;
	font-size: 50px;
	font-weight: bold;
}

table {
	margin: auto;
	width: 800px;
	padding: 50px;
	display: flex;
	justify-content: center;
	align-items: center;
	border: 3px solid black;
	border-radius: 30px;
}

.td_left {
	width: 150px;
	background: orange;
	text-align: center;
	border: 1px solid gray;
}
.td_author {
	width: 150px;
	background:yellowgreen;
	text-align: center;
	border: 1px solid gray;
}

.td_right {
	width: 500px;
	background: ;
}

#NOTICE_SUBJECT {
	width: 500px;
	height: 40px;
}
#NOTICE_CONTENT {
	width: 500px;
}

#commandCell {
	margin-top: 50px;
	text-align: center;
}

#content {
	width: 100%;
}

#submit {
	background: yellowgreen;
	transition: background-color 0.3s ease;
}
#submit:hover {
	background-color: #3CB371 !important
}

#NOTICE_NAME {
	width: 80px;
	height: 40px;
	font-size: 15px;
	background: #dcdcdc;
	border: 1px solid gray;
	text-align: center;
}
</style>
</head>
<body>
<!-- 게시판 등록 -->

<section id = "writeForm">
<h2>게시판글수정</h2>
<form action="noticeModifyPro.bo" method="post" name = "modifyform">
	<input type = "hidden" name = "NOTICE_NUM" value = "<%=article.getNOTICE_NUM()%>"/>
	<table>
		<tr>
			<td class="td_author"><label for="NOTICE_NAME">작성자</label></td>
			<td class="td_right"><input type="text" name="NOTICE_NAME"
				id="NOTICE_NAME" required="required" value="관리자"  readonly/></td>
		</tr>
		<tr>
			<td class="td_author">
				<label for = "NOTICE_SUBJECT">제 목</label>
			</td>
			<td class="td_right">
				<input name="NOTICE_SUBJECT" type="text" id = "NOTICE_SUBJECT" value = "<%=article.getNOTICE_SUBJECT()%>"/>
			</td>
		</tr>

		<tr>
			<td class="td_left">
				<label for = "NOTICE_CONTENT">내 용</label>
			</td>
			<td>
				<textarea id = "NOTICE_CONTENT" name="NOTICE_CONTENT" cols="40" rows="15"><%=article.getNOTICE_CONTENT()%></textarea>
			</td>
		</tr>
	</table>
			<section id="commandCell">
				<input type="submit" id = "submit" value="수정" class="btn btn-primary"/>&nbsp;&nbsp; 
				<input type="reset" value="돌아가기" class="btn btn-primary" id="reset" 
				onclick="window.history.back()"/>
			</section>
</form>
</section>
</body>
</html>