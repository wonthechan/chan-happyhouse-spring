<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<nav class="navbar navbar-expand-sm bg-primary navbar-dark justify-content-end">
  
<ul class="navbar-nav">
 <li class="nav-item">

 <c:if test="${name eq '홍길동'}">

    <c:out value="${str}" />

</c:if>


<c:if test="${not empty userDto}">
      <a class="nav-link" href="/store">관심지역 상권정보</a>
</c:if>
<c:if test="${empty userDto}">
 	 <a class="nav-link disabled" href="/store">관심지역 상권정보</a>
</c:if>

  </li>

 

 <li class="nav-item">
    
<c:if test="${not empty userDto}"> 
      <a class="nav-link" href="/interest-area/register">관심지역 관리하기</a>
</c:if>
<c:if test="${empty userDto}">
 	 <a class="nav-link disabled" href="/interest-area/register">관심지역 관리하기</a>
</c:if>

  </li>
  


<li class="nav-item">
  
<c:if test="${not empty userDto}"> 
      <a class="nav-link" href="/qna">QnA</a>
</c:if>
<c:if test="${empty userDto}">
 	 <a class="nav-link disabled" href="/qna">QnA</a>
</c:if> 
</li>

 
 
  </ul>
</nav>
 </body>
 </html>
 