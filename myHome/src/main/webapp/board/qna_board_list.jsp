<%@page import="beans.PageInfo"%>
<%@page import="beans.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	ArrayList<Board> articleList = (ArrayList<Board>)request.getAttribute("articleList");
    PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
	int listCount=pageInfo.getListCount();
	int nowPage=pageInfo.getPage();
	int maxPage=pageInfo.getMaxPage();
	int startPage=pageInfo.getStartPage();
	int endPage=pageInfo.getEndPage();
%>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<meta charset="UTF-8" />
<title>커뮤니티 게시판</title>
<style type="text/css">
#listForm {
	width: 900px;
	margin: auto;
}

h2 {
	text-align: center;
}

a {
    text-decoration: none; 
    
}

table {
	margin: auto;
}

#tr_top {
	background: skyblue;
	text-align: center;
	font-size: 15pt;
	font-weight: bold;
}

#pageList {
	margin: auto;
	width: 500px;
	text-align: center;
	font-size: 15pt;
}

#emptyArea {
	margin: auto;
	width: 500px;
	text-align: center;
}

#listTable {
	display: flex;
	justify-content: center;
	width: 900px;
	height: 80vh;
	border: 1px solid gray;
    font-size: 13pt;
}

td {
	text-align: center;
	padding: 10px;
	border-bottom: 1px solid #ddd; /* 각 행의 아래에 구분선 추가 */
}
#titleList {
	text-align: left;
	
}
#num {
	width: 50em;
	padding: 3px;
}
#title {
	width: 400em;
	padding: 3px;
}
#author {
	width: 100em;
	padding: 3px;
}
#date {
	width: 100em;
	padding: 3px;
}
#view {
	width: 60em;
	padding: 3px;
}

#write {
	width: 100px;
 	display: flex;
 	margin-left: 738px;
}

#board {
	font-size: 40px;
	font-weight: bold;
	background: #062957;
	background: -webkit-linear-gradient(to right, #062957 0%, #B0B9CF 100%);
	background: -moz-linear-gradient(to right, #062957 0%, #B0B9CF 100%);
	background: linear-gradient(to right, #062957 0%, #B0B9CF 100%);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
}

.glitch-wrapper {
   width: 100%;
   height: 100%;
   display: flex;
   align-items: center;
   justify-content: center;
   text-align: center;
   background-color: #000000;
}

.glitch {
   position: relative;
   font-size: 50px;
   font-weight: bold;
   color: #FFFFFF;
   letter-spacing: 3px;
   z-index: 1;
}

.glitch:before,
.glitch:after {
   display: block;
   content: attr(data-text);
   position: absolute;
   top: 0;
   left: 0;
   opacity: 0.8;
}

.glitch:before {
   animation: glitch-it 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94) both infinite;
   color: #00FFFF;
   z-index: -1;
}

.glitch:after {
   animation: glitch-it 0.3s cubic-bezier(0.25, 0.46, 0.45, 0.94) reverse both infinite;
   color: #FF00FF;
   z-index: -2;
}

@keyframes glitch-it {
   0% {
      transform: translate(0);
   }
   20% {
      transform: translate(-2px, 2px);
   }
   40% {
      transform: translate(-2px, -2px);
   }
   60% {
      transform: translate(2px, 2px);
   }
   80% {
      transform: translate(2px, -2px);
   }
   to {
      transform: translate(0);
   }
}

</style>
</head>

<body>
	<!-- 게시판 리스트 -->

	<section id="listForm">
		<h2 id="board">
			커뮤니티 게시판<br>
		</h2>
		<h2 id="write">
			<input type="reset" value="돌아가기" class="btn btn-primary" id="reset" 
				onclick="location.href='index.jsp'"/>
			<input type="button" class="btn btn-primary" value="글쓰기"  id="writeButton" 
				onclick="location.href='boardWriteForm.bo'">
			<!--<a href="boardWriteForm.bo">글쓰기</a>  -->
		</h2>
		<table id = "listTable">
			<%
if(articleList != null && listCount > 0){
%>

			<tr id="tr_top">
				<td id="num">글번호</td>
				<td id="title">제목</td>
				<td id="author">작성자</td>
				<td id="date">날짜</td>
				<td id="view">조회수</td>
			</tr>

			<%
		for(int i=0;i<articleList.size();i++){
			
	%>
			<tr>
				<td><%=articleList.get(i).getBOARD_NUM()%></td>

				<td id="titleList">
					<%if(articleList.get(i).getBOARD_RE_LEV()!=0){ %> <%for(int a=0;a<=articleList.get(i).getBOARD_RE_LEV()*2;a++){ %>
					&nbsp; <%} %> ▶ <%}else{ %> ▶ <%} %> 
					<a href="boardDetail.bo?board_num=<%=articleList.get(i).getBOARD_NUM()%>&page=<%=nowPage%>">
						<%=articleList.get(i).getBOARD_SUBJECT()%>
					</a>
				</td>

				<td><%=articleList.get(i).getBOARD_NAME() %></td>
				<td><%=articleList.get(i).getBOARD_DATE() %></td>
				<td><%=articleList.get(i).getBOARD_READCOUNT() %></td>
			</tr>
			<%} %>
		</table>
			<div class="glitch-wrapper">
  		<div class="glitch" data-text="내 방식대로, 재밌게 TikTok♪">내 방식대로, 재밌게 TikTok♪</div>
	</div>
	</section>


	<section id="pageList">
		<%if(nowPage<=1){ %>
		[이전]&nbsp;
		<%}else{ %>
		<a href="boardList.bo?page=<%=nowPage-1 %>">[이전]</a>&nbsp;
		<%} %>

		<%for(int a=startPage;a<=endPage;a++){
				if(a==nowPage){%>
		[<%=a %>]
		<%}else{ %>
		<a href="boardList.bo?page=<%=a %>">[<%=a %>]
		</a>&nbsp;
		<%} %>
		<%} %>

		<%if(nowPage>=maxPage){ %>
		[다음]
		<%}else{ %>
		<a href="boardList.bo?page=<%=nowPage+1 %>">[다음]</a>
		<%} %>
	</section>
	<%
    }
	else
	{
	%>
	<section id="emptyArea">등록된 글이 없습니다.</section>
	<%
	}
%>

</body>
</html>