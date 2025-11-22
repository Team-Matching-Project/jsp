<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row g-3">
    <div class="col-md-6">
        <div class="card h-100 shadow-sm">
            <div class="card-body">
                <h5 class="card-title text-center text-primary">학과별 프로젝트</h5>
                <hr>
                <ul class="list-group list-group-flush">
                    <c:forEach var="stat" items="${stats}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            ${stat.department}
                            <span class="badge bg-primary rounded-pill">${stat.number}개</span>
                        </li>
                    </c:forEach>
                    <c:if test="${empty stats}">
                        <li class="list-group-item text-center text-muted">데이터가 없습니다.</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>

    <div class="col-md-6">
        <div class="card h-100 shadow-sm">
            <div class="card-body">
                <h5 class="card-title text-center text-danger">마감 임박 (3일 이내)</h5>
                <hr>
                <ul class="list-group list-group-flush">
                    <c:forEach var="stat" items="${deadlineStats}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            ${stat.department}
                            <span class="badge bg-danger rounded-pill">${stat.number}개</span>
                        </li>
                    </c:forEach>
                    <c:if test="${empty deadlineStats}">
                        <li class="list-group-item text-center text-muted">마감 임박한 프로젝트가 없습니다.</li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>