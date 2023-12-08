<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<link rel="icon" href="cookie.svg">
<style>
	body {
		  display: flex;
  		  justify-content: center; 
 	      align-items: center; 
 	      height: 100vh;
 	      background-image: url(backg.jpg);
 	      background-repeat : no-repeat;
 	      background-size: cover;
	}
	form {
		width:75vh;
		border: 2px solid #000; 
  	    border-radius: 5px; 
    	padding: 70px 70px 40px 70px; 
    	background-color: rgba(255, 255, 255, 0.5);
    	max-width: 500px;
    	min-width: 500px;
		
	}
	form label {
		font-size: 20px;
		font-weight: bold;
	}
	#loginForm {
		margin: 0 auto;
	}
	#buttons {
		display: flex;
		justify-content: space-around;
		align-items: center;
		padding-top: 30px;
	}
	#buttons input {
		font-size: 25px;
		width: 150px;
	
	}
	#reset {
		background-color: orange;
		transition: background-color 0.3s; 
		border: 0px;
	}
	#reset:hover {
		background-color: darkorange;
	}
</style>
</head>
<body>

 
 <form action="loginPro.jsp" method="post" id="loginForm">
  <div class="mb-3">
    <label for="exampleInputEmail1" class="form-label">아이디</label>
    <input type="text" class="form-control" id="id" aria-describedby="emailHelp" name="id">
  </div>
  <div class="mb-3">
    <label for="exampleInputPassword1" class="form-label">비밀번호</label>
    <input type="password" class="form-control" id="password"  name="password">
  </div>

  <div id="buttons">
  	<input type="submit" value="로그인" class="btn btn-primary" />
	<input type="reset" value="돌아가기" class="btn btn-primary" id="reset" 
	onclick="window.history.back()"/>
  </div>	
</form>


</body>
</html>