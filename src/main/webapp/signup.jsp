<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
<style>
	body {
		background-color: #f8f9fa;
	}
</style>
</head>
<body>
	
	<div class="container">
		<div class="row justify-content-center mt-5 mb-5">
			
			<div class="col-lg-6 col-md-8">
				
				<div class="card shadow-sm">
					<div class="card-body p-4">
						
						<h3 class="card-title text-center mb-4">회원가입</h3>
						
						<form action="./signUpAction.jsp" method="post">
							
							<div class="input-group mb-3">
								<span class="input-group-text" style="min-width: 120px;">아이디</span>
								<input type="text" class="form-control" name="userId" id="userId" placeholder="최소 6자리" required>
								<button class="btn btn-outline-secondary" type="button" id="btnIdCheck">중복확인</button>
							</div>
							
							<div class="input-group mb-3">
								<span class="input-group-text" style="min-width: 120px;">이름</span>
								<input type="text" class="form-control" name="userName" id="userName" required>
							</div>
							
							<div class="input-group mb-3">
								<span class="input-group-text" style="min-width: 120px;">비밀번호</span>
								<input type="password" class="form-control" name="userPassword" id="userPassword" placeholder="영문자, 숫자 섞어서 12자리 이상" required>
							</div>
							
							<div class="input-group mb-3">
								<span class="input-group-text" style="min-width: 120px;">비밀번호 확인</span>
								<input type="password" class="form-control" name="passwordConfirm" id="passwordConfirm" required>
							</div>
							
							
							<div class="input-group mb-3">
								<span class="input-group-text" style="min-width: 120px;">생년월일</span>
								<input type="date" class="form-control" name="birthDate" id="birthDate" required>
							</div>
							
							<div class="input-group mb-3">
								<span class="input-group-text" style="min-width: 120px;">학과</span>
								<input type="text" class="form-control" name="department" id="department" required>
							</div>
							
							<div class="input-group mb-3">
								<span class="input-group-text" style="min-width: 120px;">학년</span>
								<select class="form-select" name="grade" id="grade">
									<option value="1">1학년</option>
									<option value="2">2학년</option>
									<option value="3">3학년</option>
									<option value="4">4학년</option>
								</select>
							</div>
							
							<div class="input-group mb-3">
								<span class="input-group-text" style="min-width: 120px;">성별</span>
								<select class="form-select" name="gender" id="gender">
									<option value="남">남자</option>
									<option value="여">여자</option>
								</select>
							</div>

							<div class="d-grid mt-4">
								<button type="submit" class="btn btn-primary">회원가입</button>
							</div>
							
							<div class="text-center mt-3">
								<a href="login.jsp">이미 계정이 있으신가요?</a>
							</div>
							
						</form> </div> </div> </div> </div> </div> <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
						<script type="module" src="./resources/js/join.js"></script>
</body>
</html>