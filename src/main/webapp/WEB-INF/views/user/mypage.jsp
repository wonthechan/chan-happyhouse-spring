<%@page import="com.ssafy.happyhouse.dto.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%
UserDto user = (UserDto)session.getAttribute("userDto");
%>

<style type="text/css">
h4  {
	text-align: center;
}

#updateadd {
	width: 500px;
}

.phone{
	width: 60px;	
}

button {
	align-content: center;
	align-items: center;
	align-self: center;
}



</style>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/alertify.min.js"></script>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/alertify.min.css"/>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/themes/default.min.css"/>

<title>마이 페이지</title>
</head>
<body>
<jsp:include page="loginsuccess.jsp" />
<c:if test="${msg != null }">
<h1>${msg }</h1>\
</c:if>

<c:if test="${msg == null }">
<div class="container"><br>
  <h2 align="center"> <%= user.getUid() %>(<%= user.getUname() %>)님의 회원정보</h2>
  <br>
  <table class="table">
    <thead class="thead-dark" align="center">
      <tr>
        <th>항목</th>
        <th>정보</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>아이디</td>
        <td>
        <input id="uid" value=<%= user.getUid() %> readonly>
		</td>
      </tr>
      <tr>
        <td>현재비밀번호</td>
        <td>
        <input style="white-space: nowrap;" type="password" name="upassword"  id="upassword" required="required" >
        <c:if test="${not empty pwdmsg}">
        	<p style="color: red"> <%= request.getAttribute("pwdmsg") %> </p>
		</c:if>
		</td>
      </tr>
      <tr>
        <td>이름</td>
        <td>
        <input id="uname" value=<%= user.getUname() %> >
		</td>
      </tr>
      <tr>
        <td>주소</td>
        <td>
        <input type="text" name="uaddress"  id="uaddress" value=<%= user.getUaddress() %>>
		</td>
      </tr>
      <tr>
        <td>연락처</td>
        <td>
        <input type="number" name="uphone1"  id="updatephone1"  class="phone" MAXLENGTH="3" required="required" tabindex="1" value=<%= user.getUphone().substring(0, 3) %>> -
        <input type="number" name="uphone2"  id="updatephone2"  class="phone" MAXLENGTH="4" required="required" tabindex="2" value=<%= user.getUphone().substring(4, 8) %>> -
        <input type="number" name="uphone3"  id="updatephone3"  class="phone" MAXLENGTH="4" required="required" tabindex="3" value=<%= user.getUphone().substring(9, 13) %>>
		</td>
      </tr>
      
    </tbody>
  </table>
  <br>
  <div align="center">
    <button style="background-color: #444444; color: white; margin: 10px" class="btn1">수정</button>
    <button style="background-color: #444444; color: white; margin: 10px" class="btn2">탈퇴</button>
  </div>
</div>
</c:if>

<script>
$(document).ready(function(){
	$(".btn2").click(function(){
		
		var data = { uid : $("#uid").val(),
	        		 upassword : $("#upassword").val()};
		$.ajax(
				{
			        type : 'delete',
			        url : '${root}/users/delete' ,
			        contentType: 'application/json',
			        data :JSON.stringify(data),
			        success : function(data, status, xhr) { 
			        	if(data!="success"){
			        	alertify.notify(data, 'error',3);
			        	}else{
			        		location.href="/users/logout";
				        	alertify.success('회원 정보가 삭제되었습니다.');
			        	}
			        }, 
			        error: function(jqXHR, textStatus, errorThrown) { 
			        	console.log(textStatus);
			        	alertify.notify(
				       			'Opps!! 회원정보 삭제 중 문제가 생겼습니다.', 
				       			'error', 
				       			3
				       		);
			        }
			    });
	})
	
	$(".btn1").click(function(){
		if($("#upassword").val()==""){
			alertify.notify("비밀번호를 입력해주세요", 'error',3);
			return;
		}
		
		var uphone = $("#updatephone1").val().concat('-').concat($("#updatephone2").val()).concat('-').concat($("#updatephone3").val());
		var data = { 
				uid : $("#uid").val(),
	        	uname : $("#uname").val(),
	    		uaddress : $("#uaddress").val(),
	    		uphone : uphone,
	    		upassword : $("#upassword").val()};
		
		$.ajax(
				{
			        type : 'put',
			        url : '${root}/users/update',
			        contentType: 'application/json',
			        data :JSON.stringify(data),
			        success : function(data, status, xhr) { 
			        	if(data!="success"){
			        		alertify.notify(data, 'error',3);
				        	}else{
				        		alertify.success('회원 정보가 수정되었습니다.');
				        	}
			        }, 
			        error: function(jqXHR, textStatus, errorThrown) { 
			        	console.log(textStatus);
			        	alertify.notify(
				       			'Opps!! 회원정보 수정 중 문제가 생겼습니다.', 
				       			'error', //'error','warning','message'
				       			3, //-1
				       			function(){
				       				console.log(jqXHR.responseText); 
				       			}
				       		);
			        }
			    });
	})
	

})


</script>
</body>
</html>