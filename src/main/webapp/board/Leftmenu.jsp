<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>ONE DO</title>
<link href="${pageContext.request.contextPath}/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/font-awesome.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/prettyPhoto.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/price-range.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/animate.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/main.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/responsive.css"
	rel="stylesheet">
<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
<link rel="shortcut icon" href="${path}/images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="${pageContext.request.contextPath}/images/ico/apple-touch-icon-57-precomposed.png">
<script type="text/javascript" src="${path}/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#inputGoodsName")
				.on(
						"keyup",
						function(key) {
							if (key.keyCode == 13) {
								let goodsName = $(this).val();
								location.href = "${path}/front?key=goods&methodName=selectMulipleGoods&searchField=goodsName&searchValue="
										+ goodsName;
							}
						});
	});
</script>
</head>
<body>
	<div class="left-sidebar">
		<h2>게시판</h2>
		<div class="panel-group category-products" id="accordian">
		
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a href="${path}/front?key=qnaBoard&methodName=qnaSelectAll">
							문의게시판 </a>
					</h4>
				</div>

			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a href="${path}/front?key=noticeBoard&methodName=noticeSelectAll">
							공지게시판 </a>
					</h4>
				</div>

			</div>


		<%-- 	<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a href="${path}/front?key=faqBoard&methodName=faqSelectAll">
							자주 묻는 질문 </a>
					</h4>
				</div>
			</div>
			
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4 class="panel-title">
						<a href="${path}/front?key=revBoard&methodName=reviewSelectAll">
							후기 게시판 </a>
					</h4>
				</div>
			</div> --%>

		</div>
	

		
	</div>


	<script src="${path}/js/jquery.js"></script>
	<script src="${path}/js/bootstrap.min.js"></script>
	<script src="${path}/js/jquery.scrollUp.min.js"></script>
	<script src="${path}/js/price-range.js"></script>
	<script src="${path}/js/jquery.prettyPhoto.js"></script>
	<script src="${path}/js/main.js"></script>

</body>
</html>