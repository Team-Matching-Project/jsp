<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.ProjectDTO" %>
<%@ page import="dao.ApplicationDAO" %>
<%@ page import="dto.ApplicationDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    String projectId = request.getParameter("id");

    if (userId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }
    
    ProjectDAO projectDAO = new ProjectDAO();
    ProjectDTO project = projectDAO.getProjectById(projectId);

    if (project == null || !project.getLeaderID().equals(userId)) {
        out.println("<script>alert('접근 권한이 없습니다.'); location.href='index.jsp';</script>");
        return;
    }

    ApplicationDAO appDAO = new ApplicationDAO();
    List<ApplicationDTO> allApplicants = appDAO.getApplicants(projectId);

    List<ApplicationDTO> pendingList = new ArrayList<>();
    List<ApplicationDTO> approvedList = new ArrayList<>();

    for (ApplicationDTO app : allApplicants) {
        if ("대기중".equals(app.getStatus())) {
            pendingList.add(app);
        } else if ("승인 완료".equals(app.getStatus())) {
            approvedList.add(app);
        }
    }

    pageContext.setAttribute("project", project);
    pageContext.setAttribute("pendingList", pendingList);
    pageContext.setAttribute("approvedList", approvedList);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지원자 관리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<style> body { background-color: #f8f9fa; } </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <jsp:include page="header.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">

                <h2 class="mb-3"><fmt:message key="applicantManagement" /></h2>
                <p class="lead text-muted">
                    ${project.projectTitle}
                </p>

                <ul class="nav nav-tabs mt-4" id="myTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending-tab-pane" type="button" role="tab">
                            <fmt:message key="applicantsAwaitingApproval"/>
                            <span class="badge bg-danger ms-1">${pendingList.size()}</span>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="approved-tab" data-bs-toggle="tab" data-bs-target="#approved-tab-pane" type="button" role="tab">
                            <fmt:message key="confirmedTeamMember"/>
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
                                        <fmt:message key="noApplicantsAwaitingApproval"/>
                                    </li>
                                </c:if>

                                <c:forEach var="app" items="${pendingList}">
                                    <li class="list-group-item p-3">
                                        <div class="row g-3 align-items-center">
                                            <div class="col-md-8">
                                                <h5 class="mb-1">
                                                    ${app.userName} 
                                                    <span class="text-muted fs-6">(${app.department} / ${app.grade}<fmt:message key="grade" />)</span>
                                                </h5>
                                                <p class="mb-1 text-muted" style="font-size: 0.9rem;">
                                                    <strong><fmt:message key="requiredTechStack" />:</strong> ${app.skills}
                                                </p>
                                                <p class="mb-0 p-2 bg-light rounded" style="font-size: 0.9rem; white-space: pre-wrap;">${app.intro}</p>
                                            </div>
                                            
                                            <div class="col-md-4 text-md-end">
                                                <form action="applicantAction.jsp" method="post" class="d-inline">
                                                    <input type="hidden" name="appID" value="${app.appId}">
                                                    <input type="hidden" name="projectID" value="${project.projectID}">
                                                    <input type="hidden" name="action" value="approve"> <button type="submit" class="btn btn-success btn-sm mb-1" onclick="return confirm('승인하시겠습니까?');"><fmt:message key="approve"/></button>
                                                </form>
                                                
                                                <form action="applicantAction.jsp" method="post" class="d-inline">
                                                    <input type="hidden" name="appID" value="${app.appId}">
                                                    <input type="hidden" name="projectID" value="${project.projectID}">
                                                    <input type="hidden" name="action" value="reject"> <button type="submit" class="btn btn-danger btn-sm mb-1" onclick="return confirm('거절하시겠습니까?');"><fmt:message key="refuse"/></button>
                                                </form>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                                
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="approved-tab-pane" role="tabpanel">
                        <div class="card shadow-sm border-top-0">
                            <div class="list-group list-group-flush">
                                
                                <c:if test="${empty approvedList}">
                                    <li class="list-group-item p-4 text-center text-muted">
                                       	<fmt:message key="noCompletedMember" />
                                    </li>
                                </c:if>

                                <c:forEach var="member" items="${approvedList}">
                                    <li class="list-group-item p-3 d-flex justify-content-between align-items-center">
                                        <div>
                                            <h5 class="mb-0">
                                                ${member.userName}
                                                <span class="text-muted fs-6">(${member.department} / ${member.grade}학년)</span>
                                            </h5>
                                            <p class="mb-0 text-muted" style="font-size: 0.9rem;">
                                                <strong><fmt:message key="requiredTechStack" />:</strong> ${member.skills}
                                            </p>
                                        </div>
                                        <span class="text-success fw-semibold"><fmt:message key="approved"/></span>
                                    </li>
                                </c:forEach>
                                
                            </div>
                        </div>
                    </div>
                    
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