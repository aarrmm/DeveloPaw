<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<meta name="keywords"
	content="bootstrap, bootstrap admin template, admin theme, admin dashboard, dashboard template, admin template, responsive" />
<meta name="author" content="Codedthemes" />
<!--Jua 폰트 import-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
	rel="stylesheet">

<!-- Dohyeon 폰트 import-->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">

<!-- Favicon icon -->
<link rel="icon" href="../resources/images/favicon.ico"
	type="image/x-icon">
<!-- Google font-->
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700"
	rel="stylesheet">
<!-- waves.css -->
<link rel="stylesheet"
	href="../	resources/pages/waves/css/waves.min.css" type="text/css"
	media="all">
<!-- Required Fremwork -->
<link rel="stylesheet" type="text/css"
	href="../resources/css/bootstrap/css/bootstrap.min.css">
<!-- waves.css -->
<link rel="stylesheet" href="../resources/pages/waves/css/waves.min.css"
	type="text/css" media="all">
<!-- themify icon -->
<link rel="stylesheet" type="text/css"
	href="../resources/icon/themify-icons/themify-icons.css">
<!-- font-awesome-n -->
<link rel="stylesheet" type="text/css"
	href="../resources/css/font-awesome-n.min.css">
<link rel="stylesheet" type="text/css"
	href="../resources/css/font-awesome.min.css">
<!-- scrollbar.css -->
<link rel="stylesheet" type="text/css"
	href="../resources/css/jquery.mCustomScrollbar.css">
<!-- Style.css -->
<link rel="stylesheet" type="text/css" href="/resources/css/style.css">
<link rel="stylesheet" type="text/css" href="/resources/css/cartStyle.css">
<link rel="stylesheet" type="text/css" href="/resources/css/test.css">
<style>
.featured__item__text {
	width: 150px;
}
</style>

</head>

<body>
	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">

			<%@include file="/common/storeHeader.jsp"%>

			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">

					<%@include file="/common/storeMenuBar.jsp"%>

					<div class="pcoded-content">
						<!-- Page-header start -->

						<!-- Page-header end -->
						<div class="pcoded-inner-content">
							<!-- Main-body start -->
							<!-- OrderList Section Begin -->
							<section class="shopping-cart spad">
								<div class="container">
									<div class="row">
										<div class="col-lg-12">
											<div class="cart-table" style="background-color: white;">
												<table>
													<thead>
														<tr>
															<th>주문번호</th>
															<th class="p-name">상품명</th>
															<th>주문일자</th>
															<th>주문금액</th>
														</tr>
													</thead>
													<c:if test="${empty orderList}">
														<h3>주문 내역이 존재하지 않습니다.</h3>
													</c:if>
													<c:if test="${not empty orderList}">
														<c:forEach var="oList" items="${orderList }">
															<tbody class="oList_${oList.order_id}">
																<tr>
																	<td class="cart-pic first-row"><a
																		href="storeOrderDetail?order_id=${oList.order_id }">${oList.order_id}</a></td>
																	<td class="cart-title first-row">${oList.p_name }</td>
																	<td class="p-price first-row">${oList.order_date}</td>
																	<td class="total-price first-row" ><fmt:formatNumber value="${oList.totalSum }" pattern="#,###" />원</td>
																</tr>
															</tbody>
														</c:forEach>
													</c:if>
												</table>
											</div>
										</div>
									</div>
								</div>
							</section>
							<!-- Order List Section End -->
							<br> <br>
							<div id="styleSelector"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<%@include file="/common/storeFoot.jsp" %>

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
