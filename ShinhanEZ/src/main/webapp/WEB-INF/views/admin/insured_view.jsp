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
        <jsp:include page="inc/header.jsp"><jsp:param name="page" value="피보험자상세"/></jsp:include>
        <main class="admin-content">
            <div class="page-header">
                <h2>피보험자 상세정보</h2>
                <p>피보험자 ID: <strong>${insured.insuredId}</strong></p>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <span><i class="bi bi-person-badge"></i> 기본정보</span>
                    <div>
                        <a href="${ctx}/admin/insured/edit?id=${insured.insuredId}" class="btn btn-sm btn-primary"><i class="bi bi-pencil"></i> 수정</a>
                        <button type="button" class="btn btn-sm btn-danger" onclick="deleteInsured()"><i class="bi bi-trash"></i> 삭제</button>
                    </div>
                </div>
                <div class="card-body">
                    <table class="detail-table">
                        <tr>
                            <th>피보험자 ID</th>
                            <td>${insured.insuredId}</td>
                            <th>가입고객</th>
                            <td>${insured.customerName} (${insured.customerId})</td>
                        </tr>
                        <tr>
                            <th>피보험자명</th>
                            <td>${insured.name}</td>
                            <th>관계</th>
                            <td><span class="badge badge-info">${insured.relation}</span></td>
                        </tr>
                        <tr>
                            <th>생년월일</th>
                            <td><fmt:formatDate value="${insured.birthDate}" pattern="yyyy-MM-dd"/></td>
                            <th>성별</th>
                            <td>
                                <c:choose>
                                    <c:when test="${insured.gender == 'M'}"><span class="badge badge-primary">남성</span></c:when>
                                    <c:otherwise><span class="badge badge-danger">여성</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>연락처</th>
                            <td>${insured.phone}</td>
                            <th>등록일</th>
                            <td><fmt:formatDate value="${insured.regDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                        </tr>
                    </table>
                </div>
            </div>
            
            <div style="margin-top:20px;text-align:center;">
                <a href="${ctx}/admin/insured/list" class="btn btn-outline"><i class="bi bi-list"></i> 목록으로</a>
            </div>
        </main>
        <jsp:include page="inc/footer.jsp"/>
    </div>
</div>
<script>
    function deleteInsured() {
        if(confirm('정말 삭제하시겠습니까?\n피보험자: ${insured.name}')) {
            location.href = '${ctx}/admin/insured/delete?id=${insured.insuredId}';
        }
    }
</script>
</body>
</html>
