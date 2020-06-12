<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>login success</title>
</head>
<body>

<form method = "post" id = "userForm" action="">
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" href="/users/logout">로그아웃</a>
    </li>
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
       ${userDto.uname} 님
      </a>
      <c:if test="${null ne userDto.upassword }">
      <div class="dropdown-menu">
        <a class="dropdown-item" href="/users/mypage">마이페이지</a>
        <a class="dropdown-item" href="#">회원검색</a>
      </div>
      </c:if>
    </li>
    
    <li class="nav-item">
      <a class="nav-link" href="/">메인</a>
    </li>
  </ul>
 	
    
</nav>
</form>
</body>
</html>