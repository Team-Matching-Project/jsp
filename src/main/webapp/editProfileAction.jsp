<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="java.time.LocalDate" %>
<%
    request.setCharacterEncoding("UTF-8");

    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }

    String userName = request.getParameter("userName");
    String birthDateStr = request.getParameter("birthDate");
    String department = request.getParameter("department");
    String gradeStr = request.getParameter("grade");
    String userGender = request.getParameter("userGender");
    String skills = request.getParameter("skills");
    String strengths = request.getParameter("strengths");

    UserDTO user = new UserDTO();
    user.setUserId(userId);
    user.setUserName(userName);
    user.setDepartment(department);
    user.setUserGender(userGender);
    user.setSkills(skills);
    user.setStrengths(strengths);
    
    if (gradeStr != null && !gradeStr.isEmpty()) {
        user.setGrade(Integer.parseInt(gradeStr));
    }

    if (birthDateStr != null && !birthDateStr.isEmpty()) {
        user.setBirthDate(LocalDate.parse(birthDateStr));
    }

    UserDAO userDAO = new UserDAO();
    int result = userDAO.updateUser(user);

    if (result == 1) {
        out.println("<script>");
        out.println("alert('회원 정보가 수정되었습니다.');");
        out.println("location.href='mypage.jsp';"); // 수정 후 마이페이지로 이동
        out.println("</script>");
    } else {
        out.println("<script>");
        out.println("alert('정보 수정에 실패했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>