<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원자 관리</title>
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
			<div class="col-lg-10">

				<h2 class="mb-3">지원자 관리</h2>
				<p class="lead text-muted">
					${project.title} (예: JSP 팀 매칭 시스템)
				</p>

				<ul class="nav nav-tabs mt-4" id="myTab" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link active" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending-tab-pane" type="button" role="tab">
							승인 대기 지원자
							<span class="badge bg-danger ms-1">${pendingList.size()}</span>
						</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link" id="approved-tab" data-bs-toggle="tab" data-bs-target="#approved-tab-pane" type="button" role="tab">
							확정된 팀원
							<span class="badge bg-success ms-1">${approvedList.size()}</span>
						</button>
					</li>
				</ul>

				<div class="tab-content" id="myTabContent">
					
					<div class="tab-pane fade show active" id="pending-tab-pane" role="tabpanel">
						<div class="card shadow-sm border-top-0">
							<div class="list-group list-group-flush">

								<c:if test="${empty pendingList}">
									<li class="list-group-item p-4 text-center text-muted">
										승인 대기 중인 지원자가 없습니다.
									</li>
								</c:if>

								<li class="list-group-item p-3">
									<div class="row g-3 align-items-center">
										<div class="col-md-8">
											<h5 class="mb-1">김지원 (컴퓨터공학과/3학년)</h5>
											<p class="mb-1 text-muted" style="font-size: 0.9rem;">
												<strong>보유 기술:</strong> Java, JSP, MySQL
											</p>
											<p class="mb-0 p-2 bg-light rounded" style="font-size: 0.9rem;">
												"제가 백엔드를 맡아 열심히 하겠습니다. 끈기가 있습니다."
											</p>
										</div>
										<div class="col-md-4 text-md-end">
											<form action="applicantAction.jsp" method="post" class="d-inline">
												<input type="hidden" name="appID" value="1"> <input type="hidden" name="projectID" value="1"> <input type="hidden" name="action" value="approve">
												<button type="submit" class="btn btn-success btn-sm mb-1">승인</button>
											</form>
											<form action="applicantAction.jsp" method="post" class="d-inline">
												<input type="hidden" name="appID" value="1">
												<input type="hidden" name="projectID" value="1">
												<input type="hidden" name="action" value="reject">
												<button type="submit" class="btn btn-danger btn-sm mb-1">거절</button>
											</form>
										</div>
									</div>
								</li>
								
								<li class="list-group-item p-3">
									<div class="row g-3 align-items-center">
										<div class="col-md-8">
											<h5 class="mb-1">박기획 (경영학과/2학년)</h5>
											<p class="mb-1 text-muted" style="font-size: 0.9rem;">
												<strong>보유 기술:</strong> PPT, Excel, 기획
											</p>
											<p class="mb-0 p-2 bg-light rounded" style="font-size: 0.9rem;">
												"기획과 발표 자료 제작을 맡고 싶습니다."
											</p>
										</div>
										<div class="col-md-4 text-md-end">
											<form action="applicantAction.jsp" method="post" class="d-inline">
												<input type="hidden" name="appID" value="2">
												<input type="hidden" name="projectID" value="1">
												<input type="hidden" name="action" value="approve">
												<button type="submit" class="btn btn-success btn-sm mb-1">승인</button>
											</form>
											<form action="applicantAction.jsp" method="post" class="d-inline">
												<input type="hidden" name="appID" value="2">
												<input type="hidden" name="projectID" value="1">
												<input type="hidden" name="action" value="reject">
												<button type="submit" class="btn btn-danger btn-sm mb-1">거절</button>
											</form>
										</div>
									</div>
								</li>
								
							</div>
						</div>
					</div>

					<div class="tab-pane fade" id="approved-tab-pane" role="tabpanel">
						<div class="card shadow-sm border-top-0">
							<div class="list-group list-group-flush">
								
								<c:if test="${empty approvedList}">
									<li class="list-group-item p-4 text-center text-muted">
										아직 확정된 팀원이 없습니다. (팀장 본인 제외)
									</li>
								</c:if>

								<li class="list-group-item p-3 d-flex justify-content-between align-items-center">
									<div>
										<h5 class="mb-0">이승인 (전자공학과/4학년)</h5>
										<p class="mb-0 text-muted" style="font-size: 0.9rem;">
											<strong>보유 기술:</strong> C++, Python
										</p>
									</div>
									<span class="text-success fw-semibold">승인 완료</span>
								</li>
								
							</div>
						</div>
					</div>
					
				</div> </div> </div> </div> <footer class="mt-auto">
		<jsp:include page="footer.jsp" />
	</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>