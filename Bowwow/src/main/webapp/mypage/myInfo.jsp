<%@page import="ga.bowwow.service.user.VO.UserAccount"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <% request.setCharacterEncoding("UTF-8"); %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%
	//임시 로그인처리
	int memberSerial = 1;
	String id = "z";
	UserAccount user= new UserAccount();
	user.setId(id);
	user.setMemberSerial(memberSerial);
	session.setAttribute("user", user);
%> --%>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <meta name="keywords" content="bootstrap, bootstrap admin template, admin theme, admin dashboard, dashboard template, admin template, responsive" />
    <meta name="author" content="Codedthemes" />
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <!-- 다음 주소찾기 API -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	<!-- 개별css -->
    <!-- <link rel="stylesheet" type="text/css" href="/resources/css/myinfo.css"> -->
<style>
  .myPageInfo-header {
  	text-align: center;
  }  
  .myPageInfo-wrapper {
	display: flex;
	justify-content: center;
  }
  
 .side-content {
	position: relative;
	display: inline-block;
	float: left;
 }
 .side-content .my-area {
    border-radius: 70px;
    margin: 30px;
    border: 1px solid rgba(228, 228, 228, 0.5);
    border-radius: 10px;
 
 }
 .side-content .my-area .side-profile-img{
	/* float: left; */
    background-size: cover;
    width: 140px;
    height: 140px;
    border-radius: 70px;
    margin: 0 auto 10px;
}

  .side-content .my-area p{
    text-align: center;
    font-size: 20px;
    font-weight: 700;
    line-height: 29px;
}

 .mainMypage-content {
 	display: inline-block;
    width: calc( 100% - 280px);
    margin-bottom: 50px;
    float : right;
}
 .block-title a{
    line-height: 28px;
    color: #b0b0b0;
    font-size: 10px;
    font-weight: 300;
    border: 0;
    background: none;
    float: right;
    margin-right: 50px;
 }
.block-title h3{
	font-size: 1.5em;
}
.form-control #noborderline {
	background-color : f3f3f3;
	border: none;
}
.passinput { 
	position: relative; 
} 
.passinput .eyes { 
	position: absolute; 
	top: 0; 
	bottom: 0; 
	right: 20px; 
	margin: auto 2px; 
	height: 30px; 
	font-size: 20px; 
	cursor: pointer; 
}

</style>
<script>

$(function(){
	//아이디, 이름 변경불가
	//이메일 - input type="email"
	//전화번호 - input type="tel" pattern="(010|011|016|017|018|019)-\d{4}-\d{4}"(폰번호만허용)
	
	//gender radio버튼에 체크!(값 없으면 체크X)
	const checkValue = '${sessionScope.user.gender }';
	$("input[name=gender]").filter("input[value='"+checkValue+"']").attr("checked",true);
	
});

 function sample4_execDaumPostcode() {
     new daum.Postcode({
         oncomplete: function(data) {
             // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

             // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
             // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
             var roadAddr = data.roadAddress; // 도로명 주소 변수
             var extraRoadAddr = ''; // 참고 항목 변수

             // 법정동명이 있을 경우 추가한다. (법정리는 제외)
             // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
             if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                 extraRoadAddr += data.bname;
             }
             // 건물명이 있고, 공동주택일 경우 추가한다.
             if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
             }
             // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
             if(extraRoadAddr !== ''){
                 extraRoadAddr = ' (' + extraRoadAddr + ')';
             }

             // 우편번호와 주소 정보를 해당 필드에 넣는다.
             document.getElementById('sample4_postcode').value = data.zonecode;
             document.getElementById("sample4_roadAddress").value = roadAddr;
             document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

             // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
             if(roadAddr !== ''){
                 document.getElementById("sample4_extraAddress").value = extraRoadAddr;
             } else {
                 document.getElementById("sample4_extraAddress").value = '';
             }

             var guideTextBox = document.getElementById("guide");
             // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
             if(data.autoRoadAddress) {
                 var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                 guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                 guideTextBox.style.display = 'block';

             } else if(data.autoJibunAddress) {
                 var expJibunAddr = data.autoJibunAddress;
                 guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                 guideTextBox.style.display = 'block';
             } else {
                 guideTextBox.innerHTML = '';
                 guideTextBox.style.display = 'none';
             }
         }
     }).open();
 }


</script>
</head>

<body>
	<!-- Pre-loader start -->
	<div class="theme-loader">
		<div class="loader-track">
			<div class="preloader-wrapper">
				<div class="spinner-layer spinner-blue">
					<div class="circle-clipper left">
						<div class="circle"></div>
					</div>
					<div class="gap-patch">
						<div class="circle"></div>
					</div>
					<div class="circle-clipper right">
						<div class="circle"></div>
					</div>
				</div>
				<div class="spinner-layer spinner-red">
					<div class="circle-clipper left">
						<div class="circle"></div>
					</div>
					<div class="gap-patch">
						<div class="circle"></div>
					</div>
					<div class="circle-clipper right">
						<div class="circle"></div>
					</div>
				</div>

				<div class="spinner-layer spinner-yellow">
					<div class="circle-clipper left">
						<div class="circle"></div>
					</div>
					<div class="gap-patch">
						<div class="circle"></div>
					</div>
					<div class="circle-clipper right">
						<div class="circle"></div>
					</div>
				</div>

				<div class="spinner-layer spinner-green">
					<div class="circle-clipper left">
						<div class="circle"></div>
					</div>
					<div class="gap-patch">
						<div class="circle"></div>
					</div>
					<div class="circle-clipper right">
						<div class="circle"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
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
							<h2> ${sessionScope.user.id }님의 페이지</h2>
						</div>
						<div class="myPageInfo-wrapper">

								<!-- 회원정보수정 부분 -->
								<div class="form-group">
									<div class="input-content">
									<div class="side-content">
										<div class="my-area">
											<div class="side-profile-img">
												<%-- <img src="${sessionScope.user.image_source }" alt="이미지없음~"> --%>
												<img src="" alt="이미지없음~">
											</div>
											<p>${sessionScope.user.nickname }</p>
										</div>
									</div>

									<div class="mainMypage-content">
									<div class="block-title">
										<h3>정보수정</h3>
										<a href="withdrawl">회원탈퇴</a>
									</div>
									<form class="form-myinfo" action="" method="post">
  <div class="form-group">
    <label for="inputId" class="col-sm-4 control-label">아이디(변경불가)</label>
    <div class="col-sm-8">
		<input type="text" class="form-control" id="noborderline" value="${sessionScope.user.id }" disabled>
    </div>
  </div>
  <div class="form-group">
    <label for="inputPassword" class="col-sm-4 control-label">Password</label>
    <div class="col-sm-8 passinput">
      <input type="password" class="form-control password" name="password" id="password" placeholder="Password">
    </div>
  </div>
  <div class="form-group">
    <label for="inputPassword2" class="col-sm-4 control-label">Password 확인</label>
    <div class="col-sm-8 passinput2">
      <input type="password" class="form-control password" id="password2" placeholder="Password 재입력">
    </div>
  </div>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-4 control-label">이름(변경불가)</label>
    <div class="col-sm-8">
   		<input type="text" class="form-control" id="noborderline" value="${sessionScope.user.realname }" disabled>
    </div>
  </div>
  <div class="form-group">
    <label for="inputNickname" class="col-sm-4 control-label">닉네임</label>
    <div class="col-sm-8">
      <input type="text" class="form-control" name="nickname" id="inputNickname" value="${sessionScope.user.nickname}">
    </div>
  </div>
  <div class="form-group">
    <label for="inputGender" class="col-sm-4 control-label">성별</label>
    <div class="col-sm-8">
      <label class="radio-inline">
        <input type="radio" name="gender" id="gender_f" value="F"> 여자
      </label>
      <label class="radio-inline">
        <input type="radio" name="gender" id="gender_m" value="M"> 남자
      </label>
    </div>
  </div>
  <div class="form-group">
    <label for="inputEmail" class="col-sm-4 control-label">이메일</label>
    <div class="col-sm-8">
      <input type="email" class="form-control" name="email" id="inputEmail" value="${sessionScope.user.email }">
    </div>
  </div>
  <div class="form-group">
    <label for="inputAddress" class="col-sm-4 control-label">주소</label>
    <div class="col-sm-8">
     <div>
		<input type="text" id="sample4_postcode" placeholder="우편번호">
		<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="sample4_roadAddress" placeholder="도로명주소">
		<input type="text" id="sample4_jibunAddress" placeholder="지번주소">
		<span id="guide" style="color:#999;display:none"></span>
		<input type="text" id="sample4_detailAddress" placeholder="상세주소">
		<input type="text" id="sample4_extraAddress" placeholder="참고항목">
	</div>
    </div>
  </div>
  <div class="form-group">
    <label for="inputPhone" class="col-sm-4 control-label">휴대폰번호</label>
    <div class="col-sm-8">
	  <input type="tel" class="form-control" name="phone" id="inputPhone" pattern="(010|011|016|017|018|019)-\d{4}-\d{4}" placeholder="010-1234-4567형식으로 입력">
    </div>
  </div>
     <div class="form-group">
    <label for="inputBirth" class="col-sm-4 control-label">생일</label>
    <div class="col-sm-8">
      <input type="date" class="form-control" name="birthday" id="inputBirthday" value="${sessionScope.user.birthday }">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-8">
      <button type="submit" class="btn btn-default">정보수정!</button>
    </div>
  </div>
</form>
								</div>
								</div>
	  						  </div>
							</div>
						</div>
					</div>
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
