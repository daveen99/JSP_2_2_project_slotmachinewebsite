<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.btn {
		transition: background-color 0.3s ease;
		font-weight: bold;	
	}
	.btn-outline-danger {
		border: 2px solid Crimson !important;
	}
	.btn-outline-success {
		border: 2px solid green !important;
	}
	.btn-outline-danger:hover {
		background-color: LightSalmon !important;
	}
	.btn-outline-success:hover {
		background-color: DarkSeaGreen !important;
	}
	center #new {
		margin-right: 20px;	
	}
	center {
		display: flex;
		justify-content: center;
	}
</style>

<center>
	<input type="radio" class="btn-check new" name="options-outlined" id="success-outlined" autocomplete="off">
	<label class="btn btn-outline-success" for="success-outlined" id="new" style="width: 130px; height: 50px; font-size: 25px">
	슬롯머신</label>
	
	<input type="radio" class="btn-check best" name="options-outlined" id="danger-outlined" autocomplete="off">
	<label class="btn btn-outline-danger" for="danger-outlined" style="width: 130px; height: 50px; font-size: 25px">
	상품교환</label>
	

	
</center>
	<br>
	<!-- <a href="boardList.bo">게시판</a>
	<a href="boardWriteForm.bo">게시판글쓰기</a> -->
<script>
    // 라디오 버튼 클릭 시 페이지 변경
    document.querySelector(".new").addEventListener("click", function () {
        window.location.href = "./index.jsp?page=newitem";
    });

    document.querySelector(".best").addEventListener("click", function () {
        window.location.href = "./index.jsp?page=bestitem";
    });
</script>