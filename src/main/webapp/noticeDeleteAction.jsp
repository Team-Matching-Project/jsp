<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.NoticeDAO" %>
<%@ page import="dto.NoticeDTO" %>
<%@ page import="java.io.File" %>

<%
    String userRole = (String) session.getAttribute("userRole");
    if (!"admin".equals(userRole)) {
        out.println("<script>alert('권한이 없습니다.'); location.href='index.jsp';</script>");
        return;
    }

    String idStr = request.getParameter("id");
    int noticeId = 0;
    
    try {
        noticeId = Integer.parseInt(idStr);
    } catch (Exception e) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    NoticeDAO dao = new NoticeDAO();
    NoticeDTO notice = dao.retrieveNotice(noticeId);
    
    if (notice != null && notice.getFileRealName() != null && !notice.getFileRealName().equals("")) {
        String savePath = application.getRealPath("/uploads");
        File file = new File(savePath + File.separator + notice.getFileRealName());
        
        if (file.exists()) {
            file.delete();
        }
    }

    int result = dao.deleteNotice(noticeId);

    if (result == 1) {
        out.println("<script>");
        out.println("alert('삭제되었습니다.');");
        out.println("location.href='index.jsp';");
        out.println("</script>");
    } else {
        out.println("<script>");
        out.println("alert('삭제 실패했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>