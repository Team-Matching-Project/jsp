<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
        return;
    }
    UserDAO userDAO = new UserDAO();
    UserDTO user = userDAO.getUser(userId);
    if (user == null) {
        out.println("<script>alert('정보 로드 실패'); history.back();</script>");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<style> body { background-color: #f8f9fa; } </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="header.jsp" />

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                <div class="card shadow-sm">
                    <div class="card-body p-4 p-md-5">
                        <h3 class="card-title text-center mb-4">개인정보수정</h3>
                        
                        <form action="editProfileAction.jsp" method="post">
                            
                            <div class="mb-3">
                                <label for="userName" class="form-label">이름</label>
                                <input type="text" class="form-control" id="userName" name="userName" 
                                       value="<%= user.getUserName() %>" readonly>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label for="birthDate" class="form-label">생년월일</label>
                                    <input type="date" class="form-control" name="birthDate" id="birthDate" 
                                           value="<%= user.getBirthDate() == null ? "" : user.getBirthDate() %>">
                                </div>
                                <div class="col-md-6">
                                    <label for="department" class="form-label">학과</label>
                                    <input type="text" class="form-control" name="department" id="department" 
                                           value="<%= user.getDepartment() == null ? "" : user.getDepartment() %>">
                                </div>
                            </div>
                            
                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label for="grade" class="form-label">학년</label>
                                    <select class="form-select" name="grade" id="grade">
                                        <option value="1" <%= user.getGrade() == 1 ? "selected" : "" %>>1학년</option>
                                        <option value="2" <%= user.getGrade() == 2 ? "selected" : "" %>>2학년</option>
                                        <option value="3" <%= user.getGrade() == 3 ? "selected" : "" %>>3학년</option>
                                        <option value="4" <%= user.getGrade() == 4 ? "selected" : "" %>>4학년</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="userGender" class="form-label">성별</label>
                                    <select class="form-select" name="userGender" id="userGender">
                                        <option value="남" <%= "남".equals(user.getUserGender()) ? "selected" : "" %>>남자</option>
                                        <option value="여" <%= "여".equals(user.getUserGender()) ? "selected" : "" %>>여자</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="skills" class="form-label">보유 기술 (쉼표로 구분)</label>
                                <input type="text" class="form-control" name="skills" id="skills" 
                                       value="<%= user.getSkills() == null ? "" : user.getSkills() %>">
                            </div>
                            
                            <div class="mb-3">
                                <label for="strengths" class="form-label">나의 강점 (줄바꿈으로 구분)</label>
                                <textarea class="form-control" name="strengths" id="strengths" rows="4"><%= user.getStrengths() == null ? "" : user.getStrengths() %></textarea>
                            </div>

                            <div class="row mt-4">
                                <div class="col d-grid">
                                    <a href="mypage.jsp" class="btn btn-secondary">취소</a>
                                </div>
                                <div class="col d-grid">
                                    <button type="submit" class="btn btn-primary">수정 완료</button>
                                </div>
                            </div>
                            
                        </form> 
                    </div> 
                </div> 
            </div> 
        </div> 
    </div> 
    
    <footer class="mt-auto">
        <jsp:include page="footer.jsp" />
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>