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

<%-- paging --%>

<div class="container-sm">

  <ul class="pagination">
  
  	<c:choose>
  	<c:when test ="${pageNo == first }">
  	 <li class="page-item disabled"><a class="page-link" href="#">≪</a></li>
  	</c:when>
  	<c:when test ="${pageNo != first }">
  	<button class="btn btn-light" onclick="search(${first},'prepre','${order}')">≪</button> 
  	</c:when>
  	</c:choose>
  	
  	
  	<c:choose>
  	<c:when test ="${pageNo == first }">
  	 <li class="page-item disabled"><a class="page-link" href="#">＜</a></li>
  	</c:when>
  	<c:when test ="${pageNo != first }">
  	<button class="btn btn-light" onclick="search(${pageNo-1},'pre','${order}'">＜</button> 
  	</c:when>
  	</c:choose>
 
  	<c:forEach var="page" items="${pageIndex }">
  	<c:choose>
  	<c:when test ="${page != pageNo}">
  	<button class="btn btn-light" onclick="search(${page},null,'${order}')">${page}</button> 
  	</c:when>
  	<c:otherwise>
  	<li class="page-item active"><a class="page-link" href="#">${page}</a></li>
  	</c:otherwise>
  	</c:choose>
    </c:forEach>
   
	<c:choose>
  	<c:when test ="${pageNo == last }">
  	 <li class="page-item disabled"><a class="page-link" href="#">＞</a></li>
  	</c:when>
  	<c:when test ="${pageNo != last }">
  	<button class="btn btn-light" onclick="search(${pageNo+1},'next','${order}')">＞</button> 
  	</c:when>
  	</c:choose>
  	
  	<c:choose>
  	<c:when test ="${pageNo == last }">
  	 <li class="page-item disabled"><a class="page-link" href="#">≫</a></li>
  	</c:when>
  	<c:when test ="${pageNo != last }">
  	<button class="btn btn-light" onclick="search(${last},'nextnext','${order}')">≫</button> 
  	</c:when>
  	</c:choose>
  	
  </ul>

</div>

 

</body>
</html>
 