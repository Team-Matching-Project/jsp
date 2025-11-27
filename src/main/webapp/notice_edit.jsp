<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.NoticeDAO" %>
<%@ page import="dto.NoticeDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    String idStr = request.getParameter("id");
    int noticeId = 0;
    
    try {
        if (idStr != null) {
            noticeId = Integer.parseInt(idStr);
        }
    } catch (NumberFormatException e) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    String userRole = (String) session.getAttribute("userRole");
    if (!"admin".equals(userRole)) {
        out.println("<script>alert('권한이 없습니다.'); location.href='index.jsp';</script>");
        return;
    }

    NoticeDAO noticeDAO = new NoticeDAO();
    NoticeDTO notice = noticeDAO.retrieveNotice(noticeId);
    
    if (notice == null) {
        out.println("<script>alert('존재하지 않는 게시물입니다.'); history.back();</script>");
        return;
    }
    
    pageContext.setAttribute("notice", notice);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<style> body { background-color: #f8f9fa; } </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="header.jsp" />
    
    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                <div class="card shadow-sm">
                    <div class="card-body p-4 p-md-5">
                        
                        <h3 class="card-title text-center mb-4"><fmt:message key="updateNotice" /></h3>
                        
                        <form action="noticeUpdateAction.jsp" method="post" enctype="multipart/form-data">
                            
                            <input type="hidden" name="noticeId" value="${notice.id}">
                            <input type="hidden" name="oldFileRealName" value="${notice.fileRealName}">
                            <input type="hidden" name="oldFileName" value="${notice.fileName}">

                            <div class="mb-3">
                                <label for="noticeTitle" class="form-label"><fmt:message key="noticeTitle" /></label>
                                <input type="text" class="form-control" id="noticeTitle" name="noticeTitle"
                                       value="${notice.noticeTitle}" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="file" class="form-label"><fmt:message key="attachedData" /></label>
                                
                                <c:if test="${not empty notice.fileName}">
                                    <div class="mb-2 p-2 bg-light border rounded small">
                                        <fmt:message key="currentFile" />: <strong>${notice.fileName}</strong>
                                        <br>
                                        <span class="text-muted"><fmt:message key="info" /></span>
                                    </div>
                                </c:if>
                                
                                <input type="file" class="form-control" id="file" name="file">
                            </div>
                            
                            <div class="mb-3">
                                <label for="noticeContent" class="form-label"><fmt:message key="noticeContent" /></label>
                                <textarea class="form-control" name="noticeContent" id="noticeContent" rows="15" 
                                          required>${notice.noticeContent}</textarea>
                            </div>
                            
                            <div class="row mt-4">
                                <div class="col d-grid">
                                    <a href="notice_view.jsp?id=${notice.id}" class="btn btn-secondary"><fmt:message key="cancel" /></a>
                                </div>
                                <div class="col d-grid">
                                    <button type="submit" class="btn btn-primary"><fmt:message key="editCompleted" /></button>
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