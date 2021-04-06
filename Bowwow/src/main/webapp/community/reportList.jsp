<%@page import="ga.bowwow.service.board.Board"%>
<%@page import="java.util.List"%>
<%@page import="ga.bowwow.service.board.impl.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<meta name="keywords"
	content="bootstrap, bootstrap admin template, admin theme, admin dashboard, dashboard template, admin template, responsive" />
<meta name="author" content="Codedthemes" />
<!--Jua 폰트 import-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">

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
<!-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css"> -->
<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
<link rel="stylesheet" type="text/css" href="/resources/css/test.css">

<title>펫 다이어리</title>
<style>
</style>
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
												<div class="row">
													<div class="col-lg-12">
														<div class="section-title">
															<h2>신고 게시판</h2>
														</div>
														<br>
													</div>
												</div>
												<div class="monthly-products">
													
																<table>
		<thead>
			<tr class="title" style="border-top:none;">
			<c:set var="idx" value="${report_idx }"/>
				<th class="r_no">신고번호</th>
				<th class="r_class">신고분류</th>
				<th class="r_class">게시판 종류</th>
				<c:if test="${idx == 1 }">
				<th class="b_title">글 제목</th>
				</c:if>
				<c:if test="${idx == 2 }">
				<th class="c_content">댓글 내용</th>
				</c:if>
				<th class="r_date">신고일</th>
				<th class="r_date">처리일</th>
				<th class="r_result">처리결과</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${ reportList}">
			
				<tr class="list" onclick="location.href = '/savanna/controller?type=memDetail&id=${vo.id }'">
					<td style="width: 70px; text-align: center;">${list.report_no }</td>
					<td style="width: 70px; text-align: center;">${list.report_class }</td>
					<td style="width: 80px;">${list.board_class }</td>
					<c:if test="${idx == 1 }">
					<td style="width: 300px;">${list.report_content }</td>
					</c:if>
					<c:if test="${idx == 2 }">
					<td style="width: 300px;">${list.report_content }</td>
					</c:if>
					<td style="width: 80px;">${list.report_date}</td>
					<c:set var="h_date" value="${list.handled_date }"/>
					<c:if test="${null eq h_date }">
					<td style="width: 80px;">-</td>
					</c:if>
					<c:if test="${null ne h_date }">
					<td style="width: 80px;">${list.handled_date }</td>
					</c:if>
					<td style="width: 80px;">${list.result }</td>
				</tr>
	
		</c:forEach>
		</tbody>
		<tfoot>
		</tfoot>
		</table>

													
											
			
												</div>
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
		<button class="scroll-top" id="js-button"
			style="margin-bottom: 190px; margin-right: 30px; font: 'Jua'">
			<i class="fa fa-chevron-up" aria-hidden="true">TOP</i>
		</button>
		<script type="text/javascript">
			scrollTop('js-button', 100);
			function scrollTop(elem, duration) {
				let target = document.getElementById(elem);

				target.addEventListener('click', function() {
					let currentY = window.pageYOffset;
					let step = duration / currentY > 1 ? 10 : 100;
					let timeStep = duration / currentY * step;
					let intervalID = setInterval(scrollUp, timeStep);

					function scrollUp() {
						currentY = window.pageYOffset;
						if (currentY === 0) {
							clearInterval(intervalID);
						} else {
							scrollBy(0, -step);
						}
					}
				});
			}
		</script>

		<!-- footer 푸터 영역 -->
		<%@ include file="/common/footer.jsp"%>
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

</body>
</html>






																			