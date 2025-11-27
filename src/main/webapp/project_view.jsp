<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.ProjectDTO" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <c:if test="${not empty param.lang}">
    <c:set var="lang" value="${param.lang}" scope="session" />
</c:if>
<c:if test="${empty sessionScope.lang}">
    <c:set var="lang" value="ko" scope="session" />
</c:if>
<fmt:setLocale value="${sessionScope.lang}" />
<fmt:setBundle basename="message" />
<%
    String projectID = request.getParameter("id");

    ProjectDAO dao = new ProjectDAO();
    ProjectDTO project = dao.getProjectById(projectID); 
    
    pageContext.setAttribute("project", project);
    
    pageContext.setAttribute("enter", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${not empty project ? project.projectTitle : '프로젝트 상세'}</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="header.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
    
                <c:if test="${empty project}">
                    <div class="alert alert-danger text-center" role="alert">
                        <fmt:message key="noProject"/> (ID: <%= projectID %>)<br>
                        <a href="index.jsp" class="btn btn-outline-danger mt-2"><fmt:message key="gotoMain"/></a>
                    </div>
                </c:if>
                
                <c:if test="${not empty project}">
                    <h2 class="mb-3">
                    	${project.projectTitle}
                        <c:if test="${project.status == '모집 중'}">
                            <span class="badge bg-success fs-6 ms-2"><fmt:message key="recruiting" /></span>
                        </c:if>
                        <c:if test="${project.status == '모집 완료'}">
                            <span class="badge bg-secondary fs-6 ms-2"><fmt:message key="recruitmentCompleted" /></span>
                        </c:if>
                    </h2>
                    <hr>
        
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><strong><fmt:message key="writer" />:</strong> ${project.leaderID}</li>
                                <li class="list-group-item"><strong><fmt:message key="projectType" />:</strong> ${project.projectType}</li>
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><strong><fmt:message key="estimatedProjectDuration" />:</strong> ${project.projectDuration}</li>
                                <li class="list-group-item"><strong><fmt:message key="requiredTechStack"/>:</strong> ${project.techStacks}</li>
                            </ul>
                        </div>
                    </div>
        
                    <div class="card shadow-sm mb-4">
                        <div class="card-header fs-5 fw-semibold"><fmt:message key="projectDescrption" /></div>
                        <div class="card-body">
                            <p style="white-space: pre-wrap;">${project.projectDescription}</p>
                        </div>
                    </div>
        
                    <div class="card shadow-sm mb-4">
                        <div class="card-header fs-5 fw-semibold"><fmt:message key="projectStatus"/></div>
                        <div class="card-body">
                            <p class="fs-5">
                                <strong><fmt:message key="totalNumber" />: ${project.currentMembers} / ${project.totalMembers}<fmt:message key="people" /></strong>
                                <span class="text-muted fs-6 ms-3">(<fmt:message key="recruitmentDeadline" />: ~ ${project.deadline})</span>
                            </p>
                            
                            <div class="mt-3">
                                <strong><fmt:message key="recruitmentField1" />:</strong>
                                <c:set var="requiredRoles" value="${fn:split(project.requiredRoles, enter)}" />
                                <div class="p-3 bg-light rounded mt-2">
                                    <ul class="mb-0 ps-3"> 
                                        <c:forEach var="role" items="${requiredRoles}">
                                            <c:if test="${not empty role}">
                                                <li>${role}</li>
                                            </c:if>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <c:choose>
                        <c:when test="${not empty sessionScope.userId and project.leaderID eq sessionScope.userId}">
                            <div class="d-flex gap-2">
                                <a class="btn btn-dark btn-lg flex-grow-1" href="project_edit.jsp?id=${project.projectID}" role="button"><fmt:message key="projectUpdate" /></a>
                                <button class="btn btn-danger btn-lg" onclick="deleteProject('${project.projectID}')"><fmt:message key="delete" /></button>
                            </div>
                        </c:when>
                        
                        <c:otherwise>
                            <div class="d-grid gap-2">
                                <c:choose>
                                    <c:when test="${empty sessionScope.userId}">
                                        <button class="btn btn-primary btn-lg" type="button" onclick="alert('로그인이 필요합니다.'); location.href='login.jsp';"><fmt:message key="apply" /></button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-primary btn-lg" type="button" data-bs-toggle="modal" data-bs-target="#applyModal"><fmt:message key="apply" /></button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:otherwise>
                    </c:choose> 
                    
                </c:if>
            </div>
        </div>
    </div>

    <div class="modal fade" id="applyModal" tabindex="-1" aria-labelledby="applyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="applyModalLabel">📝 <fmt:message key="applicationForm" /></h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <form action="applyAction.jsp" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="projectId" value="${project.projectID}">
                        
                        <div class="mb-3">
                            <label for="intro" class="form-label fw-bold"><fmt:message key="selfIntroduction"/></label>
                            <textarea class="form-control" id="intro" name="intro" rows="5" 
                                placeholder='<fmt:message key="selfIntroductionPlaceHolder"/>' required></textarea>
                        </div>
                        <div class="alert alert-light border" style="font-size: 0.9rem;">
                            💡 <fmt:message key="messageToLeader" />
                        </div>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><fmt:message key="cancel" /></button>
                        <button type="submit" class="btn btn-primary"><fmt:message key="applicationCompleted" /></button>
                    </div>
                </form>
                
            </div>
        </div>
    </div>
    <footer class="mt-auto">
        <jsp:include page="footer.jsp" />
    </footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // 삭제 함수만 남겨둠 (지원 함수는 모달로 대체되었으므로 제거)
    function deleteProject(id) {
        if(confirm("정말 삭제하시겠습니까? 복구할 수 없습니다.")) {
            location.href = "projectDeleteAction.jsp?id=" + id;
        }
    }
</script>

</body>
</html>