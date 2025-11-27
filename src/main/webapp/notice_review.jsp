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

    NoticeDAO noticeDAO = new NoticeDAO();
    NoticeDTO notice = noticeDAO.retrieveNotice(noticeId);
    
    if (notice == null) {
        out.println("<script>alert('존재하지 않거나 삭제된 게시물입니다.'); history.back();</script>");
        return;
    }

    pageContext.setAttribute("notice", notice);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${notice.noticeTitle} - 공지사항</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body { background-color: #f8f9fa; }
    .content-area { white-space: pre-wrap; min-height: 200px; }
</style>
</head>

<body class="d-flex flex-column min-vh-100">

    <jsp:include page="header.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                
                <div class="card shadow-sm">
                    
                    <div class="card-header bg-white p-4">
                        <h4 class="card-title fw-bold mb-2">${notice.noticeTitle}</h4>
                        <div class="d-flex justify-content-between text-muted small">
                            <span><fmt:message key="writer" />: <fmt:message key="admin" /></span>
                            <span><fmt:message key="creationDate" />: ${notice.createdAt}</span>
                        </div>
                    </div>

                    <div class="card-body p-4">
                        
                        <c:if test="${not empty notice.fileName}">
                            <div class="mb-4 p-3 bg-light rounded border">
                                <span class="fw-bold me-2">💾 <fmt:message key="attachment" />:</span>
                                <a href="${pageContext.request.contextPath}/uploads/${notice.fileRealName}" download="${notice.fileName}" class="text-decoration-none">
                                    ${notice.fileName}
                                </a>
                            </div>
                        </c:if>

                        <div class="content-area text-break">${notice.noticeContent}</div>
                    </div>

                    <div class="card-footer bg-white p-3 d-flex justify-content-between">
                        
                        <a href="./index.jsp" class="btn btn-secondary"><fmt:message key="toList" /></a>
                        
                        <c:if test="${sessionScope.userRole eq 'admin'}">
                            <div>
                                <a href="notice_edit.jsp?id=${notice.id}" class="btn btn-primary me-1"><fmt:message key="update"/></a>
                                <button type="button" class="btn btn-danger" onclick="deleteNotice(${notice.id})"><fmt:message key="delete" /></button>
                            </div>
                        </c:if>
                        
                    </div>
                </div>

            </div>
        </div>
    </div>

    <footer class="mt-auto">
        <jsp:include page="footer.jsp" />
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function deleteNotice(id) {
            if (confirm("정말 이 공지사항을 삭제하시겠습니까? 복구할 수 없습니다.")) {
                location.href = "noticeDeleteAction.jsp?id=" + id;
            }
        }
    </script>
    
</body>
</html>