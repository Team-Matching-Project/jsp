<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<nav class="navbar navbar-expand-lg bg-dark shadow-sm" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">🚀 팀 매칭 시스템</a>
    
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="project_list.jsp">프로젝트 목록</a>
        </li>
        
        <c:if test="${not empty sessionScope.userID}">
        	<li class="nav-item">
	          <a class="nav-link" href="project_create.jsp">프로젝트 등록</a>
	        </li>
        </c:if>
      </ul>
      
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
      	
      	<c:if test="${empty sessionScope.userID}">
	        <li class="nav-item">
	          <a class="nav-link" href="login.jsp">로그인</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="signup.jsp">회원가입</a>
	        </li>
        </c:if>
        
        <c:if test="${not empty sessionScope.userID}">
        	<li class="nav-item">
        		<span class="navbar-text me-2">
        			${sessionScope.userID}님, 환영합니다!
        		</span>
	        </li>
        	<li class="nav-item">
	          <a class="nav-link" href="mypage.jsp">마이페이지</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="logoutAction.jsp">로그아웃</a>
	        </li>
        </c:if>
        
      </ul>
      
    </div> </div> </nav>

</body>
</html>