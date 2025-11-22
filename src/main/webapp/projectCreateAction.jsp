<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 1. DAO, DTO 임포트 --%>
<%@ page import="dao.ProjectDAO" %>
<%@ page import="dto.ProjectDTO" %>
<%
	/* --- 2. [보안] 로그인 세션 확인 --- */
	// 로그인을 하지 않은 사용자가 이 페이지에 접근하는 것을 막습니다.
	String leaderID = (String) session.getAttribute("userId");
	
	if (leaderID == null) {
		// 3. 로그인이 안되어있다면, 로그인 페이지로 튕겨냅니다.
		response.setContentType("text/html; charset=UTF-8");
		java.io.PrintWriter out_js = response.getWriter();
		out_js.println("<script>");
		out_js.println("alert('프로젝트를 등록하려면 로그인이 필요합니다.');");
		out_js.println("location.href='login.jsp';");
		out_js.println("</script>");
		out_js.flush();
		return; 
	}

	/* --- 4. 폼 데이터 받기 (POST 방식, 한글 인코딩) --- */
	request.setCharacterEncoding("UTF-8");
	
	String projectTitle = request.getParameter("projectTitle");
	String projectType = request.getParameter("projectType");
	String deadlineDate = request.getParameter("deadlineDate"); // "YYYY-MM-DD"
	String projectDuration = request.getParameter("projectDuration");
	int totalMembers = Integer.parseInt(request.getParameter("totalMembers")); // 숫자로 변환
	String techStacks = request.getParameter("techStacks");
	String requiredRoles = request.getParameter("requiredRoles");
	String projectDescription = request.getParameter("projectDescription");
	String department = request.getParameter("department");

	/* --- 5. DTO(바구니)에 폼 데이터 담기 --- */
	ProjectDTO dto = new ProjectDTO();
	dto.setProjectTitle(projectTitle);
	dto.setProjectType(projectType);
	dto.setDeadline(deadlineDate); // DAO에서 String으로 받기로 함
	dto.setProjectDuration(projectDuration);
	dto.setTotalMembers(totalMembers);
	dto.setTechStacks(techStacks);
	dto.setRequiredRoles(requiredRoles); // [주의] DTO와 DB 테이블에 이 컬럼 추가 필요
	dto.setProjectDescription(projectDescription);
	dto.setDepartment(department);
	
	// [중요] 폼에 없던 '작성자 ID'를 세션에서 가져와 DTO에 담습니다.
	dto.setLeaderID(leaderID); 
	
	/* --- 6. DAO(로봇)를 시켜서 DB에 INSERT --- */
	ProjectDAO dao = new ProjectDAO();
	int result = dao.createProject(dto); // INSERT 실행, 성공 시 1, 실패 시 0 반환
	
	/* --- 7. 결과에 따라 사용자에게 알림 후 페이지 이동 --- */
	response.setContentType("text/html; charset=UTF-8");
	java.io.PrintWriter out_js = response.getWriter();
	
	if (result > 0) {
		// INSERT 성공
		out_js.println("<script>");
		out_js.println("alert('프로젝트가 성공적으로 등록되었습니다.');");
		out_js.println("location.href='index.jsp';"); // 메인 페이지로 이동
		out_js.println("</script>");
	} else {
		// INSERT 실패
		out_js.println("<script>");
		out_js.println("alert('프로젝트 등록에 실패했습니다. 다시 시도해주세요.');");
		out_js.println("history.back();"); // 이전 페이지(등록 폼)로 돌아가기
		out_js.println("</script>");
	}
	out_js.flush();
%>