<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ApplicationDAO" %>
<%@ page import="dto.ApplicationDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    String projectIdStr = request.getParameter("projectId");
    String intro = request.getParameter("intro");

    if (projectIdStr == null || projectIdStr.isEmpty()) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    int projectId = 0;
    try {
        projectId = Integer.parseInt(projectIdStr);
    } catch (NumberFormatException e) {
        out.println("<script>alert('프로젝트 ID 오류입니다.'); history.back();</script>");
        return;
    }

    ApplicationDTO apply = new ApplicationDTO();
    apply.setUserId(userId);
    apply.setProjectId(projectId);
    
    apply.setIntro(intro != null ? intro : ""); 

    ApplicationDAO applicationDAO = new ApplicationDAO();
    
    int result = applicationDAO.makeApplication(apply);

    if (result == 1) {
        out.println("<script>");
        out.println("alert('프로젝트 지원이 완료되었습니다.\\n팀장의 승인을 기다려주세요.');");
        out.println("location.href = 'project_view.jsp?id=" + projectId + "';");
        out.println("</script>");
    } else if (result == 0) {
        out.println("<script>");
        out.println("alert('이미 지원한 프로젝트입니다.');");
        out.println("history.back();"); // 뒤로 가기
        out.println("</script>");
    } else {
        out.println("<script>");
        out.println("alert('시스템 오류로 지원에 실패했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>