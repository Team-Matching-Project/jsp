<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.ProjectDTO" %>
<%@ page import="dto.ApplicationDTO" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    String userId = (String) session.getAttribute("userId");
    
    if (userId == null) {
%>
        <script>
            alert('<fmt:message key="mustLogin" />'); 
            location.href = 'login.jsp';
        </script>
<%
        return;
    }

    UserDAO userDAO = new UserDAO();
    UserDTO user = userDAO.getUser(userId);
    
    if (user == null) {
%>
        <script>
            alert('<fmt:message key="failToRetrieve" />'); 
            history.back();
        </script>
<%
        return;
    }

    ProjectDAO projectDAO = new ProjectDAO();
    
    List<ProjectDTO> registeredProjects = projectDAO.getProjectsByLeader(userId); 
    List<ApplicationDTO> appliedProjects = projectDAO.getAppliedProjects(userId);

    pageContext.setAttribute("registeredProjects", registeredProjects);
    pageContext.setAttribute("appliedProjects", appliedProjects);
    pageContext.setAttribute("user", user);
    pageContext.setAttribute("enter", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    .list-group-item-action:hover { color: blue; background-color: #f8f9fa; }
    body { background-color: #f8f9fa; }
    .badge { margin-right: 4px; margin-bottom: 4px; }
</style>
</head>

<body class="d-flex flex-column min-vh-100">

    <jsp:include page="header.jsp" />

    <div class="container my-5">
        <h2 class="text-center mb-4"><fmt:message key="mypage"/></h2>

        <div class="row g-4">
            
            <div class="col-lg-4">
                <div class="card shadow-sm h-100">
                    <div class="card-header fs-5 fw-semibold"><fmt:message key="personalInformation"/></div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <strong><fmt:message key="name" /></strong><span><%=user.getUserName() %></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <strong><fmt:message key="grade" /></strong><span><%=user.getGrade() %>학년</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <strong><fmt:message key="department" /></strong><span><%=user.getDepartment() %></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <strong><fmt:message key="birthDate" /></strong><span><%=user.getBirthDate() %></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <strong><fmt:message key="gender" /></strong><span><%=user.getUserGender() %></span>
                        </li>
                        
                        <li class="list-group-item">
                            <strong><fmt:message key="possessedTechnology" /></strong>
                            <div class="mt-2">
                                <c:if test="${not empty user.skills}">
                                    <c:set var="skillArray" value="${fn:split(user.skills, ',')}" />
                                    <c:forEach var="skill" items="${skillArray}">
                                        <span class="badge bg-primary">${skill}</span>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </li>
                        
                        <li class="list-group-item">
                            <strong><fmt:message key="myStrength" /></strong>
                            <c:if test="${not empty user.strengths}">
                                <c:set var="strengthList" value="${fn:split(user.strengths, enter)}" />
                                <c:forEach var="strength" items="${strengthList}">
                                    <p class="text-muted mb-0 mt-2" style="font-size: 0.9rem;">- ${strength}</p>
                                </c:forEach>
                            </c:if>
                        </li>
                    </ul>
                    <div class="card-footer text-center"> 
                        <a href="edit_profile.jsp" class="btn btn-dark"><fmt:message key="editPersonalInformation" /></a>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-8">
                
                <div class="card shadow-sm mb-4"> 
                    <div class="card-header fs-5 fw-semibold d-flex justify-content-between align-items-center">
                        <fmt:message  key="registeredProjectManagement"/>
                        <a href="project_create.jsp" class="btn btn-primary btn-sm"><fmt:message key="registerNewProject" /></a>
                    </div>
                    <ul class="list-group list-group-flush">
                        <c:if test="${empty registeredProjects}">
                            <li class="list-group-item text-center py-4 text-muted"><fmt:message key="noProject" /></li>
                        </c:if>

                        <c:forEach var="myProject" items="${registeredProjects}">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <a href="project_view.jsp?id=${myProject.projectID}" class="text-decoration-none fw-semibold">
                                        ${myProject.projectTitle}
                                    </a>
                                    <small class="text-muted ms-2">(<fmt:message key="current" /> ${myProject.currentMembers} / ${myProject.totalMembers} <fmt:message key="people"/>)</small>
                                </div>
                                
                                <c:choose>
                                    <c:when test="${myProject.status == '모집 완료'}">
                                        <span class="badge bg-secondary">모집 완료</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="manage_applicants.jsp?id=${myProject.projectID}" class="btn btn-outline-dark btn-sm">
                                            <fmt:message key="applicantManagement" />
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                
                <div class="card shadow-sm">
                    <div class="card-header fs-5 fw-semibold"><fmt:message key="statusOfSupportedProjects" /></div>
                    <ul class="list-group list-group-flush">
                        
                        <c:if test="${empty appliedProjects}">
                            <li class="list-group-item text-center py-4 text-muted"><fmt:message key="noApply" /></li>
                        </c:if>

                        <c:forEach var="app" items="${appliedProjects}">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <a href="project_view.jsp?id=${app.projectId}" class="text-decoration-none">
                                    ${app.projectTitle}
                                </a>
                                
                                <c:choose>
                                    <c:when test="${app.status == '승인 완료'}">
                                        <span class="badge bg-success"><fmt:message key="approved" /></span>
                                    </c:when>
                                    <c:when test="${app.status == '거절'}">
                                        <span class="badge bg-danger"><fmt:message key="refuse" /></span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark"><fmt:message key="waitingForApproval" /></span>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div> 
    </div> 

    <footer class="mt-auto">
        <jsp:include page="footer.jsp" />
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>