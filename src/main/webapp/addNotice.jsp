<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
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
    
    if (userId == null) {
        out.println("<script>");
        out.println("alert('로그인이 필요합니다.');");
        out.println("location.href='login.jsp';");
        out.println("</script>");
        return;
    }

    String userRole = (String) session.getAttribute("userRole");
    
    if (userRole == null) {
        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.getUser(userId);
        if (user != null) {
            userRole = user.getRole();
        }
    }

    if (!"admin".equals(userRole)) {
        out.println("<script>");
        out.println("alert('관리자만 접근할 수 있는 페이지입니다.');");
        out.println("location.href='index.jsp';");
        out.println("</script>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 추가</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="header.jsp" />
	
	<div class="container my-5">
		<div class="row justify-content-center">
			<div class="col-lg-8 col-md-10">
				<div class="card shadow-sm">
					<div class="card-body p-4 p-md-5">
						
						<h3 class="card-title text-center mb-4"><fmt:message key="registerNewNotice" /></h3>
						
						<form action="noticeWriteAction.jsp" method="post" enctype="multipart/form-data">
							<div class="mb-3">
								<label for="noticeTitle" class="form-label"><fmt:message key="noticeTitle" /></label>
								<input type="text" class="form-control" id="noticeTitle" name="noticeTitle" required placeholder='<fmt:message key="noticeTitlePlaceHolder"/>'>
							</div>
							<div class="mb-3">
								<label for="file" class="form-label"><fmt:message key="attachedData" /></label>
								<input type="file" class="form-control" id="file" name="file">
							</div>
							<div class="mb-3">
								<label for="noticeContent" class="form-label"><fmt:message key="noticeContent" /></label>
								<textarea class="form-control" name="noticeContent" id="noticeContent" rows="30" 
    								placeholder='<fmt:message key="noticeContentPlaceHolder"/>'></textarea>
							</div>
							
							<div class="row mt-4">
								<div class="col d-grid">
									<a href="index.jsp" class="btn btn-secondary"><fmt:message key="cancel" /></a>
								</div>
								<div class="col d-grid">
									<button type="submit" class="btn btn-primary"><fmt:message key="noticeRegister" /></button>
								</div>
							</div>
						</form>
						
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>		
</body>
</html>