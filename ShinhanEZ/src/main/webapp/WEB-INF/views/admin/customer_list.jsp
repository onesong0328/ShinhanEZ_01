<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="inc/head.jsp"/>
</head>
<body class="admin-page">
<div class="admin-wrapper">

    <!-- 사이드바 -->
    <jsp:include page="inc/sidebar.jsp">
        <jsp:param name="menu" value="customer"/>
    </jsp:include>

    <!-- 메인 영역 -->
    <div class="admin-main">

        <!-- 헤더 -->
        <jsp:include page="inc/header.jsp">
            <jsp:param name="page" value="고객관리"/>
        </jsp:include>

        <!-- 콘텐츠 -->
        <main class="admin-content">

            <!-- 성공/에러 메시지 표시 -->
            <c:if test="${not empty message}">
                <div class="alert alert-success" style="padding:15px; margin-bottom:20px; background:#d4edda; border:1px solid #c3e6cb; border-radius:5px; color:#155724;">
                    <i class="bi bi-check-circle"></i> ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger" style="padding:15px; margin-bottom:20px; background:#f8d7da; border:1px solid #f5c6cb; border-radius:5px; color:#721c24;">
                    <i class="bi bi-exclamation-triangle"></i> ${error}
                </div>
            </c:if>

            <!-- 페이지 타이틀 -->
            <div class="page-header">
                <h2>고객 목록</h2>
                <p>등록된 고객(보험자) 정보를 관리합니다.</p>
            </div>

            <!-- 검색 및 정렬 영역 -->
            <div class="card" style="margin-bottom:20px;">
                <div class="card-body">
                    <form id="searchForm" method="get" action="${ctx}/admin/customer/list">
                        <div style="display:flex; gap:10px; align-items:center; flex-wrap:wrap;">
                            <!-- 정렬 -->
                            <select name="sortType" class="form-control" style="width:140px;" onchange="document.getElementById('searchForm').submit();">
                                <option value="latest" ${sortType == 'latest' ? 'selected' : ''}>최신순</option>
                                <option value="oldest" ${sortType == 'oldest' ? 'selected' : ''}>오래된순</option>
                                <option value="name" ${sortType == 'name' ? 'selected' : ''}>이름순</option>
                            </select>

                            <!-- 검색 조건 -->
                            <select name="searchType" class="form-control" style="width:120px;">
                                <option value="" ${empty searchType ? 'selected' : ''}>전체</option>
                                <option value="customerId" ${searchType == 'customerId' ? 'selected' : ''}>고객ID</option>
                                <option value="name" ${searchType == 'name' ? 'selected' : ''}>이름</option>
                                <option value="phone" ${searchType == 'phone' ? 'selected' : ''}>연락처</option>
                                <option value="email" ${searchType == 'email' ? 'selected' : ''}>이메일</option>
                            </select>

                            <!-- 검색어 -->
                            <input type="text" name="keyword" class="form-control" style="width:200px;"
                                   placeholder="검색어 입력" value="${keyword}">

                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-search"></i> 검색
                            </button>

                            <c:if test="${not empty keyword}">
                                <a href="${ctx}/admin/customer/list" class="btn btn-outline">
                                    <i class="bi bi-x-lg"></i> 초기화
                                </a>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>

            <!-- 고객 목록 카드 -->
            <div class="card">
                <div class="card-header">
                    <span><i class="bi bi-people"></i> 고객 목록 (총 <strong>${totalCount}</strong>명)</span>
                    <a href="${ctx}/admin/customer/register" class="btn btn-sm btn-primary">
                        <i class="bi bi-plus-lg"></i> 고객 등록
                    </a>
                </div>
                <div class="card-body" style="padding:0;">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th style="width:100px;">고객ID</th>
                                <th style="width:80px;">이름</th>
                                <th style="width:110px;">생년월일</th>
                                <th style="width:60px;">성별</th>
                                <th style="width:130px;">연락처</th>
                                <th>이메일</th>
                                <th style="width:110px;">등록일</th>
                                <th style="width:120px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="c" items="${customers}">
                            <tr>
                                <td><strong>${c.customerId}</strong></td>
                                <td>${c.name}</td>
                                <td><fmt:formatDate value="${c.birthDate}" pattern="yyyy-MM-dd"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${c.gender == 'M'}">
                                            <span class="badge badge-primary">남</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-danger">여</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${c.phone}</td>
                                <td>${c.email}</td>
                                <td><fmt:formatDate value="${c.regDate}" pattern="yyyy-MM-dd"/></td>
                                <td>
                                    <a href="${ctx}/admin/customer/view?id=${c.customerId}"
                                       class="btn btn-sm btn-outline" title="상세보기">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                    <a href="${ctx}/admin/customer/edit?id=${c.customerId}"
                                       class="btn btn-sm btn-outline" title="수정">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    <button type="button" class="btn btn-sm btn-outline-danger"
                                            onclick="deleteCustomer('${c.customerId}')" title="삭제">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty customers}">
                            <tr>
                                <td colspan="8" class="text-center" style="padding:40px;">
                                    <i class="bi bi-inbox" style="font-size:48px;color:#ccc;"></i>
                                    <p style="margin-top:10px;color:#999;">등록된 고객이 없습니다.</p>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <!-- 페이징 -->
                <c:if test="${totalPages > 0}">
                <div class="card-footer" style="display:flex; justify-content:center; padding:20px;">
                    <nav class="pagination">
                        <!-- 이전 블록 -->
                        <c:if test="${startPage > 1}">
                            <a href="${ctx}/admin/customer/list?page=${startPage - 1}&searchType=${searchType}&keyword=${keyword}&sortType=${sortType}"
                               class="page-link">&laquo;</a>
                        </c:if>

                        <!-- 페이지 번호 -->
                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="page-link active">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${ctx}/admin/customer/list?page=${i}&searchType=${searchType}&keyword=${keyword}&sortType=${sortType}"
                                       class="page-link">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <!-- 다음 블록 -->
                        <c:if test="${endPage < totalPages}">
                            <a href="${ctx}/admin/customer/list?page=${endPage + 1}&searchType=${searchType}&keyword=${keyword}&sortType=${sortType}"
                               class="page-link">&raquo;</a>
                        </c:if>
                    </nav>
                </div>
                </c:if>
            </div>

        </main>

        <!-- 푸터 -->
        <jsp:include page="inc/footer.jsp"/>

    </div>
</div>

<script>
    var contextPath = '${pageContext.request.contextPath}';

    function deleteCustomer(id) {
        if(confirm('정말 삭제하시겠습니까?\n고객ID: ' + id)) {
            location.href = contextPath + '/admin/customer/delete?id=' + id;
        }
    }
</script>
</body>
</html>
