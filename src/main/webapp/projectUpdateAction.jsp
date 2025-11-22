<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.ProjectDTO" %>
<%
    // 1. 한글 깨짐 방지 (가장 먼저 해야 함)
    request.setCharacterEncoding("UTF-8");

    // 2. 로그인 여부 확인 (세션 체크)
    String sessionUserId = (String) session.getAttribute("userId");
    if (sessionUserId == null) {
        out.println("<script>");
        out.println("alert('로그인이 필요한 서비스입니다.');");
        out.println("location.href='login.jsp';");
        out.println("</script>");
        return;
    }

    // 3. 폼에서 보낸 데이터 받기
    // (hidden으로 보낸 projectID를 꼭 받아야 수정 대상을 찾을 수 있음)
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

    // 5. DTO 객체 생성 및 데이터 담기
    ProjectDTO project = new ProjectDTO();
    project.setProjectID(projectID); // WHERE절에 들어갈 ID
    project.setProjectTitle(projectTitle);
    project.setProjectType(projectType);
    project.setDeadline(deadline);
    project.setProjectDuration(projectDuration);
    project.setTechStacks(techStacks);
    project.setRequiredRoles(requiredRoles);
    project.setProjectDescription(projectDescription);
    project.setDepartment(department);
    
    // 숫자 변환 (String -> int)
    if (totalMembersStr != null && !totalMembersStr.equals("")) {
        project.setTotalMembers(Integer.parseInt(totalMembersStr));
    } else {
        project.setTotalMembers(0); // 기본값
    }

    // 6. DAO 호출하여 DB 업데이트
    ProjectDAO dao = new ProjectDAO();
    int result = dao.updateProject(project);

    // 7. 결과 처리
    if (result == 1) {
        // 성공 시: 상세 페이지로 이동해서 수정된 내용 확인
        out.println("<script>");
        out.println("alert('프로젝트 수정이 완료되었습니다.');");
        out.println("location.href='project_view.jsp?id=" + projectID + "';");
        out.println("</script>");
    } else {
        // 실패 시: 뒤로 가기
        out.println("<script>");
        out.println("alert('프로젝트 수정에 실패했습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
%>