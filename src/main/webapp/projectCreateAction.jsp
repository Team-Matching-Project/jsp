<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. DAO, DTO 임포트 --%>
<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.ProjectDTO" %>
<%
	String leaderID = (String) session.getAttribute("userId");
	
	if (leaderID == null) {
		response.setContentType("text/html; charset=UTF-8");
		java.io.PrintWriter out_js = response.getWriter();
		out_js.println("<script>");
		out_js.println("alert('프로젝트를 등록하려면 로그인이 필요합니다.');");
		out_js.println("location.href='login.jsp';");
		out_js.println("</script>");
		out_js.flush();
		return; 
	}

	request.setCharacterEncoding("UTF-8");
	
	String projectTitle = request.getParameter("projectTitle");
	String projectType = request.getParameter("projectType");
	String deadlineDate = request.getParameter("deadlineDate");
	String projectDuration = request.getParameter("projectDuration");
	int totalMembers = Integer.parseInt(request.getParameter("totalMembers"));
	String techStacks = request.getParameter("techStacks");
	String requiredRoles = request.getParameter("requiredRoles");
	String projectDescription = request.getParameter("projectDescription");
	String department = request.getParameter("department");

	ProjectDTO dto = new ProjectDTO();
	dto.setProjectTitle(projectTitle);
	dto.setProjectType(projectType);
	dto.setDeadline(deadlineDate);
	dto.setProjectDuration(projectDuration);
	dto.setTotalMembers(totalMembers);
	dto.setTechStacks(techStacks);
	dto.setRequiredRoles(requiredRoles);
	dto.setProjectDescription(projectDescription);
	dto.setDepartment(department);
	
	dto.setLeaderID(leaderID); 
	
	ProjectDAO dao = new ProjectDAO();
	int result = dao.createProject(dto);
	
	response.setContentType("text/html; charset=UTF-8");
	java.io.PrintWriter out_js = response.getWriter();
	
	if (result > 0) {
		out_js.println("<script>");
		out_js.println("alert('프로젝트가 성공적으로 등록되었습니다.');");
		out_js.println("location.href='index.jsp';");
		out_js.println("</script>");
	} else {
		out_js.println("<script>");
		out_js.println("alert('프로젝트 등록에 실패했습니다. 다시 시도해주세요.');");
		out_js.println("history.back();"); 
		out_js.println("</script>");
	}
	out_js.flush();
%>