<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ApplicationDAO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    String action = request.getParameter("action");
    String appIdStr = request.getParameter("appID");
    String projectIdStr = request.getParameter("projectID");

    if (action == null || appIdStr == null || projectIdStr == null) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    int appId = Integer.parseInt(appIdStr);
    
    ApplicationDAO appDAO = new ApplicationDAO();
    int result = 0;

    if ("approve".equals(action)) {
        result = appDAO.permitApplication(appId, projectIdStr);
    } else if ("reject".equals(action)) {
        result = appDAO.rejectApplication(appId);
    }

    if (result == 1) {
        response.sendRedirect("manage_applicants.jsp?id=" + projectIdStr);
    } else {
        out.println("<script>");
        out.println("alert('처리 중 오류가 발생했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>