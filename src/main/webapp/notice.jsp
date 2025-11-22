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
					<th>번호</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>작성날짜</th>
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
							<td>관리자</td>
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