<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

<style>
	body {
		background-color: #f8f9fa;
	}
</style>
</head>
<body>
	
	<div class="container">
		<div class="row justify-content-center mt-5">
			
			<div class="col-md-6 col-lg-4">
				
				<div class="card shadow-sm">
					<div class="card-body p-4">
						
						<h3 class="card-title text-center mb-4">로그인</h3>
						
						<form action="loginAction.jsp" method="post">
							<div class="mb-3">
								<label class="form-label" for="id">아이디 </label>
								<input class="form-control" type="text" name="id" id="id" required/>
							</div>
							<div class="mb-3">
								<label class="form-label" for="password">비밀번호</label>
								<input class="form-control" type="password" name="password" id="password" required/>
							</div>
							
							<div class="d-grid mt-4">
								<button type="submit" class="btn btn-primary">로그인</button>
							</div>

							<div class="text-center mt-3">
								<a href="signup.jsp">아직 회원이 아니신가요?</a>
							</div>
						</form>
						
					</div> </div> </div> </div> </div> <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
</body>
</html>