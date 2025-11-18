<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 목록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body>
<div class="row row-cols-1 row-cols-md-2 g-4">
	
	<div class="col">
		<div class="card shadow-sm h-100">
			<div class="card-body">
				<h5 class="card-title">프로젝트-1 (제목)</h5>
				
				<div class="mb-3">
					<span class="badge bg-primary">Java</span>
					<span class="badge bg-info text-dark">JSP</span>
					<span class="badge bg-warning text-dark">MySQL</span>
				</div>
				
				<ul class="list-group list-group-flush">
					<li class="list-group-item d-flex justify-content-between align-items-center px-0">
						모집 인원
						<span class="badge bg-primary rounded-pill">2 / 5명</span>
					</li>
					<li class="list-group-item d-flex justify-content-between align-items-center px-0">
						팀장
						<span>김부연 (컴공)</span>
					</li>
				</ul>
			</div>
			
			<div class="card-footer bg-white border-top-0 d-flex justify-content-between align-items-center">
				<a href="project_view.jsp?id=1" class="btn btn-dark btn-sm">상세 보기</a>
				<small class="text-muted">마감 D-3</small>
			</div>
		</div>
	</div>
	<div class="col">
		<div class="card shadow-sm h-100">
			<div class="card-body">
				<h5 class="card-title">프로젝트-2 (제목)</h5>
				<div class="mb-3">
					<span class="badge bg-danger">PPT</span>
					<span class="badge bg-success">Excel</span>
					<span class="badge bg-secondary">기획</span>
				</div>
				<ul class="list-group list-group-flush">
					<li class="list-group-item d-flex justify-content-between align-items-center px-0">
						모집 인원
						<span class="badge bg-primary rounded-pill">1 / 3명</span>
					</li>
					<li class="list-group-item d-flex justify-content-between align-items-center px-0">
						팀장
						<span>이순신 (경영)</span>
					</li>
				</ul>
			</div>
			<div class="card-footer bg-white border-top-0 d-flex justify-content-between align-items-center">
				<a href="project_view.jsp?id=2" class="btn btn-dark btn-sm">상세 보기</a>
				<small class="text-muted">~ 11/20 까지</small>
			</div>
		</div>
	</div>
	</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>