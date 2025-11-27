<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.ProjectDTO" %>
<%@ page import="java.util.List" %>
<%
	ProjectDAO dao = new ProjectDAO();
	List<ProjectDTO> projectList = dao.getAllProjects();
	
	pageContext.setAttribute("projectList", projectList);
%>

<div class="row row-cols-1 row-cols-md-2 g-4">
	
	<c:if test="${empty projectList}">
		<div class="col-12">
			<div class="card shadow-sm">
				<div class="card-body text-center p-5">
					<p class="text-muted mb-0"><fmt:message key="noCurrentProject" /></p>
				</div>
			</div>
		</div>
	</c:if>

	<c:forEach var="project" items="${projectList}">
		<div class="col">
			<div class="card shadow-sm h-100">
				<div class="card-body">
					<h5 class="card-title">${project.projectTitle}</h5>
					
					<div class="mb-3">
						<span class="badge bg-secondary">${project.techStacks}</span>
					</div>
					
					<ul class="list-group list-group-flush">
						<li class="list-group-item d-flex justify-content-between align-items-center px-0">
							<fmt:message key="recruitedNumber"/>
							<span class="badge bg-primary rounded-pill">
								${project.currentMembers} / ${project.totalMembers}<fmt:message key="people" />
							</span>
						</li>
						<li class="list-group-item d-flex justify-content-between align-items-center px-0">
							<fmt:message key="teamLeader" />
							<span>${project.leaderID}</span>
						</li>
					</ul>
				</div>
				
				<div class="card-footer bg-white border-top-0 d-flex justify-content-between align-items-center">
					<a href="project_view.jsp?id=${project.projectID}" class="btn btn-dark btn-sm"><fmt:message key="viewDetail" /></a>
					<small class="text-muted">~ ${project.deadline} <fmt:message key="until" /></small>
				</div>
			</div>
		</div>
	</c:forEach>
	</div>