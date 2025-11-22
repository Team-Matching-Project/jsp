<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProjectDAO" %>
<%
    // 1. ID 받기 (아직은 String 상태)
    String idStr = request.getParameter("id");
    
    // 2. 로그인 체크 (생략 가능하지만 보안상 추천)
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    // 3. 유효성 검사 및 형변환 (String -> int)
    int projectId = 0;
    try {
        if (idStr != null) {
            // ★★★ 여기서 숫자로 바꿉니다! ★★★
            projectId = Integer.parseInt(idStr);
        }
    } catch (NumberFormatException e) {
        // 주소창에 ?id=가나다 처럼 이상한 거 넣었을 때 튕겨내기
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    // 4. DAO 호출 (이제 int를 넘겨줍니다)
    ProjectDAO dao = new ProjectDAO();
    int result = dao.delete(projectId);

    // 5. 결과 처리
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