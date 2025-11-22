<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.ProjectDTO" %>
<%@ page import="dto.ApplicationDTO" %> <%-- [중요] ApplicationDTO 임포트 --%>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String userId = (String) session.getAttribute("userId");
    
    if (userId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    // 1. 유저 정보 가져오기
    UserDAO userDAO = new UserDAO();
    UserDTO user = userDAO.getUser(userId);
    
    if (user == null) {
        out.println("<script>alert('유저 정보를 불러오지 못했습니다.'); history.back();</script>");
        return;
    }

    // 2. 프로젝트 및 지원 현황 가져오기
    ProjectDAO projectDAO = new ProjectDAO();
    
    // (1) 내가 만든 프로젝트 (리더인 경우)
    List<ProjectDTO> registeredProjects = projectDAO.getProjectsByLeader(userId); 
    
    // (2) 내가 지원한 프로젝트 (제목과 상태를 보기 위해 ApplicationDTO 사용)
    // [중요] ProjectDAO의 getAppliedProjects가 List<ApplicationDTO>를 반환해야 함
    List<ApplicationDTO> appliedProjects = projectDAO.getAppliedProjects(userId);

    // 3. JSTL 변수 설정
    pageContext.setAttribute("registeredProjects", registeredProjects);
    pageContext.setAttribute("appliedProjects", appliedProjects);
    pageContext.setAttribute("user", user);
    pageContext.setAttribute("enter", "\n"); // 줄바꿈 변수
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
        <h2 class="text-center mb-4">마이페이지</h2>

        <div class="row g-4">
            
            <div class="col-lg-4">
                <div class="card shadow-sm h-100">
                    <div class="card-header fs-5 fw-semibold">개인정보</div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <strong>이름</strong><span><%=user.getUserName() %></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <strong>학년</strong><span><%=user.getGrade() %>학년</span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <strong>학과</strong><span><%=user.getDepartment() %></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <strong>생년월일</strong><span><%=user.getBirthDate() %></span>
                        </li>
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <strong>성별</strong><span><%=user.getUserGender() %></span>
                        </li>
                        
                        <li class="list-group-item">
                            <strong>보유 기술</strong>
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
                            <strong>나의 강점</strong>
                            <c:if test="${not empty user.strengths}">
                                <c:set var="strengthList" value="${fn:split(user.strengths, enter)}" />
                                <c:forEach var="strength" items="${strengthList}">
                                    <p class="text-muted mb-0 mt-2" style="font-size: 0.9rem;">- ${strength}</p>
                                </c:forEach>
                            </c:if>
                        </li>
                    </ul>
                    <div class="card-footer text-center"> 
                        <a href="edit_profile.jsp" class="btn btn-dark">개인정보수정</a>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-8">
                
                <div class="card shadow-sm mb-4"> 
                    <div class="card-header fs-5 fw-semibold d-flex justify-content-between align-items-center">
                        등록한 프로젝트 관리
                        <a href="project_create.jsp" class="btn btn-primary btn-sm">새 프로젝트 등록</a>
                    </div>
                    <ul class="list-group list-group-flush">
                        <c:if test="${empty registeredProjects}">
                            <li class="list-group-item text-center py-4 text-muted">등록한 프로젝트가 없습니다.</li>
                        </c:if>

                        <c:forEach var="myProject" items="${registeredProjects}">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <a href="project_view.jsp?id=${myProject.projectID}" class="text-decoration-none fw-semibold">
                                        ${myProject.projectTitle}
                                    </a>
                                    <small class="text-muted ms-2">(현재 ${myProject.currentMembers} / ${myProject.totalMembers} 명)</small>
                                </div>
                                
                                <c:choose>
                                    <c:when test="${myProject.status == '모집 완료'}">
                                        <span class="badge bg-secondary">모집 완료</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="manage_applicants.jsp?id=${myProject.projectID}" class="btn btn-outline-dark btn-sm">
                                            지원자 관리
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
                
                <div class="card shadow-sm">
                    <div class="card-header fs-5 fw-semibold">지원한 프로젝트 현황</div>
                    <ul class="list-group list-group-flush">
                        
                        <c:if test="${empty appliedProjects}">
                            <li class="list-group-item text-center py-4 text-muted">지원한 내역이 없습니다.</li>
                        </c:if>

                        <c:forEach var="app" items="${appliedProjects}">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <a href="project_view.jsp?id=${app.projectId}" class="text-decoration-none">
                                    ${app.projectTitle}
                                </a>
                                
                                <c:choose>
                                    <c:when test="${app.status == '승인 완료'}">
                                        <span class="badge bg-success">승인 완료</span>
                                    </c:when>
                                    <c:when test="${app.status == '거절'}">
                                        <span class="badge bg-danger">거절</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-warning text-dark">승인 대기</span>
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