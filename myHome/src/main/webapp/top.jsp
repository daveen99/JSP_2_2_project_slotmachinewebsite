<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<html>
<head>
</head>
<style>
	nav {
		font-size: 20px;
		align-items: center; 
		max-height: 190pt;
		min-height: 80px;
	}
	nav .navbar-brand {
		margin-left: 20px;
	}
	nav .nav-link {
		font-weight: bold;
		width: auto;
	}
	nav .nav-item {
		display: flex;
 	    justify-content: flex-end;
 	    text-align: right;
	}
	.btn {
		transition: background-color 0.3s ease;
	}

	.login:hover {
		background-color: MidnightBlue !important
	}
	.join:hover {
		background-color: DarkSlateBlue !important
	}
	@media (max-width: 991px) {

	.dropdown {
		display: none;
		font-size: 0;
	}
	#else {
		display:inline;
	}
}
</style>      

<body>
<%
	String id = (String)session.getAttribute("id");
	String name = (String)session.getAttribute("name");
	
	if (id == null) {
		
%>  
        

<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
  	<a class="navbar-brand" href="index.jsp">
      <img src="cookie.svg" alt="Logo" width="60" height="55" class="d-inline-block align-text-center img">

    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="noticeList.bo">공지사항</a>
          <!-- 공지사항/ 어드민 계정을 가진 사람만 쓰고 지울수있어요
          	   제목 + 내용 + 날짜 + (공지사항용)글번호 
          	   나머지 유저들은 보기만 할 수 있다.-->
        </li>
        <li class="nav-item">
          <a class="nav-link" href="boardList.bo">게시판</a>
        </li>
        <!--<li class="nav-item dropdown">
        
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            목차
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">메뉴1</a></li>
            <li><a class="dropdown-item" href="#">메뉴2</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">더보기</a></li>
          </ul>
        </li>  -->
      </ul>
      
      <input type="button" class="btn-check" id="btn-check" autocomplete="off">
 	  <label class="btn btn-primary login" id="btn-check"for="btn-check">로그인</label>
 	  <h3 id="else">|</h3>
      <input type="button" class="btn-check" id="btn-check-2" autocomplete="off">
      <label class="btn btn-primary join" for="btn-check-2" style="background-color: blueviolet">회원가입</label>
	</div>
  </div>
</nav>
<script>
    document.getElementById("btn-check").addEventListener("click", function () {
        window.location.href = "login.jsp";
    });

    document.getElementById("btn-check-2").addEventListener("click", function () {
        window.location.href = "join.jsp";
    });
    
</script>
      <%
		}
		else {
      %>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">
      <img src="cookie.svg" alt="Logo" width="60" height="55" class="d-inline-block align-text-center img">

    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="noticeList.bo">공지사항</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="boardList.bo">게시판</a>
        </li>
        <!--<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            목차
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">메뉴1</a></li>
            <li><a class="dropdown-item" href="#">메뉴2</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">더보기</a></li>
          </ul>
        </li>  -->
      </ul>
      <%=name %>님
      <!--  <input type="button" class="btn-check" id="info" autocomplete="off">-->
      <label class="btn btn-primary join" id="info" style="background-color: blueviolet">마이페이지</label>
      <h3 id="else">|</h3>
      <!-- <input type="button" class="btn-check" id="logout" autocomplete="off">-->
 	  <label class="btn btn-primary login" id="logout">로그아웃</label>

	</div>
  </div>
</nav>
<script>
    document.getElementById("info").addEventListener("click", function () {
        window.location.href = "infoview.jsp";
    });
    
    document.getElementById("logout").addEventListener("click", function () {
        window.location.href = "logout.jsp";
    });
</script>
      <% } %>

</body>
</html>