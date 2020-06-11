<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>

<style type="text/css">
h4  {
	text-align: center;
}

#joinadd {
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

<meta charset="UTF-8">
  <title>회원 가입</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/alertify.min.js"></script>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/alertify.min.css"/>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/themes/default.min.css"/>
</head>
<body>
<jsp:include page="login.jsp" />

<div class="container"><br>
  <h2 align="center">Happyhouse 회원가입</h2>
  <p>* 은 필수항목 입니다.</p>
  <br>
  <table class="table">
    <thead class="thead-dark" align="center">
      <tr>
        <th>항목</th>
        <th>정보 입력</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>아이디*</td>
        <td>
        <input type="text" id="joinId" required="required">
		</td>
      </tr>
      <tr>
        <td>비밀번호*</td>
        <td>
        <input type="password" id="joinPwd" required="required">
		</td>
      </tr>
      <tr>
        <td>비밀번호확인*</td>
        <td>
        <input type="password" id="joinPwd2" required="required">
		</td>
      </tr>
      <tr>
        <td>이름*</td>
        <td>
        <input type="text" id="joinName" required="required">
		</td>
      </tr>
      <tr>
        <td>주소*</td>
        <td>
        <input type="text" id="joinAddress" required="required">
		</td>
      </tr>
      <tr>
        <td>연락처*</td>
        <td>
        <input type="text" name="joinphone1"  id="joinphone1"  class="phone" MAXLENGTH="3" required="required" tabindex="1"> -
        <input type="text" name="joinphone2"  id="joinphone2"  class="phone" MAXLENGTH="4" required="required" tabindex="2"> -
        <input type="text" name="joinphone3"  id="joinphone3"  class="phone" MAXLENGTH="4" required="required" tabindex="3">
		</td>
      </tr>
      
    </tbody>
  </table>
  <br>
  <div align="center">
    <button style="background-color: #444444; color: white; margin: 10px" class="btn1" >가입</button>
    <button style="background-color: #444444; color: white; margin: 10px" type="reset" class="btn" >취소</button>
  </div>
</div>

<script>
$(document).ready(function(){
	
	
	$(".btn1").click(function(){
		var joinPhone = $("#joinphone1").val().concat('-').concat($("#joinphone2").val()).concat('-').concat($("#joinphone3").val());
		if( $("#joinPwd").val() != $("#joinPwd2").val() )
			alert("비밀번호가 일치하지 않습니다.");
		else{
			
			var data = {
					uid : $("#joinId").val(),
		        	uname : $("#joinName").val(),
		    		uaddress : $("#joinAddress").val(),
		    		uphone : joinPhone,
		    		upassword : $("#joinPwd").val()};
			
		$.ajax(
				{
			        type : 'post',
			        url : '${root}/users/join',
			        contentType: 'application/json',
			        data :JSON.stringify(data),
			        success : function(data, status, xhr) { 
			        	if(data=="success"){
			        	location.href="/users/logout";
			        	alert('회원 정보가 등록되었습니다.');
			        	}else{
			        		alert('잘못된 회원정보입니다.');
			        	}
			        }, 
			        error: function(jqXHR, textStatus, errorThrown) { 
			        	console.log(textStatus);
			        	alertify.notify(
				       			'Opps!! 회원정보 등록 중 문제가 생겼습니다.', 
				       			'error', //'error','warning','message'
				       			3, //-1
				       			function(){
				       				console.log(jqXHR.responseText); 
				       			}
				       		);
			        }
			    });
		}
	})
})


</script>
</body>
</html>
