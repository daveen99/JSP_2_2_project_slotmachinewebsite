<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="DB.BoardDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="DB.JdbcUtil" %>

<style>
	#slotimg {
		width: 800px;
	}
	#slot {
		width: 800px;
		margin: auto;
		padding-top: ;
	}
	.cards {
		width: 250px;
		height: 250px;
		border-radius: 30px;
	}
	
	#slotText {
		width: 500px;
		height: 100px;
		background: white;
		margin: 30px;
		border-radius: 30px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	#textDetail {
		text-align: center;
		font-size: 20pt;
		font-weight: bold;
	}
	#pointText {
		width: 500px;
		height: 100px;
		background: white;
		margin: 30px;
		border-radius: 30px;
		display: flex;
		justify-content: center;
		align-items: center;
		flex-direction: column;
		border: 4px solid gray;
	}
	#pointDetail {
		text-align: center;
		font-size: 20pt;
		font-weight: bold;
	}
	
	#startbtn {
		height: 50px;
	}
</style>

<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">

<meta charset="UTF-8">
<title>신상품</title>
</head>
<body>	
<section id="slot">
	<div id="pointText">
		보유중인 포인트
	<%	HttpSession Hsession = request.getSession();
		Integer up = (Integer) Hsession.getAttribute("userPoint");
		if (up != null) {
	%>
		<div id="pointDetail"><%=up %>pt</div>
	<%} else { %>
		<div id="pointDetail">로그인이 필요합니다.</div>
	<%} %>
	</div>
	<img src="slotquest.png" class="cards" id="card1">
	<img src="slotquest.png" class="cards" id="card2">
	<img src="slotquest.png" class="cards" id="card3">
	
	<div id="slotText">
		<p id="textDetail">럭키! 슬롯머신</p>
	</div>

	<%
		if (up != null) {
	%>
	<input type="button" value="슬롯머신 작동 (100pt)" id="startbtn"
		onclick="startSlot()"  class="btn btn-primary">
	<%} else { %>
	<input type="button" value="슬롯머신 작동 (100pt)" id="startbtn"
		disabled="disabled"  class="btn btn-primary">
	<%}  %>
	
</section>
<script>
	var imageArray = ["slotbanana.png", "slotbanana.png", "slotbanana.png", "slotbar.png",  "slotbar.png",
		"slotseven.png", "slotwatermelon.png", "slotwatermelon.png"];
	//var imageArray = ["slotbanana.png", "slotbanana.png", "slotbanana.png"];
    var card1 = document.getElementById("card1");
    var card2 = document.getElementById("card2");
    var card3 = document.getElementById("card3");
    var startbtn = document.getElementById("startbtn");
    var textdetail = document.getElementById("textDetail");
    var pointdetail = document.getElementById("pointDetail");
    var Hsession = <%= up %>;
    
	function startSlot() {
        if (startbtn.disabled) {
            return;
        }
        if (checkPoint()){
        	usePoint()
        } else {
        	alert('포인트가 모자랍니다.');
        	return;
        }
     
        startbtn.disabled = true;
        gamePlay = true;
        textdetail.innerText = "슬롯머신 돌아가는중 ...";
		var timer = setInterval(function () {
			card1.src = getRandomImage(imageArray);
			card2.src = getRandomImage(imageArray);
			card3.src = getRandomImage(imageArray);   
		}, 100);
		setTimeout(function () {
			clearInterval(timer);
			startbtn.disabled = false;
			checkCard(partCard(card1.src), partCard(card2.src), partCard(card3.src));
		}, 2000);
  
	}
    function getRandomImage(imageArray) {
        var randomIndex = Math.floor(Math.random() * imageArray.length);
        return imageArray[randomIndex];
    }
    
    function partCard(cardsrc) {
    	var parts = cardsrc.split("/");
    	var fileName = parts[parts.length - 1];
    	return fileName;
	}
    
    function checkCard(card1, card2, card3) {
    	console.log(card1);
    	if (card1 == card2 && card1 == card3) {
    		switch(card1) {
    			case "slotbanana.png":
    	            textdetail.innerText = "바나나 당첨! 500pt지급";
    	            updateDatabase(500, Hsession);
    	            takePoint(500);
    				break;
    			case "slotbar.png":
    	            textdetail.innerText = "BAR 당첨! 3000pt 지급";
    	            updateDatabase(3000, Hsession);
    	            takePoint(3000);
    				break;
    			case "slotwatermelon.png":
    	            textdetail.innerText = "수박 당첨! 5000pt 지급";
    	            updateDatabase(5000, Hsession);
    	            takePoint(5000);
    				break;
    			case "slotseven.png":
    	            textdetail.innerText = "777 당첨! 77777pt지급";
    	            updateDatabase(77777, Hsession);
    	            takePoint(77777);
    				break;
    		}
    	} else {
            textdetail.innerText = "꽝입니다!";
    	}
	}
    
    function takePoint(point) {
        var presentPoint = pointdetail.innerText;
        var intPoint = parseInt(presentPoint);
        var newPoint = intPoint + point;
        var pote = newPoint.toString() ;
        pointdetail.innerText = "" + pote + "pt";
	}
    function usePoint() {
        var presentPoint = pointdetail.innerText;
        var intPoint = parseInt(presentPoint);
        var newPoint = intPoint - 100;
        var pote = newPoint.toString() ;
        pointdetail.innerText = "" + pote + "pt";
        updateDatabase(100, Hsession);
	}
    function checkPoint() {
        var presentPoint = pointdetail.innerText;
        var intPoint = parseInt(presentPoint);
        		
        if (intPoint < 1) {
        	return false;
        } else {
        	return true;
        }
	}
    function updateDatabase(point) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
            	Hession = parseInt(pointdetail.innerText);
            }
        };
        xhr.open("GET", "updateDatabase.jsp?point=" + point, true);
        xhr.send();
    }
</script>
</body>
</html>