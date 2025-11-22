<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 1. JSTL 태그 라이브러리 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 2. DAO, DTO 임포트 --%>
<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.ProjectDTO" %>
<%
    /* --- 3. ID 받기 --- */
    String projectID = request.getParameter("id");

    /* --- 4. DB 로직 --- */
    ProjectDAO dao = new ProjectDAO();
    ProjectDTO project = dao.getProjectById(projectID); 
    
    /* --- 5. JSTL 변수 등록 --- */
    pageContext.setAttribute("project", project);
    
    /* 줄바꿈 처리를 위한 변수 */
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
    
                <%-- 1. 프로젝트가 없는 경우 --%>
                <c:if test="${empty project}">
                    <div class="alert alert-danger text-center" role="alert">
                        해당 프로젝트를 찾을 수 없습니다. (ID: <%= projectID %>)<br>
                        <a href="index.jsp" class="btn btn-outline-danger mt-2">메인으로 돌아가기</a>
                    </div>
                </c:if>
                
                <%-- 2. 프로젝트가 존재하는 경우 --%>
                <c:if test="${not empty project}">
                    <h2 class="mb-3">
                        ${project.projectTitle}
                        <c:if test="${project.status == '모집 중'}">
                            <span class="badge bg-success fs-6 ms-2">모집 중</span>
                        </c:if>
                        <c:if test="${project.status == '모집 완료'}">
                            <span class="badge bg-secondary fs-6 ms-2">모집 완료</span>
                        </c:if>
                    </h2>
                    <hr>
        
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><strong>작성자:</strong> ${project.leaderID}</li>
                                <li class="list-group-item"><strong>프로젝트 종류:</strong> ${project.projectType}</li>
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item"><strong>예상 기간:</strong> ${project.projectDuration}</li>
                                <li class="list-group-item"><strong>사용 기술:</strong> ${project.techStacks}</li>
                            </ul>
                        </div>
                    </div>
        
                    <div class="card shadow-sm mb-4">
                        <div class="card-header fs-5 fw-semibold">프로젝트 상세 설명</div>
                        <div class="card-body">
                            <p style="white-space: pre-wrap;">${project.projectDescription}</p>
                        </div>
                    </div>
        
                    <div class="card shadow-sm mb-4">
                        <div class="card-header fs-5 fw-semibold">모집 현황</div>
                        <div class="card-body">
                            <p class="fs-5">
                                <strong>전체 인원: ${project.currentMembers} / ${project.totalMembers}명</strong>
                                <span class="text-muted fs-6 ms-3">(모집 마감일: ~ ${project.deadline})</span>
                            </p>
                            
                            <div class="mt-3">
                                <strong>모집 분야:</strong>
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
                    
                    <%-- 버튼 영역 --%>
                    <c:choose>
                        <%-- 1. 내가 리더일 때 --%>
                        <c:when test="${not empty sessionScope.userId and project.leaderID eq sessionScope.userId}">
                            <div class="d-flex gap-2">
                                <a class="btn btn-dark btn-lg flex-grow-1" href="project_edit.jsp?id=${project.projectID}" role="button">프로젝트 수정</a>
                                <button class="btn btn-danger btn-lg" onclick="deleteProject('${project.projectID}')">삭제</button>
                            </div>
                        </c:when>
                        
                        <%-- 2. 내가 리더가 아닐 때 (지원 버튼) --%>
                        <c:otherwise>
                            <div class="d-grid gap-2">
                                <%-- [수정된 부분] 로그인 상태에 따라 다르게 동작 --%>
                                <c:choose>
                                    <c:when test="${empty sessionScope.userId}">
                                        <%-- 로그인 안 했으면 -> alert 띄우고 로그인 페이지로 --%>
                                        <button class="btn btn-primary btn-lg" type="button" onclick="alert('로그인이 필요합니다.'); location.href='login.jsp';">이 프로젝트에 지원하기</button>
                                    </c:when>
                                    <c:otherwise>
                                        <%-- 로그인 했으면 -> 모달(팝업) 띄우기 --%>
                                        <button class="btn btn-primary btn-lg" type="button" data-bs-toggle="modal" data-bs-target="#applyModal">이 프로젝트에 지원하기</button>
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
                    <h1 class="modal-title fs-5" id="applyModalLabel">📝 지원 신청서</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                
                <form action="applyAction.jsp" method="post">
                    <div class="modal-body">
                        <input type="hidden" name="projectId" value="${project.projectID}">
                        
                        <div class="mb-3">
                            <label for="intro" class="form-label fw-bold">자기소개 및 한마디</label>
                            <textarea class="form-control" id="intro" name="intro" rows="5" 
                                placeholder="예: 안녕하세요! 백엔드 개발자로 참여하고 싶습니다. 자바와 DB를 다룰 줄 압니다." required></textarea>
                        </div>
                        <div class="alert alert-light border" style="font-size: 0.9rem;">
                            💡 팀장에게 전달될 메시지입니다. 본인의 강점이나 연락 가능 시간을 적어주세요.
                        </div>
                    </div>
                    
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">지원 완료</button>
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