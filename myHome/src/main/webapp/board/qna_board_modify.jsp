<%@page import="beans.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	Board article = (Board)request.getAttribute("article");
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

<meta charset="UTF-8"> 
	<title>게시판 글 수정</title>
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
	background: skyblue;
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

#BOARD_SUBJECT {
	width: 500px;
	height: 40px;
}
#BOARD_CONTENT {
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
</style>
</head>
<body>
<!-- 게시판 등록 -->

<section id = "writeForm">
<h2>게시판 글 수정</h2>
<form action="boardModifyPro.bo" method="post" name = "modifyform">
	<input type = "hidden" name = "BOARD_NUM" value = "<%=article.getBOARD_NUM()%>"/>
	<table>
		<tr>
			<td class="td_author">
				<label for = "BOARD_NAME">글쓴이</label>
			</td>
			<td class="td_right">
				<input type = "text" name="BOARD_NAME" id = "BOARD_NAME" value = "<%=article.getBOARD_NAME()%>"  readonly/>
			</td>
		</tr>
		<tr>
			<td class="td_author">
				<label for = "BOARD_PASS">비밀번호</label>
			</td>
			<td class="td_right">
				<input name="BOARD_PASS" type="password" id = "BOARD_PASS"/>
			</td>
		</tr>
		<tr>
			<td class="td_left">
				<label for = "BOARD_SUBJECT">제 목</label>
			</td>
			<td class="td_right">
				<input name="BOARD_SUBJECT" type="text" id = "BOARD_SUBJECT" value = "<%=article.getBOARD_SUBJECT()%>"/>
			</td>
		</tr>
		<tr>
			<td class="td_left">
				<label for = "BOARD_CONTENT">내 용</label>
			</td>
			<td>
				<textarea id = "BOARD_CONTENT" name="BOARD_CONTENT" cols="40" rows="15"><%=article.getBOARD_CONTENT()%></textarea>
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