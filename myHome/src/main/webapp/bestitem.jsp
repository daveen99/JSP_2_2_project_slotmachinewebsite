<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>
	.cards {
		width: 240px;
		height: 240px;
		border-radius: 30px;
		border-bottom: 10px solid #c8c8c8;
		border-right: 10px solid #c8c8c8;
	}
	#tds {
		width: 240px;
		display: flex ;
		justify-content: center;
		align-items: center;
		flex-direction: column;
	}
	#trs {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	#text {
		width: 240px;
		text-align: center;
		font-size: 20pt;
	}
	#firstbtn {
		margin-top: 20px;
	}
	td {
		margin: 40px;
	}
	.cards {

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
</style>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품교환</title>
</head>
<body>
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
	<table>
		<tr id="trs">
			<td id="tds">
				<img src="gift1.jpg" class="cards" id="card1">
				<div id="text"><b>플레이스테이션5</b> 500,000pt</div>	
				<input type="button" value="교환하기" id="firstbtn"
					 class="btn btn-primary" 
					 onclick="exchangeItem('플레이스테이션5', 500000);">
			</td>  
			<td id="tds">
				<img src="nintendo.jpg" class="cards" id="card1">
				<div id="text"><b>닌텐도 스위치</b> 300,000pt</div>	
				<input type="button" value="교환하기" id="firstbtn"
					 class="btn btn-primary" 
					 onclick="exchangeItem('닌텐도 스위치', 300000);">
			</td>  
			<td id="tds">
				<img src="ocul.jpg" class="cards" id="card1">
				<div id="text"><b>오큘러스 퀘스트</b> 250,000pt</div>	
				<input type="button" value="교환하기" id="firstbtn"
					 class="btn btn-primary" 
					 onclick="exchangeItem('오큘러스 퀘스트', 250000);">
			</td>
		</tr>
		<tr id="trs">
			<td id="tds">
				<img src="p12.png" class="cards" id="card1">
				<div id="text"><b>중국 저가 태블릿</b> 150,000pt</div>	
				<input type="button" value="교환하기" id="firstbtn"
					 class="btn btn-primary" 
					 onclick="exchangeItem('중국 저가 태블릿', 150000);">
			</td>  
			<td id="tds">
				<img src="sam.jpg" class="cards" id="card1">
				<div id="text"><b>한돈 삼겹살</b> 150,000pt</div>		
				<input type="button" value="교환하기" id="firstbtn"
					 class="btn btn-primary" 
					 onclick="exchangeItem('한돈 삼겹살', 150000);">
			</td>  
			<td id="tds">
				<img src="rnbox.jpg" class="cards" id="card1">
				<div id="text"><b>랜덤박스 추첨</b> 100,000pt</div>	
				<input type="button" value="교환하기" id="firstbtn"
					 class="btn btn-primary" 
					 onclick="exchangeItem('랜덤박스', 100000);">
			</td>
		</tr>
	</table>
	<script>
	    function exchangeItem(itemName, requiredPoints) {
	        var pointdetail = document.getElementById("pointDetail");
	        var currentPoints = parseInt(pointdetail.innerText);
	
	        if (currentPoints >= requiredPoints) {
	            var remainingPoints = currentPoints - requiredPoints;
	            pointdetail.innerText = remainingPoints + "pt";  
	
	            updateDatabase(requiredPoints);
	
	            alert(itemName + "을(를) 성공적으로 교환했습니다!");
	        } else {
	            alert("포인트가 부족하여 " + itemName + "을(를) 교환할 수 없습니다.");
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