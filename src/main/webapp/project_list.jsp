<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. JSTL 태그 라이브러리 (c:forEach, c:if 등) --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 2. DAO, DTO, List 임포트 --%>
<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.ProjectDTO" %>
<%@ page import="java.util.List" %>
<%
	/* --- 3. DB 로직: DAO를 통해 모든 프로젝트 목록 가져오기 --- */
	ProjectDAO dao = new ProjectDAO();
	List<ProjectDTO> projectList = dao.getAllProjects(); // "SELECT * FROM PROJECT..."
	
	/* --- 4. JSTL이 사용할 수 있도록 pageContext에 저장 --- */
	pageContext.setAttribute("projectList", projectList);
%>

<%-- 
  이 파일은 include용 조각이므로 <html>, <body>, <head> 태그가 없습니다.
--%>
<div class="row row-cols-1 row-cols-md-2 g-4">
	
	<%-- [JSTL] projectList가 비어있을 때 --%>
	<c:if test="${empty projectList}">
		<div class="col-12">
			<div class="card shadow-sm">
				<div class="card-body text-center p-5">
					<p class="text-muted mb-0">현재 모집 중인 프로젝트가 없습니다.</p>
				</div>
			</div>
		</div>
	</c:if>

	<%-- 
	  ▼▼▼ 5. JSTL <c:forEach>로 목록 반복 ▼▼▼
	  projectList에 담긴 DTO를 하나씩 꺼내 'project'라는 변수명으로 사용
	--%>
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
							모집 인원
							<span class="badge bg-primary rounded-pill">
								${project.currentMembers} / ${project.totalMembers}명
							</span>
						</li>
						<li class="list-group-item d-flex justify-content-between align-items-center px-0">
							팀장
							<span>${project.leaderID}</span>
						</li>
					</ul>
				</div>
				
				<div class="card-footer bg-white border-top-0 d-flex justify-content-between align-items-center">
					<a href="project_view.jsp?id=${project.projectID}" class="btn btn-dark btn-sm">상세 보기</a>
					<small class="text-muted">~ ${project.deadline} 까지</small>
				</div>
			</div>
		</div>
	</c:forEach>
	</div>