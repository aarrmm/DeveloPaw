<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<%@ include file="/common/import.jsp"%>

<title>글 작성</title>
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	
<link href="https://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="/resources/jquery-radiocharm.css" rel="stylesheet" type="text/css">
<script src="/resources/jquery-radiocharm.js"></script>

<style>

#board_title{
	font-size:22px; display:inline-block; width:100%; background-color:transparent; border:none;
	cursor : text;
}

footer.footer.navbar-wrapper {
    z-index: 3;
}

#container {
	width: 700px;
	margin: 0 auto;
}

h1, h3, p {
	text-align: center;
}

table {
	border-collapse: collapse;
}

table, th, td {
	border: 1px solid black;
	margin: 0 auto;
}

th {
	background-color: orange;
}

.center {
	text-align: center;
}

.border-none, .border-none td {
	border: none;
}

.thum_select::after {
	content: "";
	clear: both;
	display: table;
}

.radio-container {
	float: left;
	width: 33.33%;
	padding: 5px;
}

.side_active {
	background-color : #f7b5b7;
    -webkit-box-shadow: 0 15px 8px -11px rgba(0, 0, 0, 0.25);
    box-shadow: 0 15px 8px -11px rgba(0, 0, 0, 0.25);
}
</style>
<script>
$(function (){
	var board_idx = ${board_idx};
	board_idx = board_idx + 3;
	$(".pcoded-inner-navbar>ul:nth-child(" + board_idx + ")>li>a").addClass("side_active");
});

/*  	$(function() {
		 $('#summernote').summernote('code', '지역 상세 : <br> 가격 : <br> 구매일 : <br> 상품 상태 : <br> 거래 방법 : 택배 / 직거래 <br> 상품 설명 : ');
	});  */
	
	
	$(function() {
		$('#summernote').val("지역 상세 : <br> 가격 : <br> 구매일 : <br> 상품 상태 : <br> 거래 방법 : 택배 / 직거래 <br> 상품 설명 : ");
		
		$('#summernote').summernote({
			placeholder : '최대 500자 작성 가능합니다.',
			height : 300,
			lang : 'ko-KR',
			callbacks : {
				onImageUpload : function(files, editor, welEditable) {

					// 파일 업로드(다중업로드를 위해 반복문 사용)
					for (var i = files.length - 1; i >= 0; i--) {
						uploadSummernoteImageFile(files[i], this);
					}
				},

				//summernote 안의 데이터가 바뀔 때 img태그 체크
				onChange : function(contents, $editable) {
					imageChangeCheck();
				}
			}

		});
	});

/* 	$('#summernote').on('summernote.change', function(we, contents, $editable) {
		console.log('summernote\'s content is changed.');
	}); */

	function uploadSummernoteImageFile(file, el) {

		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "uploadSummernoteImageFile",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(data) {
				$(el).summernote('editor.insertImage', data.url);

			},
		});
	}

	function imageChangeCheck() {
		/* 	var $img1 = $("div img");
		 console.log($img1);
		 var imgar = new Array();
		 console.log($img1.length);
		 console.log($img1);
		 for (var n = 0; n < $img1.length ; n++){
		 imgar.push($img1[0].arrt("src"));
		 console.log(imgar[n]);
		 } */

		//이미지 추가되면 썸네일 영역 초기화
		$("#thum_select").html("");
		//이미지 추가되면 썸네일 영역 초기화
		$(".imgs").html('');
		var imgar = new Array();

		//summernote 안의 p태그 > img태그 모두 찾아 img태그 개수만큼 실행하는 메서드
		$("p")
				.find('img')
				.each(
						function() {
							console.log($(this).attr('src')); //이미지 경로 콘솔에 출력

							//썸네일 영역에 이미지 추가 및 radio로 선택하는 부분 구현
							//radio 필요없으면 input type 변경하면 됨
							$("#thum_select").append('<div class="radio-container" style="text-align:center">');
							$("#thum_select").append('<input type="radio" style="text-align:center" class="thum" name="img1" checked="checked" value="'
													+ $(this).attr('src') + '"/>');
							$("#thum_select").append('<img style="width:200px" src="'+ $(this).attr('src') + '"/>');
							$("#thum_select").append('</div>');

							//여러 개의 이미지 경로 각각 imgar 배열에 담는 부분
							imgar.push($(this).attr("src"));

							//이미지 경로 담긴 최종 imgar 배열 콘솔에 출력
							console.log("imgar: " + imgar);

						});
		//이미지 경로들 imgar 배열에 담기
		//확인 버튼 누르면 hidden img_locas 값으로 boardVO에 전달
		$(".imgs").append('<input type="hidden" name="img_locas" value="' + imgar + '">');
	}
	
	 function null_check(){
		 var price = document.getElementById('price').value;
		 var title = document.getElementById('title').value;
			if(price == "" || price == null){
				alert("가격을 입력해주세요");
				fr.price.focus();
				return false;
			} else if(title == "" || title == null){
				alert("제목을 입력해주세요");
				fr.title.focus();
				return false;
			}
			
			else return true;
			
			}
</script>

</head>
<body>

	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">

			<!-- header 헤더 영역 -->
			<%@ include file="/common/header.jsp"%>
			<!-- header 헤더 영역 -->

			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">

					<!-- sidebar 좌측메뉴바 -->
					<%@ include file="/common/communityMenuBar.jsp"%>
					<!-- sidebar 좌측메뉴바 -->

					<div class="pcoded-content">

						<!-- Page-header start -->

						<!-- Page-header end -->

						<div class="pcoded-inner-content">
							<!-- body 본문 영역 -->
							<div class="main-body">
								<div class="page-wrapper">
									<!-- Page-body start -->
									<div class="page-body">
										<section class="featured spad">
											<div class="container">
												<hr>

												<form action="insertBoard" method="post" enctype="multipart/form-data"
												 name="fr" onsubmit="return null_check()">
													<div>
														<input type="radio" name="animal_class" value="1">
														강아지 <input type="radio" name="animal_class" value="2">
														고양이 <input type="radio" name="animal_class" value="3" checked="checked">
														자유
													</div>
													<br>
													
													<div class="title-container" style="background-color : #f7f2f2; width : 100%; margin:auto; padding:15px; border-radius : 10px">
															<div class="title">
															<input type="text" id="board_title" name="board_title" >
															</div>		
															</div>	

													<table>
														<tr>
															<th width="40">제목</th>
															<td><input type="text" id="title" name="board_title" size="30">
															</td>
														</tr>
																												<tr>
															<th width="40">상품종류</th>
															<td>
								                    			<select name="goods" style="height:20px">
												                   	<option value="0" selected>식품</option>
														            <option value="1">장난감</option>
														            <option value="2">의류</option>
														            <option value="3">생활용품</option>
														            <option value="4">기타</option>
										                    	</select>
															</td>
														</tr>
																												<tr>
															<th width="40">지역</th>
															<td>
								                    			<select name="area" style="height:20px">
												                   	<option value="0" selected>서울</option>
														            <option value="1">경기</option>
														            <option value="2">인천</option>
														            <option value="3">대구</option>
														            <option value="4">부산</option>
														            <option value="5">울산</option>
														            <option value="6">광주</option>
														            <option value="7">강원</option>
														            <option value="8">충북</option>
														            <option value="9">충남</option>
														            <option value="10">경북</option>
														            <option value="11">경남</option>
														            <option value="12">전북</option>
														            <option value="13">전남</option>
														            <option value="14">제주</option>
										                    	</select>
															</td>
														</tr>
														<tr>
															<th width="40">판매 여부</th>
															<td>
								                    			<select name="is_selled" style="height:20px">
												                   	<option value="0" selected>판매 중</option>
														            <option value="1">판매 완료</option>
										                    	</select>
															</td>
														</tr>
														<tr>
															<th width="40">가격</th>
															<td>
																<input type="text" id="price" name="price" size="30">
															</td>
														</tr>
														
													</table>
													<br>

													<textarea id="summernote" name="board_content"></textarea>
													<div class="thum_select" id="thum_select" style="float: left; , padding: 500px;"></div>
													<div class="imgs"></div>
													<br> <br>
													
													<input type="hidden" name="member_serial" value="994">
													<input type="hidden" name="board_idx" value="1">
													
													<div style="text-align: center" class="enter_button">
														<input type="submit" value="확인">
													</div>

												</form>
											</div>
										</section>
									</div>

								</div>
								<!-- Page-body end -->
							</div>
							<!-- body 본문 영역 -->

							<div id="styleSelector"></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- footer 푸터 영역 -->
		<%@ include file="/common/storeFoot.jsp"%>
		<!-- footer 푸터 영역 -->

	</div>

	<!-- Required Jquery -->
	<script type="text/javascript"
		src="/resources/js/jquery/jquery.min.js "></script>
	<script type="text/javascript"
		src="/resources/js/jquery-ui/jquery-ui.min.js "></script>
	<script type="text/javascript"
		src="/resources/js/popper.js/popper.min.js"></script>
	<script type="text/javascript"
		src="/resources/js/bootstrap/js/bootstrap.min.js "></script>
	<!-- waves js -->
	<script src="/resources/pages/waves/js/waves.min.js"></script>
	<!-- jquery slimscroll js -->
	<script type="text/javascript"
		src="/resources/js/jquery-slimscroll/jquery.slimscroll.js"></script>

	<!-- slimscroll js -->
	<script src="/resources/js/jquery.mCustomScrollbar.concat.min.js "></script>

	<!-- menu js -->
	<script src="/resources/js/pcoded.min.js"></script>
	<script src="/resources/js/vertical/vertical-layout.min.js "></script>

	<script type="text/javascript" src="/resources/js/script.js "></script>
    <script>
      $(".btn-group-toggle").twbsToggleButtons();
      </script>

</body>
</html>






