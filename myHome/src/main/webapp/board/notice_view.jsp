<%@page import="beans.Notice"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	Notice article = (Notice)request.getAttribute("article");
    String nowPage = (String)request.getAttribute("page");
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

<meta charset="UTF-8">
<title>공지사항 상세보기</title>
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
	background: #FFCA9B;
	margin-top: 20px;
	height: 350px;
	text-align: ;
	overflow: auto;
	padding: 20px;
	border-top: 2px solid black;
	border-bottom: 1px solid black;
}

#commandList {
	margin-top: ;
	width: ;
	text-align:right;
}

#filetab {
	padding: 20px;
	background: #D2FFD2;
	border-top: 1px solid black;
	border-bottom: 1px solid black;
}

#noticeInfo {
	text-align: right;
	padding-right: 15px;
}

</style>
</head>

<body>
	<!-- 게시판 수정 -->
	<section id="articleForm">
		<section id="basicInfoArea">
			<h4><%=article.getNOTICE_SUBJECT()%></h4>
		</section>
		<section id="noticeInfo">
			작성자: <%=article.getNOTICE_NAME() %>
			&nbsp;
			조회수: <%=article.getNOTICE_READCOUNT() %>
		</section>
		<section id="articleContentArea">
			<%=article.getNOTICE_CONTENT() %>
		</section>
		<section id="filetab">
			<section id="commandList">
		<a href="noticeReplyForm.bo?notice_num=<%=article.getNOTICE_NUM() %>&page=<%=nowPage%>">
			[댓글] </a> 
			<%	HttpSession Hsession = request.getSession();
				    String userId = (String) Hsession.getAttribute("isAdmin");
			     	System.out.println(userId);
			     	if (userId != null) { 
				   	    if (userId.equals("admin")) {%>
					        <a href="noticeModifyForm.bo?notice_num=<%=article.getNOTICE_NUM() %>">
			                [수정] </a>
		                    <a href="#" onclick="confirmDelete(<%=article.getNOTICE_NUM() %>)">
    						[삭제]</a>
				<%}
				 }%>
		<a href="noticeList.bo?page=<%=nowPage%>">
		    [목록]</a>
		&nbsp;&nbsp;
	</section>
		</section>
	</section>

	<script>
   		function confirmDelete(noticeNum) {
	        if (confirm('공지를 정말 삭제하시겠습니까?')) {
	            window.location.href='noticeDeleteForm.bo?notice_num=' + noticeNum + '&page=<%=nowPage%>';
	            alert('게시물이 정상적으로 삭제되었습니다.');
	        } else {
	        }
	    }
</script>
</body>
</html>