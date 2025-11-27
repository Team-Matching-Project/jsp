<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeParseException" %>

<%
	request.setCharacterEncoding("UTF-8");

	String userId = request.getParameter("userId");
	String userPassword = request.getParameter("userPassword");
	String userName = request.getParameter("userName");
	String gender = request.getParameter("gender");
	String birthDateStr = request.getParameter("birthDate");
	String department = request.getParameter("department");
	String gradeStr = request.getParameter("grade");
	
	if (userId == null || userPassword == null || userName == null) {
		response.setContentType("text/html; charset=UTF-8");
		java.io.PrintWriter out_js = response.getWriter();
		out_js.println("<script>");
		out_js.println("alert('필수 정보(아이디, 비번, 이름)가 누락되었습니다.');");
		out_js.println("history.back();");
		out_js.println("</script>");
		out_js.flush();
		return;
	}

	UserDTO user = new UserDTO();
	user.setUserId(userId);
	user.setUserPassword(userPassword);
	user.setUserName(userName);
	user.setUserGender(gender);
	user.setDepartment(department);
	
	if (gradeStr != null && !gradeStr.isEmpty()) {
		user.setGrade(Integer.parseInt(gradeStr));
	}
	
	if (birthDateStr != null && !birthDateStr.isEmpty()) {
		try {
			user.setBirthDate(LocalDate.parse(birthDateStr));
		} catch (DateTimeParseException e) {
			e.printStackTrace();
		}
	}
	
	user.setSkills("");
	user.setStrengths("");

	UserDAO dao = new UserDAO();
	int result = dao.signUp(user);

	response.setContentType("text/html; charset=UTF-8");
	java.io.PrintWriter out_js = response.getWriter();

	if (result == 1) {
		out_js.println("<script>");
		out_js.println("alert('회원가입이 완료되었습니다! 로그인해주세요.');");
		out_js.println("location.href='login.jsp';");
		out_js.println("</script>");
	} else {
		out_js.println("<script>");
		out_js.println("alert('회원가입에 실패했습니다. (DB 오류)');");
		out_js.println("history.back();");
		out_js.println("</script>");
	}
	out_js.flush();
%>