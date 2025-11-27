<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    String projectId = request.getParameter("id");
    
    ProjectDAO projectDAO = new ProjectDAO();
    ProjectDTO project = projectDAO.getProjectById(projectId);
    
    if (project == null) {
        out.println("<script>alert('존재하지 않는 프로젝트입니다.'); history.back();</script>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { background-color: #f8f9fa; }
</style>
</head>

<body class="d-flex flex-column min-vh-100">

    <jsp:include page="header.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            
            <div class="col-lg-8 col-md-10">
                
                <div class="card shadow-sm">
                    <div class="card-body p-4 p-md-5">
                        
                        <h3 class="card-title text-center mb-4"><fmt:message  key="projectUpdate"/></h3>
                        
                        <form action="projectUpdateAction.jsp" method="post">
                        
                            <input type="hidden" name="projectID" value="<%=project.getProjectID()%>">
                            
                            <div class="mb-3">
                                <label for="projectTitle" class="form-label"><fmt:message key="projectTitle" /></label>
                                <input type="text" class="form-control" id="projectTitle" name="projectTitle" 
                                value="<%=project.getProjectTitle() %>" required>
                            </div>
                            
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label for="projectType" class="form-label"><fmt:message key="projectType" /></label>
									<select class="form-select" name="projectType" id="projectType">
									    <option value="학과 수업" <%= "학과 수업".equals(project.getProjectType()) ? "selected" : "" %>><fmt:message key="class" /></option>
									    <option value="부트캠프" <%= "부트캠프".equals(project.getProjectType()) ? "selected" : "" %>><fmt:message key="bootcamp" /></option>
									    <option value="공모전" <%= "공모전".equals(project.getProjectType()) ? "selected" : "" %>><fmt:message key="contest" /></option>
									    <option value="개인 프로젝트" <%= "개인 프로젝트".equals(project.getProjectType()) ? "selected" : "" %>><fmt:message key="personalProject" /></option>
									    <option value="기타" <%= "기타".equals(project.getProjectType()) ? "selected" : "" %>><fmt:message key="etc" /></option>
									</select>
                                </div>
                                <div class="col-md-6">
                                    <label for="deadlineDate" class="form-label"><fmt:message key="recruitmentDeadline" /></label>
                                    <input type="date" class="form-control" name="deadlineDate" 
                                    id="deadlineDate" required
                                    value="<%=project.getDeadline() %>">
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label for="projectDuration" class="form-label"><fmt:message key="estimatedProjectDuration" /></label>
                                    <input type="text" class="form-control" name="projectDuration" id="projectDuration" 
                                    value="<%=project.getProjectDuration() %>">
                                </div>
                                <div class="col-md-6">
                                    <label for="totalMembers" class="form-label"><fmt:message key="totalNumberOfRecruits"/></label>
                                    <input type="number" class="form-control" name="totalMembers" id="totalMembers" 
                                    min="2" max="10" value="<%=project.getTotalMembers() %>">
                                </div>
                            </div>
                            
                            <div class="mb-3">
								<label for="department" class="form-label"><fmt:message key ="department" /></label>
								<input type="text" class="form-control" name="department" id="department"
								value="<%=project.getDepartment() %>">
							</div>
                            
                            <div class="mb-3">
                                <label for="techStacks" class="form-label"><fmt:message key="requiredTechStack"/></label>
                                <input type="text" class="form-control" name="techStacks" id="techStacks" 
                                value="<%=project.getTechStacks()%>">
                            </div>
                            
                            <div class="mb-3">
                                <label for="requiredRoles" class="form-label"><fmt:message key="recruitmentField" /></label>
                                <textarea class="form-control" name="requiredRoles" id="requiredRoles" rows="4" 
                                placeholder="예:&#10;백엔드 (Java/JSP) - 2명&#10;프론트엔드 (HTML/CSS) - 1명"><%= project.getRequiredRoles() == null ? "" : project.getRequiredRoles() %></textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label for="projectDescription" class="form-label"><fmt:message key="projectDescrption" /></label>
                                <textarea class="form-control" name="projectDescription" id="projectDescription" rows="8"><%= project.getProjectDescription() == null ? "" : project.getProjectDescription() %></textarea>
                            </div>

                            <div class="row mt-4">
                                <div class="col d-grid">
                                    <a href="project_view.jsp?id=<%=projectId%>" class="btn btn-secondary"><fmt:message key="cancel" /></a>
                                </div>
                                <div class="col d-grid">
                                    <button type="submit" class="btn btn-primary"><fmt:message key="updateInformation" /></button>
                                </div>
                            </div>
                            
                        </form> 
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