<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
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
		width: 75vh;
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
		width: 30%;
	}
	form .mb-3 input {
		width: 230px !important;
		
	}
	.mb-3 {
		display: flex;
	}
	#joinForm {
		margin: 0 auto;
	}
	#buttons {
		display: flex;
		justify-content: space-around;
		align-items: center;
		padding-top: 30px;
	}
	#buttons input{
		font-size: 25px;
		width: 150px;
		align-content: center;
	}
	#reset {
		background-color: orange;
		transition: background-color 0.3s; 
		border: 0px;
	}
	#reset:hover {
		background-color: darkorange;
	}
	#submit {
		background-color: blueviolet;
		transition: background-color 0.3s; 
		border: 0px;
	}
	#submit:hover {
		background-color: DarkSlateBlue;
	}
	#gender  {
		width: 60%;
	}

</style>

</head>
<body>

<form action="joinPro.jsp" method="post" id="joinForm">
	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">아이디</label>
    	<input type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="id"
    	placeholder="ID">
    </div>

	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">비밀번호</label>
    	<input type="password" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="password"
    	placeholder="Password">
    </div>

	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">이   름</label>
    	<input type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="name"
    	placeholder="Name">
    </div>

	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">나   이</label>
    	<input type="number" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="age"
    	placeholder="Age">
    </div>

	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">성   별</label>
   		<!--
		<input type="radio" name="gender" value="남자" checked/>남자
		<input type="radio" name="gender" value="여자"/>여자 <br>
		  -->
		<div id="gender">
			<input type="radio" class="btn-check" name="gender" id="success-outlined" autocomplete="off" value="남자">
			<label class="btn btn-outline-success" for="success-outlined">남자</label>

			<input type="radio" class="btn-check" name="gender" id="danger-outlined" autocomplete="off" value="여자">
			<label class="btn btn-outline-danger" for="danger-outlined">여자</label>
		</div>
    </div>
	

	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">이 메 일</label>
    	<input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="email"
    	placeholder="e-mail@mail.com">
    </div>
	
    <div id="buttons">
  		<input type="submit" value="회원가입" class="btn btn-primary" id="submit" />
		<input type="button" value="돌아가기" class="btn btn-primary" id="reset" 
		onclick="window.history.back()"/>
    </div>	
</form>
 
</body>
</html>