<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 세부 사항</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
</head>
<body>
	<div class="container my-5">
    <div class="row justify-content-center">
        <div class="col-lg-10">

            <h2 class="mb-3">
                JSP 기반 팀 프로젝트 매칭 시스템
                <span class="badge bg-success fs-6 ms-2">모집 중</span>
            </h2>
            <hr>

            <div class="row mb-4">
                <div class="col-md-6">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><strong>작성자:</strong> 김부연 (컴퓨터공학과)</li>
                        <li class="list-group-item"><strong>프로젝트 종류:</strong> 학과 수업</li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><strong>예상 기간:</strong> 4주 (11/10 ~ 12/08)</li>
                        <li class="list-group-item"><strong>사용 기술:</strong> Java, JSP, MySQL</li>
                    </ul>
                </div>
            </div>

            <div class="card shadow-sm mb-4">
                <div class="card-header fs-5 fw-semibold">프로젝트 상세 설명</div>
                <div class="card-body">
                    <p>
                        (프로젝트에 대한 자세한 설명을 이곳에 적습니다...)
                        (개발 목표, 주요 기능 등을 서술합니다...)
                    </p>
                </div>
            </div>

            <div class="card shadow-sm mb-4">
                <div class="card-header fs-5 fw-semibold">모집 현황</div>
                <div class="card-body">
                    <p class="fs-5">
                        <strong>전체 인원: 2명 / 5명</strong>
                        <span class="text-muted fs-6 ms-3">(모집 마감일: ~ 11/17)</span>
                    </p>
                    
                    <ul class="list-group">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            백엔드 (Java/JSP)
                            <span class="badge bg-primary rounded-pill fs-6">1 / 2명</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            프론트엔드 (HTML/CSS)
                            <span class="badge bg-primary rounded-pill fs-6">1 / 2명</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            디자이너 (Figma)
                            <span class="badge bg-secondary rounded-pill fs-6">0 / 1명</span>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="d-grid gap-2">
                <button class="btn btn-dark btn-lg" type="button">이 프로젝트에 지원하기</button>
            </div>

        </div>
    </div>
</div>
	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>