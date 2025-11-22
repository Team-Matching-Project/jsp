<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 필요한 클래스 임포트 --%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeParseException" %>

<%
	// 1. 한글 데이터 깨짐 방지 (필수)
	request.setCharacterEncoding("UTF-8");

	// 2. 폼 데이터 받기
	String userId = request.getParameter("userId");
	String userPassword = request.getParameter("userPassword");
	String userName = request.getParameter("userName"); // [주의] 폼에 input이 있어야 함
	String gender = request.getParameter("gender");
	String birthDateStr = request.getParameter("birthDate");
	String department = request.getParameter("department");
	String gradeStr = request.getParameter("grade");
	
	// 3. 데이터 유효성 검사 (서버단 2차 검증 - 간략하게)
	if (userId == null || userPassword == null || userName == null) {
		// 필수 정보 누락 시
		response.setContentType("text/html; charset=UTF-8");
		java.io.PrintWriter out_js = response.getWriter();
		out_js.println("<script>");
		out_js.println("alert('필수 정보(아이디, 비번, 이름)가 누락되었습니다.');");
		out_js.println("history.back();");
		out_js.println("</script>");
		out_js.flush();
		return;
	}

	// 4. DTO 객체 생성 및 데이터 담기
	UserDTO user = new UserDTO();
	user.setUserId(userId);
	user.setUserPassword(userPassword); // DAO 안에서 암호화하므로 그대로 넘김
	user.setUserName(userName);
	user.setUserGender(gender);
	user.setDepartment(department);
	
	// 4-1. 학년 (String -> int 변환)
	if (gradeStr != null && !gradeStr.isEmpty()) {
		user.setGrade(Integer.parseInt(gradeStr));
	}
	
	// 4-2. 생년월일 (String -> LocalDate 변환)
	if (birthDateStr != null && !birthDateStr.isEmpty()) {
		try {
			user.setBirthDate(LocalDate.parse(birthDateStr));
		} catch (DateTimeParseException e) {
			e.printStackTrace();
		}
	}
	
	// 4-3. 아직 입력받지 않은 정보 (기술, 강점)는 빈 문자열로 초기화
	// (나중에 마이페이지 - 개인정보 수정에서 입력받음)
	user.setSkills("");
	user.setStrengths("");

	// 5. DAO 호출 (회원가입 실행)
	UserDAO dao = new UserDAO();
	int result = dao.signUp(user);

	// 6. 결과 처리
	response.setContentType("text/html; charset=UTF-8");
	java.io.PrintWriter out_js = response.getWriter();

	if (result == 1) {
		// 성공 -> 로그인 페이지로 이동
		out_js.println("<script>");
		out_js.println("alert('회원가입이 완료되었습니다! 로그인해주세요.');");
		out_js.println("location.href='login.jsp';");
		out_js.println("</script>");
	} else {
		// 실패 -> 이전 페이지로 복귀
		out_js.println("<script>");
		out_js.println("alert('회원가입에 실패했습니다. (DB 오류)');");
		out_js.println("history.back();");
		out_js.println("</script>");
	}
	out_js.flush();
%>