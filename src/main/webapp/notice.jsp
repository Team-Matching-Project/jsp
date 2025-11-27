<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
		<div class="container">
			<table class="table">
				<thead>
					<th><fmt:message key="number" /></th>
					<th><fmt:message key="title" /></th>
					<th><fmt:message key="writer" /></th>
					<th><fmt:message key="creationDate" /></th>
				</thead>
				<tbody>
					<c:forEach var="notice" items="${noticeList}"
					varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td>
								<a href="./notice_review.jsp?id=${notice.id}">
									${notice.noticeTitle}
								</a>
							</td>
							<td><fmt:message key="admin" /></td>
							<td>${notice.createdAt}</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<td colspan="5"></td>
				</tfoot>
			</table>
		</div>

</body>
</html>