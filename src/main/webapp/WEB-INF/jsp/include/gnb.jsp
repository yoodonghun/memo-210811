<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
    
<div class="d-flex">
	<div class="lofo">
		<h2 class="text-white p-4 font-weight-bold">메모 게시판</h2>
	</div>
	<div class="login-info d-flex justify-content-end">
	    <c:if test="${not empty userName}">
			<div class="mt-5">
				<span class="text-white"><b>${userName}</b>님 안녕하세요</span>
				<a href="/user/sign_out_view" class="text-white ml-3">로그아웃</a>
			</div>
		</c:if>
	</div>
</div>