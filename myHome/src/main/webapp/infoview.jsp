<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
		background-color: red;
		transition: background-color 0.3s; 
		border: 0px;
		
		font-size: 25px;
		width: 150px;
		align-content: center;
		
		margin-left: 14px;
		margin-top: 14px;
	}
	#reset:hover {
		background-color: crimson;
	}
	#submit {
		background-color: blueviolet;
		transition: background-color 0.3s; 
		border: 0px;
	}
	#submit:hover {
		background-color: DarkSlateBlue;
	}
	#back {
		background-color: orange;
		transition: background-color 0.3s; 
		border: 0px;
	}
	#back:hover {
		background-color: tomato;
	}
	#gender  {
		width: 60%;
	}
	#delete {
		display: flex;
		justify-content: ;
		
		
	}

</style>

<title>마이페이지</title>
</head>
<body>
	<% 
		request.setCharacterEncoding("utf-8"); 
	
		Connection con = null;
		String url = "jdbc:mysql://localhost:3306/myweb";
		String driver = "com.mysql.jdbc.Driver";
		String sql = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String id = (String)session.getAttribute("id");
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, "root", "1234");
			sql = "select * from member where id = ?";
			ps = con.prepareStatement(sql);
			
			ps.setString(1, id);
			
			rs = ps.executeQuery();
			
			rs.next();

		}
		catch(SQLException e) {
			e.printStackTrace();

		}
	%>

<form action="updatePro.jsp" method="post" id="joinForm">
	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">아이디</label>
    	<input type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="id" 
    	value=<%=rs.getString("id")%> readonly>
    </div>

	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">비밀번호</label>
    	<input type="password" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="password"
    	value=<%=rs.getString("password") %>>
    </div>

	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">이   름</label>
    	<input type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="name"
    	value=<%=rs.getString("name")%>>
    </div>

	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">나   이</label>
    	<input type="number" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="age"
    	value=<%=rs.getInt("age")%>>
    </div>

	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">성   별</label>
   		<!--
		<input type="radio" name="gender" value="남자" checked/>남자
		<input type="radio" name="gender" value="여자"/>여자 <br>
		  -->
		<%
			if (rs.getString("gender").equals("남자")) {
		%>
		<div id="gender">
			<input type="radio" class="btn-check" name="gender" id="success-outlined" autocomplete="off" value="남자" checked >
			<label class="btn btn-outline-success" for="success-outlined" >남자</label>

			<input type="radio" class="btn-check" name="gender" id="danger-outlined" autocomplete="off" value="여자" disabled>
			<label class="btn btn-outline-danger" for="danger-outlined">여자</label>
		</div>
			<%
	 		}
			else {
		%>
		
		<div id="gender">
			<input type="radio" class="btn-check" name="gender" id="man" autocomplete="off" value="남자" disabled >
			<label class="btn btn-outline-success">남자</label>

			<input type="radio" class="btn-check" name="gender" id="woman" autocomplete="off" value="여자" checked>
			<label class="btn btn-outline-danger">여자</label>
		</div>
		<%
			} 
		%>
    </div>

	<div class="mb-3">
   		<label for="exampleInputEmail1" class="form-label">이 메 일</label>
    	<input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="email"
    	value=<%=rs.getString("email")%>>
    </div>

    <div id="buttons">
  		<input type="submit" value="수정하기" class="btn btn-primary" id="submit" />

		<input type="button" value="돌아가기" class="btn btn-primary" id="back" 
		onclick="location.href='index.jsp'"/>
    </div>	
    <div id="delete">
   	    <input type="button" value="탈퇴하기" class="btn btn-primary" id="reset" 
		onclick="delques()"/>
	</div>
</form>
	<script>
	function delques() {
		if(confirm("정말 탈퇴 하시겠습니까?")) {
			location.href='delete.jsp';
		} else {
			alert("회원탈퇴가 취소되었습니다.");
		}
	}
	</script>
</body>
</html>