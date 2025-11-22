<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = request.getParameter("userId");
	String userPassword = request.getParameter("userPassword");
	
	String rememberId = request.getParameter("rememberId");
	
	UserDAO dao = new UserDAO();
	int result = dao.login(userID, userPassword);
	
	response.setContentType("text/html; charset=UTF-8");
	java.io.PrintWriter out_js = response.getWriter();
	
	if (result == 1) {
		
		UserDTO user = dao.getUser(userID);
		
		session.setAttribute("userId", user.getUserId());
		session.setAttribute("userName", user.getUserName());
		session.setAttribute("userRole", user.getRole());
		
		Cookie cookie = new Cookie("savedId", userID);
		
		if (rememberId != null) {
			cookie.setMaxAge(60 * 60 * 24 * 7); 
		} else {
			cookie.setMaxAge(0);
		}
		response.addCookie(cookie);
		
		out_js.println("<script>");
		out_js.println("location.href='index.jsp';");
		out_js.println("</script>");
		
	} else if (result == 0) {
		out_js.println("<script>");
		out_js.println("alert('비밀번호가 일치하지 않습니다.');");
		out_js.println("history.back();");
		out_js.println("</script>");
		
	} else if (result == -1) {
		out_js.println("<script>");
		out_js.println("alert('존재하지 않는 아이디입니다.');");
		out_js.println("history.back();");
		out_js.println("</script>");
		
	} else {
		out_js.println("<script>");
		out_js.println("alert('데이터베이스 오류가 발생했습니다.');");
		out_js.println("history.back();");
		out_js.println("</script>");
	}
	out_js.flush();
%>