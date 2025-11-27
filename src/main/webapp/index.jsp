<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.StatsDTO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="dao.NoticeDAO" %>
<%@ page import="dto.NoticeDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List" %>
<%
	ProjectDAO projectDAO = new ProjectDAO();
	List<StatsDTO> deadlineStats = projectDAO.countProjectsNearDeadline();
	List<StatsDTO> stats = projectDAO.countProjectsByDept();
	pageContext.setAttribute("deadlineStats", deadlineStats);
	pageContext.setAttribute("stats",stats);
    String userRole = (String) session.getAttribute("userRole");
    String userId = (String) session.getAttribute("userId");
    
    if (userRole == null) {
        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.getUser(userId);
        if (user != null) {
            userRole = user.getRole();
        }
    }
    NoticeDAO noticeDAO = new NoticeDAO();
    List<NoticeDTO> noticeList = null;
    String searchKeyword = request.getParameter("search");
    if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
        noticeList = noticeDAO.filteredByTitle(searchKeyword);
    } else {
        noticeList = noticeDAO.retrieveAll();
    }
    
    pageContext.setAttribute("noticeList", noticeList);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 매칭 시스템 - 메인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<style>
	body {
		background-color: #f8f9fa;
	}
</style>
</head>
<body class="d-flex flex-column min-vh-100">
	
	<%@include file="./header.jsp" %>
	
	<div class="container mt-4">
		<div class="row g-4">
			
			<div class="col-lg-8 col-12">
				
				<h3 class="mb-3">🚀 <fmt:message key="recentProject"/></h3>
				<%@ include file="./project_list.jsp" %>
				
				<div class="mt-4">
					<h4 class="mb-3 fw-bold">📊 <fmt:message key="projectStatus" /></h4>
					<%@ include file="./statics.jsp" %>
				</div>

			</div>
			<div class="col-lg-4 col-12">
				
				<div class="card shadow-sm mb-4">
						<c:choose>
							<c:when test="${sessionScope.userRole eq 'admin'}">
									<div class="card-header fw-semibold d-flex justify-content-between align-items-center">
									        <span>📣 <fmt:message key="notice"/></span>
									        <a href="./addNotice.jsp" class="btn btn-sm btn-secondary"><fmt:message key="enroll" /></a>
									 </div>
							</c:when>
							<c:otherwise>
								<div class="card-header fw-semibold">📣 <fmt:message key="notice"/></div>
							</c:otherwise>
						</c:choose>
						<form action="index.jsp" method="get" class="m-3 d-flex justify-content-center">
						    <div class="input-group" style="max-width: 500px;"> <span class="input-group-text bg-white text-muted">🔍</span>
						        <input type="text" class="form-control border-start-0" name="search" placeholder="<fmt:message key="searchByTitle"/>">
						        <button type="submit" class="btn btn-dark"><fmt:message key="search"/></button>
						    </div>
						</form>
					<%@ include file="./notice.jsp" %> 
				</div>
				
				<div class="card shadow-sm">
					<div class="card-header fw-semibold">📜 <fmt:message key="rule" /></div>
					<%@ include file="./rule.jsp" %>
				</div>
				
			</div>
			</div> </div> <footer class="mt-auto">
		<%@ include file="./footer.jsp" %>
	</footer>
	

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>