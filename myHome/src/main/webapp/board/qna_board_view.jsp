<%@page import="beans.Board"%>
<%@page language="java" contentType="text/html; charset=UTF-8"%>

<%
	Board article = (Board)request.getAttribute("article");
    String nowPage = (String)request.getAttribute("page");
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

<meta charset="UTF-8">
<title>게시판 상세보기</title>
<style type="text/css">
#articleForm {
	width: 700px;
	height: 800px;
	border: 2px inset black;
	border-radius: 30px;
	margin: auto;
	margin-top: 100px;
}

h4 {
	text-align: center;
	margin-top: 20px;
	
	font-weight: bold;
}

#basicInfoArea {
	height: 40px;
	text-align: center;
}

#articleContentArea {
	background: #F4FFFF;
	margin-top: 20px;
	height: 350px;
	text-align: ;
	overflow: auto;
	padding: 20px;
	border-top: 2px solid black;
	border-bottom: 1px solid black;
}

#commandList {
	margin-top: -24px;
	width: ;
	text-align:right;
}

#filetab {
	padding: 20px;
	background: #D2FFD2;
	border-top: 1px solid black;
	border-bottom: 1px solid black;
}

#boardInfo {
	text-align: right;
	padding-right: 15px;
}

</style>
</head>

<body>
	<!-- 게시판 수정 -->
	<section id="articleForm">
		<section id="basicInfoArea">
			<h4><%=article.getBOARD_SUBJECT()%> </h4>
		</section>
		<section id="boardInfo">
			작성자: <%=article.getBOARD_NAME() %>
			&nbsp;
			조회수: <%=article.getBOARD_READCOUNT() %>
		</section>
		<section id="articleContentArea">
			<%=article.getBOARD_CONTENT() %>
		</section>
		<section id="filetab">
			첨부파일 :
			<%if(!(article.getBOARD_FILE()==null)){ %>
			<a href="file_down?downFile=<%=article.getBOARD_FILE()%>"> <%=article.getBOARD_FILE() %>
			</a>
			<%} %>
			<section id="commandList">
				<a href="boardReplyForm.bo?board_num=<%=article.getBOARD_NUM() %>&page=<%=nowPage%>">
					[댓글] </a> 
				<a href="boardModifyForm.bo?board_num=<%=article.getBOARD_NUM() %>">
					[수정] </a>
				<a href="#" onclick="confirmDelete(<%=article.getBOARD_NUM() %>, <%=article.getBOARD_PASS() %>, <%=nowPage%>)">
		   			[삭제]</a>
				<a href="boardList.bo?page=<%=nowPage%>">
				    [목록]</a>
				&nbsp;&nbsp;
			</section>
		</section>
	</section>

<script>
    function confirmDelete(boardNum, boardPass, page) {
        var inputPass = prompt('게시물 비밀번호를 입력하세요:');
        
        console.log(inputPass + " vs " + boardPass);
        
        if (inputPass == boardPass) {
        	window.location.href='boardDeleteForm.bo?board_num=' + boardNum + '&page=' + page;
        	alert('게시물이 정상적으로 삭제되었습니다.');
        } else {
            alert('비밀번호가 일치하지 않습니다.');
        }
    }
</script>
</body>
</html>