<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProjectDAO" %>
<%
    String idStr = request.getParameter("id");
    
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    int projectId = 0;
    try {
        if (idStr != null) {
            projectId = Integer.parseInt(idStr);
        }
    } catch (NumberFormatException e) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    ProjectDAO dao = new ProjectDAO();
    int result = dao.delete(projectId);

    if (result == 1) {
        out.println("<script>");
        out.println("alert('삭제되었습니다.');");
        out.println("location.href='index.jsp';");
        out.println("</script>");
    } else {
        out.println("<script>");
        out.println("alert('삭제 실패 (존재하지 않는 글이거나 DB 오류)');");
        out.println("history.back();");
        out.println("</script>");
    }
%>