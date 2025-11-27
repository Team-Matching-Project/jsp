<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userId = request.getParameter("userId"); 
    
    try {
        UserDAO dao = new UserDAO();
        int result = dao.checkDuplicateId(userId);
        out.print(result); 
        
    } catch (Exception e) {
        e.printStackTrace(); 
        out.print("-1"); 
    }
%>