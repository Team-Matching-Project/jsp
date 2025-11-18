<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
  TODO:
  페이지 로드 시, DB에서 현재 사용자 정보를 조회(SELECT)해서
  각 <input>과 <textarea>의 value="" 안에 ${dto.name} 등으로
  기존 데이터를 미리 채워줘야 합니다.
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보수정</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<style>
	body {
		background-color: #f8f9fa;
	}
</style>
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
								<label for="name" class="form-label">이름</label>
								<input type="text" class="form-control" id="name" name="name" value="${dto.name}" readonly>
							</div>
							
							<div class="row g-3 mb-3">
								<div class="col-md-6">
									<label for="password" class="form-label">새 비밀번호</label>
									<input type="password" class="form-control" name="password" id="password" placeholder="변경할 경우에만 입력">
								</div>
								<div class="col-md-6">
									<label for="passwordConfirm" class="form-label">새 비밀번호 확인</label>
									<input type="password" class="form-control" name="passwordConfirm" id="passwordConfirm">
								</div>
							</div>

							<div class="row g-3 mb-3">
								<div class="col-md-6">
									<label for="birthDate" class="form-label">생년월일</label>
									<input type="date" class="form-control" name="birthDate" id="birthDate" value="${dto.birthDate}">
								</div>
								<div class="col-md-6">
									<label for="department" class="form-label">학과</label>
									<input type="text" class="form-control" name="department" id="department" value="${dto.department}">
								</div>
							</div>
							
							<div class="row g-3 mb-3">
								<div class="col-md-6">
									<label for="grade" class="form-label">학년</label>
									<select class="form-select" name="grade" id="grade">
										<option value="1" ${dto.grade == 1 ? 'selected' : ''}>1학년</option>
										<option value="2" ${dto.grade == 2 ? 'selected' : ''}>2학년</option>
										<option value="3" ${dto.grade == 3 ? 'selected' : ''}>3학년</option>
										<option value="4" ${dto.grade == 4 ? 'selected' : ''}>4학년</option>
									</select>
								</div>
								<div class="col-md-6">
									<label for="gender" class="form-label">성별</label>
									<select class="form-select" name="gender" id="gender">
										<option value="남" ${dto.gender == '남' ? 'selected' : ''}>남자</option>
										<option value="여" ${dto.gender == '여' ? 'selected' : ''}>여자</option>
									</select>
								</div>
							</div>
							
							<div class="mb-3">
								<label for="skills" class="form-label">보유 기술 (쉼표로 구분)</label>
								<input type="text" class="form-control" name="skills" id="skills" value="${dto.skills}" placeholder="예: Java, JSP, PPT, Excel">
							</div>
							
							<div class="mb-3">
								<label for="strengths" class="form-label">나의 강점 (줄바꿈으로 구분)</label>
								<textarea class="form-control" name="strengths" id="strengths" rows="4" placeholder="예: 끈기 있게 문제를 해결합니다.">${dto.strengths}</textarea>
							</div>

							<div class="row mt-4">
								<div class="col d-grid">
									<a href="mypage.jsp" class="btn btn-secondary">취소</a>
								</div>
								<div class="col d-grid">
									<button type="submit" class="btn btn-primary">수정 완료</button>
								</div>
							</div>
							
						</form> </div> </div> </div> </div> </div> <footer class="mt-auto">
		<jsp:include page="footer.jsp" />
	</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>