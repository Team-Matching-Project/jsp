<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.NoticeDAO" %>
<%@ page import="dto.NoticeDTO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
    String userRole = (String) session.getAttribute("userRole");
    if (!"admin".equals(userRole)) {
        out.println("<script>");
        out.println("alert('관리자만 접근 가능합니다.');");
        out.println("location.href='index.jsp';");
        out.println("</script>");
        return;
    }

    String savePath = application.getRealPath("/uploads");
    int maxSize = 1024 * 1024 * 10;
    String encoding = "UTF-8";

    File uploadDir = new File(savePath);
    if (!uploadDir.exists()) {
        uploadDir.mkdir();
    }

    try {
        MultipartRequest multi = new MultipartRequest(
                request, 
                savePath, 
                maxSize, 
                encoding, 
                new DefaultFileRenamePolicy()
        );

        String noticeTitle = multi.getParameter("noticeTitle");
        String noticeContent = multi.getParameter("noticeContent");
        
        String fileName = multi.getOriginalFileName("file");
        String fileRealName = multi.getFilesystemName("file");

        if (fileName == null) {
            fileName = "";
            fileRealName = "";
        }

        NoticeDTO notice = new NoticeDTO();
        notice.setNoticeTitle(noticeTitle);
        notice.setNoticeContent(noticeContent);
        notice.setFileName(fileName);
        notice.setFileRealName(fileRealName);

        NoticeDAO dao = new NoticeDAO();
        int result = dao.createNotice(notice);

        if (result == 1) {
            out.println("<script>");
            out.println("alert('공지사항이 등록되었습니다.');");
            out.println("location.href='index.jsp';");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('공지사항 등록에 실패했습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>");
        out.println("alert('파일 업로드 중 오류가 발생했습니다. (용량 초과 등)');");
        out.println("history.back();");
        out.println("</script>");
    }
%>