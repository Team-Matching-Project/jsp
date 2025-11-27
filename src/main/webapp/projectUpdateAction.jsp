<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.ProjectDTO" %>
<%
    request.setCharacterEncoding("UTF-8");

    String sessionUserId = (String) session.getAttribute("userId");
    if (sessionUserId == null) {
        out.println("<script>");
        out.println("alert('로그인이 필요한 서비스입니다.');");
        out.println("location.href='login.jsp';");
        out.println("</script>");
        return;
    }

    int projectID = Integer.parseInt(request.getParameter("projectID"));
    
    String projectTitle = request.getParameter("projectTitle");
    String projectType = request.getParameter("projectType");
    String deadline = request.getParameter("deadlineDate");
    String projectDuration = request.getParameter("projectDuration");
    String totalMembersStr = request.getParameter("totalMembers");
    String techStacks = request.getParameter("techStacks");
    String requiredRoles = request.getParameter("requiredRoles");
    String projectDescription = request.getParameter("projectDescription");
    String department = request.getParameter("department");

    if (projectID == -1) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    ProjectDTO project = new ProjectDTO();
    project.setProjectID(projectID);
    project.setProjectTitle(projectTitle);
    project.setProjectType(projectType);
    project.setDeadline(deadline);
    project.setProjectDuration(projectDuration);
    project.setTechStacks(techStacks);
    project.setRequiredRoles(requiredRoles);
    project.setProjectDescription(projectDescription);
    project.setDepartment(department);
    
    if (totalMembersStr != null && !totalMembersStr.equals("")) {
        project.setTotalMembers(Integer.parseInt(totalMembersStr));
    } else {
        project.setTotalMembers(0);
    }

    ProjectDAO dao = new ProjectDAO();
    int result = dao.updateProject(project);

    if (result == 1) {
        out.println("<script>");
        out.println("alert('프로젝트 수정이 완료되었습니다.');");
        out.println("location.href='project_view.jsp?id=" + projectID + "';");
        out.println("</script>");
    } else {
        out.println("<script>");
        out.println("alert('프로젝트 수정에 실패했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>