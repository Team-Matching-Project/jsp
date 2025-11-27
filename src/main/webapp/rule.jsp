<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용방법 안내</title>
</head>
<body>
	<div class="card">
		<div class="card-header fs-5 fw-semibold">
			<fmt:message key="webRule"/>
		</div>
		<ul class="list-group list-group-flush">
			<li class="list-group-item list-group-item-action">
				<strong><fmt:message key="clearInformation" /></strong>
				<p><fmt:message key="rule1" /></p>
			</li>
			<li class="list-group-item list-group-item-action">
				<strong><fmt:message key="realApply" /></strong>
				<p><fmt:message key="rule2" /></p>
			</li>
			<li class="list-group-item list-group-item-action">
				<strong><fmt:message key="quickResponse" /></strong>
				<p><fmt:message key="rule3" /></p>
			</li>
			<li class="list-group-item list-group-item-action">
				<strong><fmt:message key="updateInformation" /></strong>
				<p><fmt:message key="rule3" /></p>
			</li>
		</ul>
	</div>

</body>
</html>