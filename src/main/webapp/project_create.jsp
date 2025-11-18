<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>새 프로젝트 등록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<style>
	body {
		background-color: #f8f9fa;
	}
</style>
</head>

<body class="d-flex flex-column min-vh-100">

	<jsp:include page="header.jsp" />

	<div class="container my-5">
		<div class="row justify-content-center">
			
			<div class="col-lg-8 col-md-10">
				
				<div class="card shadow-sm">
					<div class="card-body p-4 p-md-5">
						
						<h3 class="card-title text-center mb-4">새 프로젝트 등록</h3>
						
						<form action="projectCreateAction.jsp" method="post">
							
							<div class="mb-3">
								<label for="projectTitle" class="form-label">프로젝트 제목</label>
								<input type="text" class="form-control" id="projectTitle" name="projectTitle" required placeholder="예: JSP 팀 매칭 시스템">
							</div>
							
							<div class="row g-3 mb-3">
								<div class="col-md-6">
									<label for="projectType" class="form-label">프로젝트 종류</label>
									<select class="form-select" name="projectType" id="projectType">
										<option value="학과 수업" selected>학과 수업</option>
										<option value="부트캠프">부트캠프</option>
										<option value="공모전">공모전</option>
										<option value="개인 프로젝트">개인 프로젝트</option>
										<option value="기타">기타</option>
									</select>
								</div>
								<div class="col-md-6">
									<label for="deadlineDate" class="form-label">모집 마감일</label>
									<input type="date" class="form-control" name="deadlineDate" id="deadlineDate" required>
								</div>
							</div>

							<div class="row g-3 mb-3">
								<div class="col-md-6">
									<label for="projectDuration" class="form-label">예상 프로젝트 기간</label>
									<input type="text" class="form-control" name="projectDuration" id="projectDuration" placeholder="예: 4주 (12/8까지)">
								</div>
								<div class="col-md-6">
									<label for="totalMembers" class="form-label">총 모집 인원 (본인 포함)</label>
									<input type="number" class="form-control" name="totalMembers" id="totalMembers" min="2" max="10" value="2">
								</div>
							</div>
							
							<div class="mb-3">
								<label for="techStacks" class="form-label">필요 기술 스택 (쉼표로 구분)</label>
								<input type="text" class="form-control" name="techStacks" id="techStacks" placeholder="예: Java, JSP, PPT, Excel, Figma">
							</div>
							
							<div class="mb-3">
								<label for="requiredRoles" class="form-label">모집 분야 (줄바꿈으로 구분)</label>
								<textarea class="form-control" name="requiredRoles" id="requiredRoles" rows="4" placeholder="프로젝트 상세 페이지에 표시될 내용입니다.&#10;예:&#10;백엔드 (Java/JSP) - 2명&#10;프론트엔드 (HTML/CSS) - 1명&#10;기획 (PPT) - 1명"></textarea>
							</div>
							
							<div class="mb-3">
								<label for="projectDescription" class="form-label">프로젝트 상세 설명</label>
								<textarea class="form-control" name="projectDescription" id="projectDescription" rows="8" placeholder="프로젝트의 목표, 주요 기능 등을 자세히 적어주세요."></textarea>
							</div>

							<div class="row mt-4">
								<div class="col d-grid">
									<a href="index.jsp" class="btn btn-secondary">취소</a>
								</div>
								<div class="col d-grid">
									<button type="submit" class="btn btn-primary">프로젝트 등록</button>
								</div>
							</div>
							
						</form> </div> </div> </div> </div> </div> <footer class="mt-auto">
		<jsp:include page="footer.jsp" />
	</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>