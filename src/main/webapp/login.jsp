<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    String savedId = "";
    Cookie[] cookies = request.getCookies();
    
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("savedId".equals(c.getName())) {
                savedId = c.getValue();
                break;
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

<style>
	body {
		background-color: #f8f9fa;
	}
</style>
</head>
<body>
	
	<div class="container">
		<div class="row justify-content-center mt-5">
			
			<div class="col-md-6 col-lg-4">
				
				<div class="card shadow-sm">
					<div class="card-body p-4">
						
						<h3 class="card-title text-center mb-4"><fmt:message key="login" /></h3>
						
						<form action="loginAction.jsp" method="post">
							<div class="mb-3">
								<label class="form-label" for="userId"><fmt:message key="id" /> </label>
                                <input class="form-control" type="text" name="userId" id="userId" 
                                       value="<%= savedId %>" required/>
							</div>
							<div class="mb-3">
								<label class="form-label" for="userPassword"><fmt:message key="password" /></label>
								<input class="form-control" type="password" name="userPassword" id="userPassword" required/>
							</div>
							
                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" name="rememberId" id="rememberId" 
                                       <%= !savedId.isEmpty() ? "checked" : "" %>>
                                <label class="form-check-label" for="rememberId"><fmt:message key="idSave" /></label>
                            </div>

							<div class="d-grid mt-4">
								<button type="submit" class="btn btn-primary"><fmt:message key="login" /></button>
							</div>

							<div class="text-center mt-3">
								<a href="signup.jsp"><fmt:message key="noMember" /></a>
							</div>
						</form>
						
					</div> </div> </div> </div> </div> <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>