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
        <jsp:include page="inc/header.jsp"><jsp:param name="page" value="피보험자수정"/></jsp:include>
        <main class="admin-content">
            <div class="page-header">
                <h2>피보험자 수정</h2>
                <p>피보험자 ID: <strong>${insured.insuredId}</strong></p>
            </div>
            
            <form action="${ctx}/admin/insured/edit" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="insuredId" value="${insured.insuredId}">
            <div class="card">
                <div class="card-header"><span><i class="bi bi-pencil"></i> 피보험자 정보 수정</span></div>
                <div class="card-body">
                    <table class="form-table">
                        <tr>
                            <th><span class="required">*</span> 가입고객</th>
                            <td>
                                <select name="customerId" id="customerId" class="form-control" required>
                                    <c:forEach var="c" items="${customers}">
                                        <option value="${c.customerId}" ${c.customerId == insured.customerId ? 'selected' : ''}>${c.name} (${c.customerId})</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="required">*</span> 피보험자명</th>
                            <td><input type="text" name="name" id="name" class="form-control" value="${insured.name}" required></td>
                        </tr>
                        <tr>
                            <th><span class="required">*</span> 관계</th>
                            <td>
                                <select name="relation" id="relation" class="form-control" required>
                                    <option value="본인" ${insured.relation == '본인' ? 'selected' : ''}>본인</option>
                                    <option value="배우자" ${insured.relation == '배우자' ? 'selected' : ''}>배우자</option>
                                    <option value="자녀" ${insured.relation == '자녀' ? 'selected' : ''}>자녀</option>
                                    <option value="부모" ${insured.relation == '부모' ? 'selected' : ''}>부모</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="required">*</span> 생년월일</th>
                            <td><input type="date" name="birthDate" id="birthDate" class="form-control" 
                                value="<fmt:formatDate value='${insured.birthDate}' pattern='yyyy-MM-dd'/>" required></td>
                        </tr>
                        <tr>
                            <th><span class="required">*</span> 성별</th>
                            <td>
                                <label class="radio-inline"><input type="radio" name="gender" value="M" ${insured.gender == 'M' ? 'checked' : ''} required> 남성</label>
                                <label class="radio-inline"><input type="radio" name="gender" value="F" ${insured.gender == 'F' ? 'checked' : ''}> 여성</label>
                            </td>
                        </tr>
                        <tr>
                            <th>연락처</th>
                            <td><input type="text" name="phone" id="phone" class="form-control" value="${insured.phone}" placeholder="010-0000-0000"></td>
                        </tr>
                    </table>
                </div>
            </div>
            
            <div style="margin-top:20px;text-align:center;">
                <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> 저장</button>
                <a href="${ctx}/admin/insured/view?id=${insured.insuredId}" class="btn btn-outline">취소</a>
            </div>
            </form>
        </main>
        <jsp:include page="inc/footer.jsp"/>
    </div>
</div>
<script>
    function validateForm() {
        if(!document.getElementById('name').value.trim()) { alert('피보험자명을 입력해주세요.'); return false; }
        if(!document.getElementById('birthDate').value) { alert('생년월일을 입력해주세요.'); return false; }
        return true;
    }
</script>
</body>
</html>
