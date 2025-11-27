<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <c:if test="${not empty param.lang}">
    <c:set var="lang" value="${param.lang}" scope="session" />
</c:if>
<c:if test="${empty sessionScope.lang}">
    <c:set var="lang" value="ko" scope="session" />
</c:if>
<fmt:setLocale value="${sessionScope.lang}" />
<fmt:setBundle basename="message" />
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
						
						<h3 class="card-title text-center mb-4"><fmt:message key="registerNewProject"/></h3>
						
						<form action="projectCreateAction.jsp" method="post">
							
							<div class="mb-3">
								<label for="projectTitle" class="form-label"><fmt:message key="projectTitle" /></label>
								<input type="text" class="form-control" id="projectTitle" name="projectTitle" required placeholder='<fmt:message key="titlePlaceHolder"/>'>
							</div>
							
							<div class="row g-3 mb-3">
								<div class="col-md-6">
									<label for="projectType" class="form-label"><fmt:message key="projectType" /></label>
									<select class="form-select" name="projectType" id="projectType">
										<option value="학과 수업" selected><fmt:message key="class" /></option>
										<option value="부트캠프"><fmt:message key="bootcamp" /></option>
										<option value="공모전"><fmt:message key="contest" /></option>
										<option value="개인 프로젝트"><fmt:message key="personalProject" /></option>
										<option value="기타"><fmt:message key="etc" /></option>
									</select>
								</div>
								<div class="col-md-6">
									<label for="deadlineDate" class="form-label"><fmt:message key="recruitmentDeadline" /></label>
									<input type="date" class="form-control" name="deadlineDate" id="deadlineDate" required>
								</div>
							</div>

							<div class="row g-3 mb-3">
								<div class="col-md-6">
									<label for="projectDuration" class="form-label"><fmt:message key="estimatedProjectDuration" /></label>
									<input type="text" class="form-control" name="projectDuration" id="projectDuration" placeholder='<fmt:message key="durationPlaceHolder" />'>
								</div>
								<div class="col-md-6">
									<label for="totalMembers" class="form-label"><fmt:message key="totalNumberOfRecruits" /></label>
									<input type="number" class="form-control" name="totalMembers" id="totalMembers" min="2" max="10" value="2">
								</div>
							</div>
							
							<div class="mb-3">
								<label for="department" class="form-label"><fmt:message key="department" /></label>
								<input type="text" class="form-control" name="department" id="department" placeholder='<fmt:message key="departmentPlaceHolder"/>'>
							</div>
							
							<div class="mb-3">
								<label for="techStacks" class="form-label"><fmt:message key="requiredTechStack" /></label>
								<input type="text" class="form-control" name="techStacks" id="techStacks" placeholder="예: Java, JSP, PPT, Excel, Figma">
							</div>
							
							<div class="mb-3">
								<label for="requiredRoles" class="form-label"><fmt:message key="recruitmentField" /></label>
								<textarea class="form-control" name="requiredRoles" id="requiredRoles" rows="4" placeholder='<fmt:message key="recruitmentFieldPlaceHolder" />'></textarea>
							</div>
							
							<div class="mb-3">
								<label for="projectDescription" class="form-label"><fmt:message key="projectDescrption" /></label>
								<textarea class="form-control" name="projectDescription" id="projectDescription" rows="8" 
    placeholder='<fmt:message key="projectDescrptionPlaceHolder"/>'></textarea>
							</div>

							<div class="row mt-4">
								<div class="col d-grid">
									<a href="index.jsp" class="btn btn-secondary"><fmt:message key="cancel" /></a>
								</div>
								<div class="col d-grid">
									<button type="submit" class="btn btn-primary"><fmt:message key="registerProject" /></button>
								</div>
							</div>
							
						</form> </div> </div> </div> </div> </div> <footer class="mt-auto">
		<jsp:include page="footer.jsp" />
	</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>