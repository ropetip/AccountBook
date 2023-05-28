<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String oauth_email = (String)session.getAttribute("oauth_email");
	String oauth_nickname = (String)session.getAttribute("oauth_nickname");
	
	oauth_email = oauth_email == null ? "" : oauth_email; 
	oauth_nickname = oauth_nickname == null ? "" : oauth_nickname; 
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>Main</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="resources/img/favicon.png" rel="icon">
<link href="resources/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet"/>

<!-- Vendor CSS Files -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>

<link href="resources/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet"/>
<link href="resources/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"/>
<link href="resources/vendor/quill/quill.snow.css" rel="stylesheet"/>
<link href="resources/vendor/quill/quill.bubble.css" rel="stylesheet"/>
<link href="resources/vendor/remixicon/remixicon.css" rel="stylesheet"/>
<link href="resources/vendor/simple-datatables/style.css" rel="stylesheet"/>

<!-- dataTable -->
<link href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/autofill/2.5.3/css/autoFill.dataTables.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/buttons/2.3.6/css/buttons.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/colreorder/1.6.2/css/colReorder.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/datetime/1.4.0/css/dataTables.dateTime.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/fixedcolumns/4.2.2/css/fixedColumns.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/fixedheader/3.3.2/css/fixedHeader.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/keytable/2.8.2/css/keyTable.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/responsive/2.4.1/css/responsive.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/rowgroup/1.3.1/css/rowGroup.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/rowreorder/1.3.3/css/rowReorder.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/scroller/2.1.1/css/scroller.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/searchbuilder/1.4.2/css/searchBuilder.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/searchpanes/2.1.2/css/searchPanes.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/select/1.6.2/css/select.dataTables.min.css" rel="stylesheet"/>
<link href="https://cdn.datatables.net/staterestore/1.2.2/css/stateRestore.dataTables.min.css" rel="stylesheet"/>
<!-- Template Main CSS File -->
<link href="resources/css/style.css" rel="stylesheet"/>
<link href="resources/css/common.css" rel="stylesheet"/>


<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
 <!-- Vendor JS Files -->
<script src="resources/vendor/apexcharts/apexcharts.min.js"></script>
<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="resources/vendor/chart.js/chart.umd.js"></script>
<script src="resources/vendor/echarts/echarts.min.js"></script>
<script src="resources/vendor/quill/quill.min.js"></script>
<script src="resources/vendor/simple-datatables/simple-datatables.js"></script>
<script src="resources/vendor/tinymce/tinymce.min.js"></script>
<script src="resources/vendor/php-email-form/validate.js"></script>
<script src="resources/js/common.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.36/vfs_fonts.js"></script> -->
<script src="resources/js/dataTable/pdfmake/pdfmake.min.js"></script>
<script src="resources/js/dataTable/pdfmake/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/autofill/2.5.3/js/dataTables.autoFill.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.colVis.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.3.6/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/colreorder/1.6.2/js/dataTables.colReorder.min.js"></script>
<script src="https://cdn.datatables.net/datetime/1.4.0/js/dataTables.dateTime.min.js"></script>
<script src="https://cdn.datatables.net/fixedcolumns/4.2.2/js/dataTables.fixedColumns.min.js"></script>
<script src="https://cdn.datatables.net/fixedheader/3.3.2/js/dataTables.fixedHeader.min.js"></script>
<script src="https://cdn.datatables.net/keytable/2.8.2/js/dataTables.keyTable.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.4.1/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/rowgroup/1.3.1/js/dataTables.rowGroup.min.js"></script>
<script src="https://cdn.datatables.net/rowreorder/1.3.3/js/dataTables.rowReorder.min.js"></script>
<script src="https://cdn.datatables.net/scroller/2.1.1/js/dataTables.scroller.min.js"></script>
<script src="https://cdn.datatables.net/searchbuilder/1.4.2/js/dataTables.searchBuilder.min.js"></script>
<script src="https://cdn.datatables.net/searchpanes/2.1.2/js/dataTables.searchPanes.min.js"></script>
<script src="https://cdn.datatables.net/select/1.6.2/js/dataTables.select.min.js"></script>
<script src="https://cdn.datatables.net/staterestore/1.2.2/js/dataTables.stateRestore.min.js"></script>

<!-- custom js -->

<script src="resources/js/html2canvas.min.js"></script> <!-- 캡처이미지 -->

<sitemesh:write property='head' />

<script>

$(document).ready(function () {
	const nickname = "<%=oauth_nickname%>";
	
	if("<%=oauth_email%>" != "") {
		document.querySelector("#guest").classList.add("hide");
		document.querySelector("#userProfile").classList.remove("hide");
		
		var userName = document.querySelectorAll("[name='userName']");
		for (var i = 0; i < userName.length; i++) {
			userName[i].innerHTML = nickname;
		}
	} else {
		document.querySelector("#guest").classList.remove("hide");
		document.querySelector("#userProfile").classList.add("hide");
	}
});

function go(url) {
	window.location.href = url;
}

function join() {
	go("join.do");
}

function logout() {
	const url = "https://kauth.kakao.com/oauth/logout?client_id=${CLIENT_ID}&logout_redirect_uri=${SERVER_URL}/oauth/kakao/logout"; 
	location.href = url;
}
</script>
</head>
<body>

	<!-- 이 부분이 공동 레이아웃입니다. -->
	<!-- ======= Header ======= -->
	<header id="header" class="header fixed-top d-flex align-items-center">

		<div class="d-flex align-items-center justify-content-between">
			<a onclick="go('/')" class="logo d-flex align-items-center">
				<img src="resources/img/logo.png" alt=""> <span class="d-none d-lg-block">NiceAdmin</span>
			</a>
			<i class="bi bi-list toggle-sidebar-btn"></i>
		</div>
		<!-- End Logo -->

		<div class="search-bar">
			<form class="search-form d-flex align-items-center" method="POST" action="#">
				<input type="text" name="query" placeholder="Search" title="Enter search keyword">
				<button type="submit" title="Search">
					<i class="bi bi-search"></i>
				</button>
			</form>
		</div>
		<!-- End Search Bar -->

		<nav class="header-nav ms-auto">
			<ul class="d-flex align-items-center">

				<li class="nav-item d-block d-lg-none">
					<a class="nav-link nav-icon search-bar-toggle " href="#">
						<i class="bi bi-search"></i>
					</a>
				</li>
				<!-- End Search Icon-->

				<li class="nav-item dropdown">
					<a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
						<i class="bi bi-bell"></i> <span class="badge bg-primary badge-number">4</span>
					</a>
					<!-- End Notification Icon -->

					<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
						<li class="dropdown-header">
							You have 4 new notifications
							<a href="#">
								<span class="badge rounded-pill bg-primary p-2 ms-2">View all</span>
							</a>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>

						<li class="notification-item">
							<i class="bi bi-exclamation-circle text-warning"></i>
							<div>
								<h4>Lorem Ipsum</h4>
								<p>Quae dolorem earum veritatis oditseno</p>
								<p>30 min. ago</p>
							</div>
						</li>

						<li>
							<hr class="dropdown-divider">
						</li>

						<li class="notification-item">
							<i class="bi bi-x-circle text-danger"></i>
							<div>
								<h4>Atque rerum nesciunt</h4>
								<p>Quae dolorem earum veritatis oditseno</p>
								<p>1 hr. ago</p>
							</div>
						</li>

						<li>
							<hr class="dropdown-divider">
						</li>

						<li class="notification-item">
							<i class="bi bi-check-circle text-success"></i>
							<div>
								<h4>Sit rerum fuga</h4>
								<p>Quae dolorem earum veritatis oditseno</p>
								<p>2 hrs. ago</p>
							</div>
						</li>

						<li>
							<hr class="dropdown-divider">
						</li>

						<li class="notification-item">
							<i class="bi bi-info-circle text-primary"></i>
							<div>
								<h4>Dicta reprehenderit</h4>
								<p>Quae dolorem earum veritatis oditseno</p>
								<p>4 hrs. ago</p>
							</div>
						</li>

						<li>
							<hr class="dropdown-divider">
						</li>
						<li class="dropdown-footer">
							<a href="#">Show all notifications</a>
						</li>

					</ul>
					<!-- End Notification Dropdown Items -->
				</li>
				<!-- End Notification Nav -->

				<li class="nav-item dropdown">
					<a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
						<i class="bi bi-chat-left-text"></i> <span class="badge bg-success badge-number">3</span>
					</a>
					<!-- End Messages Icon -->

					<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow messages">
						<li class="dropdown-header">
							You have 3 new messages
							<a href="#">
								<span class="badge rounded-pill bg-primary p-2 ms-2">View all</span>
							</a>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>

						<li class="message-item">
							<a href="#">
								<img src="resources/img/messages-1.jpg" alt="" class="rounded-circle">
								<div>
									<h4>Maria Hudson</h4>
									<p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
									<p>4 hrs. ago</p>
								</div>
							</a>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>

						<li class="message-item">
							<a href="#">
								<img src="resources/img/messages-2.jpg" alt="" class="rounded-circle">
								<div>
									<h4>Anna Nelson</h4>
									<p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
									<p>6 hrs. ago</p>
								</div>
							</a>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>

						<li class="message-item">
							<a href="#">
								<img src="resources/img/messages-3.jpg" alt="" class="rounded-circle">
								<div>
									<h4>David Muldon</h4>
									<p>Velit asperiores et ducimus soluta repudiandae labore officia est ut...</p>
									<p>8 hrs. ago</p>
								</div>
							</a>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>

						<li class="dropdown-footer">
							<a href="#">Show all messages</a>
						</li>

					</ul>
					<!-- End Messages Dropdown Items -->
				</li>
				<!-- End Messages Nav -->

				<!-- TODO: 로그인 전 영역-->
				<div id="guest" class="btn-group" role="group" aria-label="Basic mixed styles example">
					<button type="button" class="btn btn-light">로그인</button>
					<button type="button" class="btn btn-light" onclick="join();">회원가입</button>
				</div>

				<!-- TODO: 로그인 후 영역, 잠시 숨김-->
				<li id="userProfile" class="nav-item dropdown pe-3 hide">
					<a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
						<img src="resources/img/profile-img.jpg" alt="Profile" class="rounded-circle">
						<span name="userName" class="d-none d-md-block dropdown-toggle ps-2"></span>
					</a>

					<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
						<li class="dropdown-header">
							<h6 name="userName"></h6>
							<span>Web Designer</span>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>

						<li>
							<a class="dropdown-item d-flex align-items-center" href="users-profile.html">
								<i class="bi bi-person"></i> <span>My Profile</span>
							</a>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>

						<li>
							<a class="dropdown-item d-flex align-items-center" href="users-profile.html">
								<i class="bi bi-gear"></i> <span>Account Settings</span>
							</a>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>

						<li>
							<a class="dropdown-item d-flex align-items-center" href="pages-faq.html">
								<i class="bi bi-question-circle"></i> <span>Need Help?</span>
							</a>
						</li>
						<li>
							<hr class="dropdown-divider">
						</li>

						<li>
							<a class="dropdown-item d-flex align-items-center" onclick="logout();">
								<i class="bi bi-box-arrow-right"></i>
								<span>로그아웃</span>
							</a>
						</li>

					</ul>
					<!-- End Profile Dropdown Items -->
				</li>
				<!-- End Profile Nav -->

			</ul>
		</nav>
		<!-- End Icons Navigation -->

	</header>
	<!-- End Header -->

	<!-- ======= Sidebar ======= -->
	<aside id="sidebar" class="sidebar">

		<ul class="sidebar-nav" id="sidebar-nav">
			<li class="nav-item">
				<a class="nav-link collapsed" data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
	          		<i class="bi bi-menu-button-wide"></i><span>Components</span><i class="bi bi-chevron-down ms-auto"></i>
		        </a>
				<ul id="components-nav" class="nav-content collapse cursor-pointer" data-bs-parent="#sidebar-nav">
					<li>
						<a onclick="go('/accbookList.do')"> <i class="bi bi-circle"></i><span>가계부 목록</span></a>
					</li>
				</ul>
		</ul>
		
	</aside>
	<!-- End Sidebar-->

	<main id="main" class="main">
		<div>
			<sitemesh:write property='body' />
		</div>
	</main>
	<!-- ======= Footer ======= -->
	<footer id="footer" class="footer">
		<div class="copyright">
			&copy; Copyright <strong><span>NiceAdmin</span></strong>. All Rights Reserved
		</div>
		<div class="credits">
			<!-- All the links in the footer should remain intact. -->
			<!-- You can delete the links only if you purchased the pro version. -->
			<!-- Licensing information: https://bootstrapmade.com/license/ -->
			<!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
			Designed by
			<a href="https://bootstrapmade.com/">BootstrapMade</a>
		</div>
	</footer>
	<!-- End Footer -->

	<a href="#" class="back-to-top d-flex align-items-center justify-content-center">
		<i class="bi bi-arrow-up-short"></i>
	</a>

<script src="resources/js/main.js"></script>	
</body>
</html>