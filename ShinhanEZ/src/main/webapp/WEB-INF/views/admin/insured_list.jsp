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
    <jsp:include page="inc/sidebar.jsp"><jsp:param name="menu" value="insured"/></jsp:include>
    <div class="admin-main">
        <jsp:include page="inc/header.jsp"><jsp:param name="page" value="피보험자관리"/></jsp:include>
        <main class="admin-content">
            <div class="page-header">
                <h2>피보험자 목록</h2>
                <p>등록된 피보험자 정보를 관리합니다.</p>
            </div>
            
            <!-- 검색 + 정렬 -->
            <div class="card" style="margin-bottom:20px;">
                <div class="card-body">
                    <form action="${ctx}/admin/insured/list" method="get" style="display:flex;gap:10px;align-items:center;flex-wrap:wrap;">
                        <select name="sort" class="form-control" style="width:130px;">
                            <option value="latest" ${sort == 'latest' ? 'selected' : ''}>최신순</option>
                            <option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>오래된순</option>
                            <option value="name" ${sort == 'name' ? 'selected' : ''}>이름순</option>
                        </select>
                        <input type="text" name="keyword" class="form-control" style="width:250px;" 
                               placeholder="피보험자명, 가입고객명, 연락처 검색" value="${keyword}">
                        <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> 검색</button>
                        <c:if test="${not empty keyword}">
                            <a href="${ctx}/admin/insured/list" class="btn btn-outline">초기화</a>
                        </c:if>
                    </form>
                </div>
            </div>

            <!-- 목록 -->
            <div class="card">
                <div class="card-header">
                    <span><i class="bi bi-person-badge"></i> 피보험자 목록 (총 <strong>${totalCount}</strong>명)</span>
                    <a href="${ctx}/admin/insured/register" class="btn btn-sm btn-primary">
                        <i class="bi bi-plus-lg"></i> 피보험자 등록
                    </a>
                </div>
                <div class="card-body" style="padding:0;">
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th style="width:80px;">피보험자ID</th>
                                <th style="width:100px;">가입고객명</th>
                                <th style="width:100px;">피보험자명</th>
                                <th style="width:80px;">관계</th>
                                <th style="width:110px;">생년월일</th>
                                <th style="width:60px;">성별</th>
                                <th style="width:130px;">연락처</th>
                                <th style="width:110px;">등록일</th>
                                <th style="width:120px;">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="i" items="${insuredList}">
                            <tr>
                                <td><strong>${i.insuredId}</strong></td>
                                <td>${i.customerName}</td>
                                <td>${i.name}</td>
                                <td><span class="badge badge-info">${i.relation}</span></td>
                                <td><fmt:formatDate value="${i.birthDate}" pattern="yyyy-MM-dd"/></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${i.gender == 'M'}"><span class="badge badge-primary">남</span></c:when>
                                        <c:otherwise><span class="badge badge-danger">여</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${i.phone}</td>
                                <td><fmt:formatDate value="${i.regDate}" pattern="yyyy-MM-dd"/></td>
                                <td>
                                    <a href="${ctx}/admin/insured/view?id=${i.insuredId}" class="btn btn-sm btn-outline" title="상세"><i class="bi bi-eye"></i></a>
                                    <a href="${ctx}/admin/insured/edit?id=${i.insuredId}" class="btn btn-sm btn-outline" title="수정"><i class="bi bi-pencil"></i></a>
                                    <button type="button" class="btn btn-sm btn-outline-danger" onclick="deleteInsured('${i.insuredId}')" title="삭제"><i class="bi bi-trash"></i></button>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty insuredList}">
                            <tr>
                                <td colspan="9" class="text-center" style="padding:40px;">
                                    <i class="bi bi-inbox" style="font-size:48px;color:#ccc;"></i>
                                    <p style="margin-top:10px;color:#999;">등록된 피보험자가 없습니다.</p>
                                </td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
                
                <!-- 페이징 -->
                <c:if test="${totalPages > 1}">
                <div class="card-footer" style="display:flex;justify-content:center;padding:20px;">
                    <nav class="pagination">
                        <c:if test="${startPage > 1}">
                            <a href="${ctx}/admin/insured/list?page=${startPage - 1}&size=${size}&sort=${sort}&keyword=${keyword}" class="page-link">&laquo;</a>
                        </c:if>
                        <c:forEach begin="${startPage}" end="${endPage}" var="p">
                            <c:choose>
                                <c:when test="${p == currentPage}"><span class="page-link active">${p}</span></c:when>
                                <c:otherwise><a href="${ctx}/admin/insured/list?page=${p}&size=${size}&sort=${sort}&keyword=${keyword}" class="page-link">${p}</a></c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${endPage < totalPages}">
                            <a href="${ctx}/admin/insured/list?page=${endPage + 1}&size=${size}&sort=${sort}&keyword=${keyword}" class="page-link">&raquo;</a>
                        </c:if>
                    </nav>
                </div>
                </c:if>
            </div>
        </main>
        <jsp:include page="inc/footer.jsp"/>
    </div>
</div>
<script>
    function deleteInsured(id) {
        if(confirm('정말 삭제하시겠습니까?\n피보험자ID: ' + id)) {
            location.href = '${ctx}/admin/insured/delete?id=' + id;
        }
    }
</script>
</body>
</html>
