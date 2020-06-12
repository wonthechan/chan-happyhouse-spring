<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="root" value="${pageContext.request.contextPath }" />	
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/alertify.min.js"></script>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/alertify.min.css"/>
<title>로그인</title>

</head>
<body>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" href="/users/join">회원가입</a>
    </li>
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        로그인
      </a>
      <div class="dropdown-menu">
      	<p>아이디</p>
      	<input type="text" class="form-control" placeholder="" name="uid" id="uid">
      	<p>비밀번호</p>
      	<input type="password" class="form-control" placeholder="" name="upassword" id="upassword">
      	<br>
      	
      	<a href="https://kauth.kakao.com/oauth/authorize?client_id=cce8d7059b0dd35e8fbf80db79772e25&redirect_uri=http://localhost:9999/users/login/kakao&response_type=code">
      	<img src="resource/img/kakao_login_medium_narrow.png"></img>
      	</a>
        <button type="button" id="login" class="btn">로그인</button>
        <button type="button" id="find" class="btn">비밀번호 찾기</button>
        
      </div>
    </li>
    
    <li class="nav-item">
      <a class="nav-link" href="/">메인</a>
    </li>
  </ul>
 	
    
</nav>


<!-- Modal detail-->
<div class="modal fade" id="findPwModal" style="vertical-align: middle; margin-top:10%;">
	<div class="modal-dialog modal-simple modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
	      	<div class="modal-header" style="border:0px;">
	        	<h4 class="modal-title">비밀번호 찾기</h4>
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	      	</div>
	      	
			<div class="modal-body">
			
			<table class="table table-hover" style="border: 1px; margin: auto; text-align: center;">
			<thead>
				<tr><td>ID</td><td><input id="find_uid" type="text"></td></tr>
				<tr><td>이름</td><td><input id="find_uname" type="text"></td></tr>
			</thead>
			</table>
			</div>
			
			<div class="modal-footer">
			<input id="append_pwd" style="margin: auto;margin-left:15px; border:none; color:blue; font-size:20px;" size="40" readonly/>
			<button id="find_pwd" class="btn btn-primary btn-outline" style="margin-right:1px;" type="button" >비밀번호 찾기</button>
			</div>
			
			
		</div>
	</div>
</div>
<!-- End Modal -->



<script>
$(document).ready(function(){
	
	$("#find").click(function(){
		$("#findPwModal").modal("show");
	})
	
	$('#findPwModal').on('hidden.bs.modal', function () {
    $(this).find("input").val('').end();

	});
	
	$("#find_pwd").click(function(){
		
		$.ajax(
				{
			        type : 'get',
			        url : '${root}/users/'+ $("#find_uid").val()+'/'+$("#find_uname").val(),
			        data :{},
			        success : function(data, status, xhr) { 
			     		if(data!==undefined)
			     			$("#append_pwd").val("비밀번호 : "+data);
			     		else
			     			$("#append_pwd").val("비밀번호를 찾을 수 없습니다.");
			        }, 
			        error: function(jqXHR, textStatus, errorThrown) { 
			        	console.log(textStatus);
			        	
			        }
			    });
	})
	
	$("#login").click(function(){
		if($("#uid").val() == "") {
	        alertify.notify(
	              '아이디를 입력하세요', 'error',3,
	              function(){
	                  console.log(jqXHR.responseText); 
	              }
	          );
	        return;
	    } else if($("#upassword").val() == "") {
	        alertify.notify(
	             '비밀번호를 입력하세요', 'error', 3,
	             function(){
	                 console.log(jqXHR.responseText); 
	             }
	         );
	        return;
	    }
		
		var data = { uid:$("#uid").val(), upassword:$("#upassword").val()};
		
		$.ajax(
				{
			        type : 'post',
			        url : '${root}/users/login' ,
			        contentType: 'application/json',
			        data :JSON.stringify(data),
			        success : function(data, status, xhr) { 
			        	if(data=="success")
			        		location.reload();
			        	else
			        		 alertify.notify('로그인에 실패하였습니다.', 'error', 3);
			        }, 
			        error: function(jqXHR, textStatus, errorThrown) { 
			        	console.log(textStatus);
			        	
			        }
			    });
	
		})
		
	})
</script>


</body>
</html>