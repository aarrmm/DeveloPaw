<%@page import="ga.bowwow.service.user.VO.UserAccount"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%
	//임시 로그인처리
	int memberSerial = 1;
	String id = "z";
	UserAccount user= new UserAccount();
	user.setId(id);
	user.setMemberSerial(memberSerial);
	session.setAttribute("user", user);
%>
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
    <!--Jua 폰트 import-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">

    <!-- Dohyeon 폰트 import-->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

    <!-- Favicon icon -->
    <link rel="icon" href="/main/resources/images/favicon.ico" type="image/x-icon">
    <!-- Google font-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700" rel="stylesheet">
    <!-- waves.css -->
    <link rel="stylesheet" href="/main/resources/pages/waves/css/waves.min.css" type="text/css" media="all">
    <!-- Required Fremwork -->
    <link rel="stylesheet" type="text/css" href="/main/resources/css/bootstrap/css/bootstrap.min.css">
    <!-- waves.css -->
    <link rel="stylesheet" href="/main/resources/pages/waves/css/waves.min.css" type="text/css" media="all">
    <!-- themify icon -->
    <link rel="stylesheet" type="text/css" href="/main/resources/icon/themify-icons/themify-icons.css">
    <!-- font-awesome-n -->
    <link rel="stylesheet" type="text/css" href="/main/resources/css/font-awesome-n.min.css">
    <link rel="stylesheet" type="text/css" href="/main/resources/css/font-awesome.min.css">
    <!-- scrollbar.css -->
    <link rel="stylesheet" type="text/css" href="/main/resources/css/jquery.mCustomScrollbar.css">
    <!-- Style.css -->
    <link rel="stylesheet" type="text/css" href="/main/resources/css/style.css">
    <link rel="stylesheet" type="text/css" href="/main/resources/css/test.css">
    <!-- 개별CSS -->
    <link rel="stylesheet" type="text/css" href="/main/resources/css/myinfo.css">
<style>
.form-group.container {
	display: table;
    width: 100%;
    table-layout: fixed;
    border-top: 1px #7F858F solid;
    border-bottom: 1px #7F858F solid;
    font-size: 15px;
}
.reason_one>ul, .reason_two>ul{
	display : table-row;
}
.reason_one>ul>li, .reason_two>ul>li{
	display: table-cell;
}
.withdrawlAgreement{
	padding-top : 20px;
}
.center{
	text-align : center;
}
.textarea {
	box-sizing: border-box;
    padding: 6px 9px;
    width: 100%;
    font-size: 13px;
    line-height: 1.4;
}
@media only screen and (max-width: 500px) {
	.reason_one>ul>li { padding:10px 5px; }
	.reason_one>ul>li {padding:5px;}
	.reason_one.input_form>ul>li { padding:5px; }
	.reason_one>ul>li.th {width:20%;}
}
</style>
</head>

<body>    
<div id="pcoded" class="pcoded">
	<div class="pcoded-overlay-box"></div>
	<div class="pcoded-container navbar-wrapper">
		<!-- header -->
		<%@include file="/common/header.jsp" %>

		<div class="pcoded-main-container">
			<div class="pcoded-wrapper">

			<!-- 좌측 메뉴바 시작 -->
			<%@include file="/common/myPageMenuBar.jsp" %>
               <div class="pcoded-content">
                  <div class="pcoded-inner-content">
					<!-- Main-body start 본문 시작 -->
					<div class="main-body">
					<div class="page-wrapper">
                                
						<!-- Page-body start -->
						<div class="page-body">
						<div class="myPageInfo-header">
							<h2> 뫄뫄님의 페이지</h2>
						</div>
<<<<<<< HEAD
						
					    <button class="scroll-top" id="js-button" style="margin-bottom: 190px; margin-right: 30px;">
				        <i class="fa fa-chevron-up" aria-hidden="true">TOP</i>
					    </button>
					    <script type="text/javascript">
					        scrollTop('js-button', 500);
					        function scrollTop(elem,duration) {
					            let target = document.getElementById(elem);
					        
					            target.addEventListener('click', function() {
					                let currentY = window.pageYOffset; 
					                let step = duration/currentY > 1 ? 10 : 100;
					                let timeStep = duration/currentY * step;
					                let intervalID = setInterval(scrollUp, timeStep);
					        
					                function scrollUp(){
					                    currentY = window.pageYOffset;
					                    if(currentY === 0) {
					                        clearInterval(intervalID);
					                    } else {
					                        scrollBy( 0, -step );
					                    }
					                }
					            });
					        }
					    </script>
	        
						<!-- footer 푸터 시작부분-->
						<%@include file="/common/footer.jsp" %>
						<!-- footer 푸터 끝부분-->
								</div>
=======
						<form>
							<div class="form-group container reason_one">					
								<ul class="tr">
									<li class="th">탈퇴사유</li>
									<li class="td">
										<div class="label-group">
										<label>
											<input type="radio" name="reasonOne" id="inlineRadio1" value="사이트 이용 불편">
											사이트 이용 불편 &nbsp;
										</label>
										<label>
											<input type="radio" name="reasonOne" id="inlineRadio2" value="서비스 불만족">
											서비스 불만족 &nbsp;
										</label>
										<label>
											<input type="radio" name="reasonOne" id="inlineRadio3" value="상품 불만족">
											상품 불만족 &nbsp;
										</label>
										<label>
											<input type="radio" name="reasonOne" id="inlineRadio4" value="배송 불만족">
											배송 불만족 &nbsp;
										</label>
										<label>
											<input type="radio" name="reasonOne" id="inlineRadio5" value="기타">
											기타
										</label>
										</div>
									</li>
								</ul>
							</div>						
							<div class="form-group container reason_two">
								<ul class="tr">
									<li class="th">내용</li>
									<li class="td">
										<textarea class="form-control" name="reasonTwo" id="reasonTwo"></textarea>
									</li>
								</ul>
							</div>
							<div class="withdrawlAgreement center">탈퇴할 시 회원님의 포인트를 포함한 개인정보가 삭제되고, 본 사이트의 커뮤니티 및 스토어를 이용하실 수 없습니다.</div>
							<div class="withdrawlAgreement2 center">
								<label>
									<input type="checkbox" name="agree" value="Y"> 동의합니다.
								</label>
							</div>
							<div class="btn-area center">
								<button type="button" id="btn_submit" >탈퇴하기</button>
								<a href="javascript:history.back();" >취소</a>
>>>>>>> origin/areum
							</div>
						</form>
						</div>
					</div>
				</div>
			</div>
		</div>
<<<<<<< HEAD
=======
	</div>
</div>
		<!-- footer 푸터 시작부분-->
		<%@include file="/common/footer.jsp" %>
		<!-- footer 푸터 끝부분-->
>>>>>>> origin/areum
	</div>
</div>

    <!-- Required Jquery -->
    <script type="text/javascript" src="/main/resources/js/jquery/jquery.min.js "></script>
    <script type="text/javascript" src="/main/resources/js/jquery-ui/jquery-ui.min.js "></script>
    <script type="text/javascript" src="/main/resources/js/popper.js/popper.min.js"></script>
    <script type="text/javascript" src="/main/resources/js/bootstrap/js/bootstrap.min.js "></script>
    <!-- waves js -->
    <script src="/main/resources/pages/waves/js/waves.min.js"></script>
    <!-- jquery slimscroll js -->
    <script type="text/javascript" src="/main/resources/js/jquery-slimscroll/jquery.slimscroll.js"></script>

    <!-- slimscroll js -->
    <script src="/main/resources/js/jquery.mCustomScrollbar.concat.min.js "></script>

    <!-- menu js -->
    <script src="/main/resources/js/pcoded.min.js"></script>
    <script src="/main/resources/js/vertical/vertical-layout.min.js "></script>

    <script type="text/javascript" src="/main/resources/js/script.js "></script>
</body>
</html>