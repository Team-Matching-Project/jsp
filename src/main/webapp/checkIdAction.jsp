<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userId = request.getParameter("userId"); 
    
    // [수정] try-catch 블록으로 감싸기
    try {
        UserDAO dao = new UserDAO();
        int result = dao.checkDuplicateId(userId);
        out.print(result); 
        
    } catch (Exception e) {
        // 에러가 나면 이클립스 콘솔에 내용을 출력하고
        e.printStackTrace(); 
        // 화면에는 -1(에러 발생)을 출력
        out.print("-1"); 
    }
%>