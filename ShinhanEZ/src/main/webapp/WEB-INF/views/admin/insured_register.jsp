<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <jsp:include page="inc/header.jsp"><jsp:param name="page" value="피보험자등록"/></jsp:include>
        <main class="admin-content">
            <div class="page-header">
                <h2>피보험자 등록</h2>
                <p>새 피보험자 정보를 입력합니다.</p>
            </div>
            
            <form action="${ctx}/admin/insured/register" method="post" onsubmit="return validateForm()">
            <div class="card">
                <div class="card-header"><span><i class="bi bi-person-plus"></i> 피보험자 정보 입력</span></div>
                <div class="card-body">
                    <table class="form-table">
                        <tr>
                            <th><span class="required">*</span> 가입고객</th>
                            <td>
                                <select name="customerId" id="customerId" class="form-control" required>
                                    <option value="">-- 가입고객 선택 --</option>
                                    <c:forEach var="c" items="${customers}">
                                        <option value="${c.customerId}">${c.name} (${c.customerId})</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="required">*</span> 피보험자명</th>
                            <td><input type="text" name="name" id="name" class="form-control" required></td>
                        </tr>
                        <tr>
                            <th><span class="required">*</span> 관계</th>
                            <td>
                                <select name="relation" id="relation" class="form-control" required>
                                    <option value="">-- 관계 선택 --</option>
                                    <option value="본인">본인</option>
                                    <option value="배우자">배우자</option>
                                    <option value="자녀">자녀</option>
                                    <option value="부모">부모</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="required">*</span> 생년월일</th>
                            <td><input type="date" name="birthDate" id="birthDate" class="form-control" required></td>
                        </tr>
                        <tr>
                            <th><span class="required">*</span> 성별</th>
                            <td>
                                <label class="radio-inline"><input type="radio" name="gender" value="M" required> 남성</label>
                                <label class="radio-inline"><input type="radio" name="gender" value="F"> 여성</label>
                            </td>
                        </tr>
                        <tr>
                            <th>연락처</th>
                            <td><input type="text" name="phone" id="phone" class="form-control" placeholder="010-0000-0000"></td>
                        </tr>
                    </table>
                </div>
            </div>
            
            <div style="margin-top:20px;text-align:center;">
                <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg"></i> 등록</button>
                <a href="${ctx}/admin/insured/list" class="btn btn-outline">취소</a>
            </div>
            </form>
        </main>
        <jsp:include page="inc/footer.jsp"/>
    </div>
</div>
<script>
    function validateForm() {
        if(!document.getElementById('customerId').value) { alert('가입고객을 선택해주세요.'); return false; }
        if(!document.getElementById('name').value.trim()) { alert('피보험자명을 입력해주세요.'); return false; }
        if(!document.getElementById('relation').value) { alert('관계를 선택해주세요.'); return false; }
        if(!document.getElementById('birthDate').value) { alert('생년월일을 입력해주세요.'); return false; }
        return true;
    }
</script>
</body>
</html>
