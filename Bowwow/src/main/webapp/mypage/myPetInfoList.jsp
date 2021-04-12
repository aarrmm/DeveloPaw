<%@page import="ga.bowwow.service.user.VO.UserAccount"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<%-- <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<head>
    <title>개발바닥</title>
    <!-- HTML5 Shim and Respond.js IE10 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 10]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
      <![endif]-->
    <!-- Meta -->
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html;charset-UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <meta name="keywords" content="bootstrap, bootstrap admin template, admin theme, admin dashboard, dashboard template, admin template, responsive" />
    <meta name="author" content="Codedthemes" />
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <!--Jua 폰트 import-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">

    <!-- Dohyeon 폰트 import-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

    <!-- Favicon icon -->
    <link rel="icon" href="/resources/images/favicon.ico" type="image/x-icon">
    <!-- Google font-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700" rel="stylesheet">
    <!-- waves.css -->
    <link rel="stylesheet" href="/resources/pages/waves/css/waves.min.css" type="text/css" media="all">
    <!-- Required Fremwork -->
    <link rel="stylesheet" type="text/css" href="/resources/css/bootstrap/css/bootstrap.min.css">
    <!-- waves.css -->
    <link rel="stylesheet" href="/resources/pages/waves/css/waves.min.css" type="text/css" media="all">
    <!-- themify icon -->
    <link rel="stylesheet" type="text/css" href="/resources/icon/themify-icons/themify-icons.css">
    <!-- font-awesome-n -->
    <link rel="stylesheet" type="text/css" href="/resources/css/font-awesome-n.min.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/font-awesome.min.css">
    <!-- scrollbar.css -->
    <link rel="stylesheet" type="text/css" href="/resources/css/jquery.mCustomScrollbar.css">
    <!-- Style.css -->
    <link rel="stylesheet" type="text/css" href="/resources/css/style.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/test.css">
<style>
.insert-title{
	width : 18%;
}
/* 반려동물 정보 출력영역 설정*/
.col-md-4 .list-inner{
	text-align : center;
	margin: 10px 0px 10px 0px;
}
/*반려동물 리스트 썸네일 이미지 출력영역 사이즈조정*/
.col-md-4 .list-inner .pet-img{
	margin : 0 auto;
	width : 100%;
	height : 100%;
}
.action-button{
	display : flex;
	justify-content: center;
}
.box-detail h5, h4{
	color:#ff6347;
}
.action-button-inner{
	margin : 20px 0 0 0 ;
}
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
.modal-title { margin: 0 auto;}
#detail_petname {
	text-align: center;
	margin: 5px 0 5px 0;
}
.classname { 
	max-width:100%;
	height:auto 
}
tr td textarea{
	width : 100%;
}
/*파일첨부시 미리보기영역*/
#thumb_container{ 
	width : 200px;
	height : 200px;
}
/**/
#detail_petimg{
	width : 100%;
	height : 100%;
	text-align : center;
}
#thumb_container-detail{
	width : 50%;
	height : 50%;
}

.detailClass, .box-detail {
	padding-left:5px;
	padding-right:5px;
}
.detailClass {
	font-size:1.2em;
	color : #212529;
}
/*특이사항출력시 자동 줄바꿈*/
pre{
	overflow: auto;
	white-space: pre-wrap;
	word-break: break-all;
}
#updatePetInfo .input[type=text]{
	border:none;
	border-bottom: 1px solid black;
}
ul li {
    list-style-type: none;
}
#textMain-wrap {
	text-align: center;
}
 .ttest {
     width: 80%;
     margin : 5px 0 0 0; 
     display: inline-block;
 }

 .test1 {
     float: left;
     width: 50%;
     margin: 0 auto;
     text-align: left;
 }
 .test2{
     float: right;
     width: 50%;
     margin: 0 auto;
       text-align: left;
 }
 
 .test3{
     width: 80%;
     margin: 0 auto;
 }
  .div-center { margin: 0 auto;}
  .text-center {
  	text-align : center;
  	margin: 0 auto;
  	color : #ff6347;
  }
</style>
<script type="text/javascript" src="/common/commonThumbnail.js"></script>
<script>

$().ready(function(){
	var imgFile = $('#inputimage').val();
	var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp)$/;
	
	if(imgFile != "" && imageFile != null) {
		if(!imgFile.match(fileForm)) {
	    	alert("이미지 파일만 업로드 가능");
	        return;
	    }
	}
});

function deletepet(frm){
	frm.action="/deletePetInfo";
	frm.method="post";
	frm.submit();
}

function getPetInfo(frm){
	console.log("getPetInfo 시작");
	var pSerial = frm.thispetserial.value;
	console.log(pSerial);

	var serialData =  { 'pet_serial' : pSerial };
	console.log(serialData);

	var imgloca = $('.pet-img').attr('src');
	console.log(imgloca);

	$.ajax("/ajaxGetPetInfo", {
		type : "post",
		data : serialData ,
		async : "false",
		dataType: "json",
		success : function(petDetail){
			console.log("성공");
			console.log(petDetail);

			if(petDetail.pet_birth === undefined
					|| petDetail.pet_birth === ""
						|| petDetail.pet_birth === null){
				petDetail.pet_birth = "- / - / -";
			}
			
			$("#detail_petname").html(petDetail.pet_name);
			$("#detail_gender").html(petDetail.pet_gender);
			$("#detail_pet_serial").val(petDetail.pet_serial);
			$("#detail_variety").html(petDetail.pet_variety);
			$("#detail_birth").html(petDetail.pet_birth);
			$("#detail_age").html(petDetail.pet_age);
			$("#detail_size").html(petDetail.pet_size);
			$("#detail_weight").html(petDetail.pet_weight + " kg");
			$("#detail_neck").html(petDetail.neck_length + " cm");
			$("#detail_back").html(petDetail.back_length + " cm");
			$("#detail_chest").html(petDetail.chest_length + " cm");
			$("#detail_etc").html(petDetail.pet_etc);
			$("#thumb_container-detail").prop("src", "https://projectbit.s3.us-east-2.amazonaws.com/"+petDetail.image_source_oriname);

			$("#detail_tnr").val(petDetail.tnr);									 // hidden
			$("#detail_member_serial").val("${sessionScope.userDTO.member_serial }");// hidden
			$("#detail_pet_serial").val(petDetail.pet_serial);					     // hidden

			$("#petDetail").modal('show'); //모달창 오픈

			setModiInfo(petDetail);//정보수정창에 미리 정보전달

		}, error : function(){
			console.log("에러발생");
		}
	});
}

//정보수정창 값 입력해놓기(?)
function setModiInfo(petDetail){
	$("#modi_petname").val(petDetail.pet_name);
	$("#modi_petgender").val(petDetail.pet_gender);
	$("#modi_pet_serial").val(petDetail.pet_serial);
	$("#modi_variety").val(petDetail.pet_variety);
	$("#modi_petbirth").val(petDetail.pet_birth);
	$("#modi_petage").val(petDetail.pet_age);
	$("#modi_size").val(petDetail.pet_size);
	$("#modi_weight").val(petDetail.pet_weight);
	console.log($("#modi_weight").val());
	$("#modi_neck").val(petDetail.neck_length);
	$("#modi_back").val(petDetail.back_length);
	$("#modi_chest").val(petDetail.chest_length);
	$("#modi_etc").html(petDetail.pet_etc);
	$("#modi_animal_type").val(petDetail.animal_type);
	//$("#thumb_container").prop("src", petDetail.image_source);
	//$("#modi_image").val(petDetail.image_source);
	
	$("#modi_tnr").val(petDetail.tnr);				// hidden
	$("#modi_member_serial").val("${sessionScope.userDTO.member_serial }");	// hidden
	$("#modi_pet_img").val("https://projectbit.s3.us-east-2.amazonaws.com/"+petDetail.image_source_oriname);	// hidden
	$("#modi_pet_serial").val(petDetail.pet_serial);	// hidden
}

 function transferType(){
	 console.log("test");
	 var type = $("#selectPetType input[type='radio'][name='animal_type']:checked").val();
	 if(typeof type == "undefined" || type == null || type == ""){
		 alert("선택해ㅡㅡ");
	 } else {
		 $("#newPet #insert_animal_type").val(type);
		 $("#newPet #insert_member_serial").val("${sessionScope.userDTO.member_serial }");
		 console.log($("#newPet #insert_animal_type").val());
		 console.log($("#newPet #insert_member_serial").val());
		 $("#newPet").modal('show');
	 }
 }

 function inputMemberSerial(){
	// 유저번호
	 var mSerial = "${sessionScope.userDTO.member_serial }";
	 console.log(mSerial);

	 $("#insertPetInfo #insert_member_serial").val(mSerial);
 }

function clearInput(){
	// 정보입력하다가 취소하면 입력했던 것 지우기
	var inputText = $("#insertPetform input[type='text']");
	for(var i = 0; i < inputText.length; i++){
		inputText[i].value = "";
	}
	var inputSelect = $("#insertPetform input[type='select']");
	for(var i = 0; i < inputSelect.length; i++){
		inputSelect[i].checked = false;
	}
	var typeCheck = $("#selectPetType input[type='radio']");
	for(var i = 0; i < typeCheck.length; i++){
		typeCheck[i].checked = false;
	}
	var child = document.getElementById("thumbnailImage");
	child.parentNode.removeChild(child);

}


</script>
</head>

<body>
	<!-- Pre-loader start -->

	<!-- Pre-loader end -->
	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">
			<!-- header -->
			<%@include file="/common/header.jsp" %>

			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">

				<!-- 좌측 메뉴바 시작 -->
				<%@include file="/common/myPageMenuBar.jsp" %>

				<!-- 본문 시작 -->
                    <div class="pcoded-content">
                        <div class="pcoded-inner-content">
							<!-- Main-body start 본문 시작 -->
							<div class="main-body">
							<div class="page-wrapper">
		                        <!-- Page-body start -->
								<div class="page-body">
									<div class="myPageInfo-header">
										<h2 style="text-align: center;"> ${sessionScope.userDTO.nickname }님이 등록한 반려동물</h2>
									</div>
                                        <div class="row">
                                        <c:if test="${not empty petList }">
                                        <c:forEach var="pet" items="${petList }">
	                                        <div class="col-md-4">
		                                        <div class="list-inner">
			                                        <div class="pet-img" style="width: 250px; height: 250px;">
			                                        	<img src="https://projectbit.s3.us-east-2.amazonaws.com/${pet.image_source_oriname }" alt="이미지" class="img-circle img-thumbnail" id="img-thumbnail" style="width: 250px; height: 250px;">
			                                        </div>
			                                        <div class="pet-name">${pet.pet_name }</div>
			                                        <div class="pet-detail">
			                                        <form name="thisform">
				                                        <input type="hidden" name="thispetserial" value="${pet.pet_serial }">
				                                        <%-- <input type="hidden" name="thismemberserial" id="thismem" value="${sessionScope.userDTO.member_serial }"> --%>
				                                        <input type="button" class="btn btn-outline-secondary"  value="상세보기" data-toggle="modal" role="button" onclick="getPetInfo(this.form)">
			                                        </form>
			                                        </div>
		                                        </div>
	                                        </div>
                                        </c:forEach>
                                        </c:if>
                                        <c:if test="${empty petList }">
                                        	<div class="col-md-6 div-center">
	                                        <div class="list-inner">
		                                        	<h3 class="text-center">등록된 반려동물이 없습니다.</h3>
		                                        </div>
	                                        </div>
                                        </c:if>
                                       </div>
                                        <div class="action-button">
	                                        <div class="action-button-inner">
	                                        	<input type="hidden" id="member_serial" name="member_serial" value="${sessionScope.userDTO.member_serial }">
	                                        	<input type="button" class="btn btn-outline-secondary"  value="반려동물 추가하기" data-toggle="modal" data-target="#petType" role="button" onclick="inputMemberSerial()">
	                                        </div>
                                        </div>
                                   </div>
								<!-- 본문 컨텐츠 -->
								<%@include file="/mypage/petcontent.jsp" %>

								  <!-- Page-body end -->
                                  </div>
                                <div id="styleSelector"> </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
		   	<!-- footer 푸터 시작부분-->
			<%@include file="/common/footer.jsp" %>
			<!-- footer 푸터 끝부분-->
         </div>
	</div>


    <!-- Required Jquery -->
    <script type="text/javascript" src="/resources/js/jquery/jquery.min.js "></script>
    <script type="text/javascript" src="/resources/js/jquery-ui/jquery-ui.min.js "></script>
    <script type="text/javascript" src="/resources/js/popper.js/popper.min.js"></script>
    <script type="text/javascript" src="/resources/js/bootstrap/js/bootstrap.min.js "></script>
    <!-- waves js -->
    <script src="/resources/pages/waves/js/waves.min.js"></script>
    <!-- jquery slimscroll js -->
    <script type="text/javascript" src="/resources/js/jquery-slimscroll/jquery.slimscroll.js"></script>

    <!-- slimscroll js -->
    <script src="/resources/js/jquery.mCustomScrollbar.concat.min.js "></script>

    <!-- menu js -->
    <script src="/resources/js/pcoded.min.js"></script>
    <script src="/resources/js/vertical/vertical-layout.min.js "></script>

    <script type="text/javascript" src="/resources/js/script.js "></script>
</body>


</html>
