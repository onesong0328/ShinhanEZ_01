<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <jsp:include page="inc/head.jsp"/>
    <style>
        .id-check-area { display: flex; gap: 10px; }
        .id-check-area input { flex: 1; }
        .id-message { font-size: 12px; margin-top: 5px; }
        .id-message.success { color: #28a745; }
        .id-message.error { color: #dc3545; }
    </style>
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
            <jsp:param name="page" value="고객 등록"/>
        </jsp:include>

        <!-- 콘텐츠 -->
        <main class="admin-content">

            <!-- 페이지 타이틀 -->
            <div class="page-header">
                <h2>고객 등록</h2>
                <p>새로운 고객(보험자) 정보를 등록합니다.</p>
            </div>

            <!-- 에러 메시지 -->
            <c:if test="${not empty error}">
            <div class="alert alert-danger" style="margin-bottom:20px; padding:15px; background:#f8d7da; border:1px solid #f5c6cb; border-radius:5px; color:#721c24;">
                <i class="bi bi-exclamation-circle"></i> ${error}
            </div>
            </c:if>

            <!-- 등록 폼 카드 -->
            <div class="card">
                <div class="card-header">
                    <span><i class="bi bi-person-plus"></i> 고객 정보 입력</span>
                </div>
                <div class="card-body">
                    <form id="registerForm" action="${ctx}/admin/customer/register" method="post" class="admin-form">

                        <div class="form-row">
                            <div class="form-group">
                                <label>고객 ID <span class="required">*</span></label>
                                <div class="id-check-area">
                                    <input type="text" name="customerId" id="customerId"
                                           value="${customer.customerId}" class="form-control"
                                           placeholder="영문, 숫자 조합 4~20자" required
                                           pattern="^[a-zA-Z0-9]{4,20}$">
                                    <button type="button" class="btn btn-outline" onclick="checkCustomerId()">
                                        중복확인
                                    </button>
                                </div>
                                <div id="idMessage" class="id-message"></div>
                            </div>
                            <div class="form-group">
                                <label>이름 <span class="required">*</span></label>
                                <input type="text" name="name" value="${customer.name}"
                                       class="form-control" placeholder="이름 입력" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>비밀번호 <span class="required">*</span></label>
                                <input type="password" name="password" id="password"
                                       class="form-control" placeholder="비밀번호 입력" required>
                            </div>
                            <div class="form-group">
                                <label>비밀번호 확인 <span class="required">*</span></label>
                                <input type="password" id="passwordConfirm"
                                       class="form-control" placeholder="비밀번호 재입력" required>
                                <div id="pwMessage" class="id-message"></div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>생년월일 <span class="required">*</span></label>
                                <input type="date" name="birthDate"
                                       value="${customer.birthDate}"
                                       class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>성별 <span class="required">*</span></label>
                                <div class="radio-group">
                                    <label class="radio-label">
                                        <input type="radio" name="gender" value="M"
                                               <c:if test="${customer.gender == 'M' or empty customer.gender}">checked</c:if>>
                                        <span>남성</span>
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="gender" value="F"
                                               <c:if test="${customer.gender == 'F'}">checked</c:if>>
                                        <span>여성</span>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label>연락처 <span class="required">*</span></label>
                                <input type="text" name="phone" value="${customer.phone}"
                                       class="form-control" placeholder="010-0000-0000" required>
                            </div>
                            <div class="form-group">
                                <label>이메일</label>
                                <input type="email" name="email" value="${customer.email}"
                                       class="form-control" placeholder="email@example.com">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group full">
                                <label>주소</label>
                                <input type="text" name="address" value="${customer.address}"
                                       class="form-control" placeholder="주소를 입력하세요">
                            </div>
                        </div>

                        <!-- 버튼 영역 -->
                        <div class="btn-area">
                            <a href="${ctx}/admin/customer/list" class="btn btn-outline">
                                <i class="bi bi-x-lg"></i> 취소
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="bi bi-check-lg"></i> 등록하기
                            </button>
                        </div>

                    </form>
                </div>
            </div>

        </main>

        <!-- 푸터 -->
        <jsp:include page="inc/footer.jsp"/>

    </div>
</div>

<script>
    var isIdChecked = false;

    // 고객ID 중복 체크
    function checkCustomerId() {
        var customerId = document.getElementById('customerId').value.trim();
        var msgDiv = document.getElementById('idMessage');

        if(!customerId) {
            msgDiv.className = 'id-message error';
            msgDiv.textContent = '고객ID를 입력하세요.';
            return;
        }

        // 형식 체크
        var pattern = /^[a-zA-Z0-9]{4,20}$/;
        if(!pattern.test(customerId)) {
            msgDiv.className = 'id-message error';
            msgDiv.textContent = '영문, 숫자 조합 4~20자로 입력하세요.';
            return;
        }

        // AJAX 중복 체크
        var xhr = new XMLHttpRequest();
        xhr.open('GET', '${ctx}/admin/customer/checkId?customerId=' + encodeURIComponent(customerId), true);
        xhr.onreadystatechange = function() {
            if(xhr.readyState === 4 && xhr.status === 200) {
                var result = JSON.parse(xhr.responseText);
                if(result.exists) {
                    msgDiv.className = 'id-message error';
                    msgDiv.textContent = result.message;
                    isIdChecked = false;
                } else {
                    msgDiv.className = 'id-message success';
                    msgDiv.textContent = result.message;
                    isIdChecked = true;
                }
            }
        };
        xhr.send();
    }

    // 고객ID 변경 시 체크 상태 초기화
    document.getElementById('customerId').addEventListener('input', function() {
        isIdChecked = false;
        document.getElementById('idMessage').textContent = '';
    });

    // 비밀번호 확인
    document.getElementById('passwordConfirm').addEventListener('input', function() {
        var pw = document.getElementById('password').value;
        var pwConfirm = this.value;
        var msgDiv = document.getElementById('pwMessage');

        if(pw && pwConfirm) {
            if(pw === pwConfirm) {
                msgDiv.className = 'id-message success';
                msgDiv.textContent = '비밀번호가 일치합니다.';
            } else {
                msgDiv.className = 'id-message error';
                msgDiv.textContent = '비밀번호가 일치하지 않습니다.';
            }
        } else {
            msgDiv.textContent = '';
        }
    });

    // 폼 제출 검증
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        var pw = document.getElementById('password').value;
        var pwConfirm = document.getElementById('passwordConfirm').value;

        if(!isIdChecked) {
            alert('고객ID 중복확인을 해주세요.');
            e.preventDefault();
            return false;
        }

        if(pw !== pwConfirm) {
            alert('비밀번호가 일치하지 않습니다.');
            e.preventDefault();
            return false;
        }

        return true;
    });
</script>
</body>
</html>
