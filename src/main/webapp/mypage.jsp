<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

<style>
	/* 리스트 아이템 호버 효과 */
	.list-group-item-action:hover {
		color: blue; 
		background-color: #f8f9fa;
	}
	body {
		background-color: #f8f9fa; /* 배경색 살짝 */
	}
	/* (선택) 배지(태그) 사이의 간격을 살짝 줍니다. */
	.badge {
		margin-right: 4px;
		margin-bottom: 4px;
	}
</style>
</head>

<body class="d-flex flex-column min-vh-100">

	<jsp:include page="header.jsp" />

	<div class="container my-5">
	
		<h2 class="text-center mb-4">마이페이지</h2>

		<div class="row g-4">
			
			<div class="col-lg-4">
				<div class="card shadow-sm h-100">
					<div class="card-header fs-5 fw-semibold">
						개인정보
					</div>
					<ul class="list-group list-group-flush">
						<li class="list-group-item d-flex justify-content-between align-items-center">
							<strong>이름</strong>
							<span>(데이터)</span>
						</li>
						<li class="list-group-item d-flex justify-content-between align-items-center">
							<strong>학년</strong>
							<span>(데이터)</span>
						</li>
						<li class="list-group-item d-flex justify-content-between align-items-center">
							<strong>학과</strong>
							<span>(데이터)</span>
						</li>
						<li class="list-group-item d-flex justify-content-between align-items-center">
							<strong>나이</strong>
							<span>(데이터)</span>
						</li>
						<li class="list-group-item d-flex justify-content-between align-items-center">
							<strong>성별</strong>
							<span>(데이터)</span>
						</li>
						
						<li class="list-group-item">
							<strong>보유 기술</strong>
							<div class="mt-2">
								<span class="badge bg-primary">Java</span>
								<span class="badge bg-info text-dark">JSP</span>
								<span class="badge bg-warning text-dark">MySQL</span>
								<span class="badge bg-success">PPT</span>
								<span class="badge bg-secondary">Git</span>
							</div>
						</li>
						
						<li class="list-group-item">
							<strong>나의 강점</strong>
							<p class="text-muted mb-0 mt-2" style="font-size: 0.9rem;">
								- 끈기 있게 문제를 해결합니다.<br>
								- 팀원들과의 원활한 커뮤니케이션을 중시합니다.<br>
								- 협동심이 강합니다.
							</p>
						</li>
						
					</ul>
					<div class="card-footer text-center"> 
						<a href="edit_profile.jsp" class="btn btn-dark">개인정보수정</a>
					</div>
				</div>
			</div>
			
			<div class="col-lg-8">
				
				<div class="card shadow-sm mb-4"> 
					<div class="card-header fs-5 fw-semibold d-flex justify-content-between align-items-center">
						등록한 프로젝트 관리
						<a href="project_create.jsp" class="btn btn-primary btn-sm">새 프로젝트 등록</a>
					</div>
					<ul class="list-group list-group-flush">
						
						<li class="list-group-item d-flex justify-content-between align-items-center">
							<div>
								<a href="project_view.jsp?id=1" class="text-decoration-none fw-semibold">프로젝트-1 (내 프로젝트)</a>
								<small class="text-muted ms-2">(현재 3 / 5 명)</small>
							</div>
							<a href="manage_applicants.jsp?id=1" class="btn btn-outline-dark btn-sm">
								지원자 관리
								<span class="badge bg-danger rounded-pill ms-1">2</span>
							</a>
						</li>
						
						<li class="list-group-item d-flex justify-content-between align-items-center">
							<div>
								<a href="project_view.jsp?id=2" class="text-decoration-none fw-semibold">프로젝트-2 (내 프로젝트)</a>
								<small class="text-muted ms-2">(현재 1 / 3 명)</small>
							</div>
							<a href="manage_applicants.jsp?id=2" class="btn btn-outline-secondary btn-sm">
								지원자 관리
								<span class="badge bg-secondary rounded-pill ms-1">0</span>
							</a>
						</li>
						
						<li class="list-group-item d-flex justify-content-between align-items-center">
							<div>
								<a href="project_view.jsp?id=3" class="text-decoration-none fw-semibold">프로젝트-3 (내 프로젝트)</a>
								<small class="text-muted ms-2">(모집 완료 5 / 5 명)</small>
							</div>
							<span class="badge bg-success">모집 완료</span>
						</li>

					</ul>
				</div>
				
				<div class="card shadow-sm">
					<div class="card-header fs-5 fw-semibold">
						지원한 프로젝트 현황
					</div>
					<ul class="list-group list-group-flush">
						<li class="list-group-item d-flex justify-content-between align-items-center">
							<a href="project_view.jsp?id=4" class="text-decoration-none">프로젝트-4 (지원함)</a>
							<span class="badge bg-warning text-dark">승인 대기</span>
						</li>
						<li class="list-group-item d-flex justify-content-between align-items-center">
							<a href="project_view.jsp?id=5" class="text-decoration-none">프로젝트-5 (지원함)</a>
							<span class="badge bg-success">승인 완료</span>
						</li>
						<li class="list-group-item d-flex justify-content-between align-items-center">
							<a href="project_view.jsp?id=6" class="text-decoration-none">프로젝트-6 (지원함)</a>
							<span class="badge bg-danger">거절</span>
						</li>
					</ul>
				</div>
			</div>
			
		</div> 
	</div> 

	<footer class="mt-auto">
		<jsp:include page="footer.jsp" />
	</footer>
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>