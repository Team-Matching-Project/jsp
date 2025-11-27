<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

<nav class="navbar navbar-expand-lg bg-dark shadow-sm" data-bs-theme="dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">🚀 <fmt:message key="teamMatchingSystem"/></a>
    
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="project_list.jsp"><fmt:message key="projectList"/></a>
        </li>
        
        <c:if test="${not empty sessionScope.userId}">
        	<li class="nav-item">
	          <a class="nav-link" href="project_create.jsp"><fmt:message key="registerProject" /></a>
	        </li>
        </c:if>
      </ul>
      
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
      
	      <li class="nav-item me-3">
	            <div class="btn-group btn-group-sm" role="group">
	                <a href="?lang=ko" class="btn ${sessionScope.lang == 'ko' ? 'btn-light' : 'btn-outline-light'}">🇰🇷 KO</a>
	                <a href="?lang=en" class="btn ${sessionScope.lang == 'en' ? 'btn-light' : 'btn-outline-light'}">🇺🇸 EN</a>
	            </div>
	        </li>
      	
      	<c:if test="${empty sessionScope.userId}">
	        <li class="nav-item">
	          <a class="nav-link" href="login.jsp"><fmt:message key="login"/></a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="signup.jsp"><fmt:message key="signUp"/></a>
	        </li>
        </c:if>
        
        <c:if test="${not empty sessionScope.userId}">
        	<li class="nav-item">
        		<span class="navbar-text me-2">
        			${sessionScope.userId}<fmt:message key="welcome"/>
        		</span>
	        </li>
        	<li class="nav-item">
	          <a class="nav-link" href="mypage.jsp"><fmt:message key="mypage" /></a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="logoutAction.jsp"><fmt:message key="logout" /></a>
	        </li>
        </c:if>
        
      </ul>
      
    </div> </div> </nav>

</body>
</html>