<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%
	// 1. 파라미터 받기
	request.setCharacterEncoding("UTF-8");
	String userID = request.getParameter("userId"); // login.jsp의 input name="id"가 아니라 "userID"여야 함
	String userPassword = request.getParameter("userPassword"); // name="password"가 아니라 "userPassword"
	
	// 2. DAO 로그인 시도
	UserDAO dao = new UserDAO();
	int result = dao.login(userID, userPassword);
	
	response.setContentType("text/html; charset=UTF-8");
	java.io.PrintWriter out_js = response.getWriter();
	
	if (result == 1) {
		// [로그인 성공]
		
		// 3. 사용자 정보를 가져와서 세션에 저장 (가장 중요!)
		UserDTO user = dao.getUser(userID);
		
		session.setAttribute("userId", user.getUserId());     // "userID" 세션 생성
		session.setAttribute("userName", user.getUserName()); // "userName" 세션 생성
		session.setAttribute("userRole", user.getRole());     // "userRole" (admin/user) 세션 생성
		
		out_js.println("<script>");
		out_js.println("location.href='index.jsp';"); // 메인으로 이동
		out_js.println("</script>");
		
	} else if (result == 0) {
		// [비밀번호 불일치]
		out_js.println("<script>");
		out_js.println("alert('비밀번호가 일치하지 않습니다.');");
		out_js.println("history.back();");
		out_js.println("</script>");
		
	} else if (result == -1) {
		// [아이디 없음]
		out_js.println("<script>");
		out_js.println("alert('존재하지 않는 아이디입니다.');");
		out_js.println("history.back();");
		out_js.println("</script>");
		
	} else {
		// [DB 오류]
		out_js.println("<script>");
		out_js.println("alert('데이터베이스 오류가 발생했습니다.');");
		out_js.println("history.back();");
		out_js.println("</script>");
	}
	out_js.flush();
%>