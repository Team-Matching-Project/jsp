<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.NoticeDAO" %>
<%@ page import="dto.NoticeDTO" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%
    String userRole = (String) session.getAttribute("userRole");
    if (!"admin".equals(userRole)) {
        out.println("<script>alert('권한이 없습니다.'); location.href='index.jsp';</script>");
        return;
    }

    String savePath = application.getRealPath("/uploads");
    int maxSize = 1024 * 1024 * 10; // 10MB
    String encoding = "UTF-8";

    File uploadDir = new File(savePath);
    if (!uploadDir.exists()) uploadDir.mkdir();

    try {
        MultipartRequest multi = new MultipartRequest(
                request, savePath, maxSize, encoding, new DefaultFileRenamePolicy()
        );

        String idStr = multi.getParameter("noticeId");
        String title = multi.getParameter("noticeTitle");
        String content = multi.getParameter("noticeContent");
        
        String oldFileName = multi.getParameter("oldFileName");
        String oldFileRealName = multi.getParameter("oldFileRealName");

        String newFileName = multi.getOriginalFileName("file");
        String newFileRealName = multi.getFilesystemName("file");

        String finalFileName = oldFileName;
        String finalFileRealName = oldFileRealName;

        if (newFileName != null) {
            finalFileName = newFileName;
            finalFileRealName = newFileRealName;
            
        }

        NoticeDTO notice = new NoticeDTO();
        notice.setId(Integer.parseInt(idStr));
        notice.setNoticeTitle(title);
        notice.setNoticeContent(content);
        notice.setFileName(finalFileName);
        notice.setFileRealName(finalFileRealName);

        NoticeDAO dao = new NoticeDAO();
        int result = dao.updateNotice(notice);

        if (result == 1) {
            out.println("<script>");
            out.println("alert('공지사항이 수정되었습니다.');");
            out.println("location.href='notice_review.jsp?id=" + idStr + "';");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('공지사항 수정에 실패했습니다.');");
            out.println("history.back();");
            out.println("</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>");
        out.println("alert('오류가 발생했습니다.'); history.back();");
        out.println("</script>");
    }
%>