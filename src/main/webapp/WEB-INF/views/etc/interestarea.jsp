<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />	
<!DOCTYPE html>
<html lang="en">
<head>
	<title>HappyHouse ^_^*</title>
	<style type="text/css">
	</style>
	
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.2/css/bootstrap-select.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.2/js/bootstrap-select.min.js"></script>   
  
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/alertify.min.js"></script>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/alertify.min.css"/>
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.12.0/build/css/themes/default.min.css"/>
</head>
<body>


<c:if test="${empty userDto}">
   <jsp:include page="../user/login.jsp" />
</c:if>

<c:if test="${not empty userDto}">
   <jsp:include page="../user/loginsuccess.jsp" />
</c:if>

<jsp:include page="../etc/reginterest.jsp" />


<div class="jumbotron jumbotron-fluid">
   <div class="container" align="center">
      <h1 class="display-4">Happy House</h1>
      <hr>
   </div>
</div>


<div class="form-inline">
	<table class="table table-borderless">
	  	<tr>
	  		<td align="center">
	  		<select class="form-control" id="sido">
			    <option value="0">선택</option>
			 </select>
			 <select class="form-control" id="gugun">
			    <option value="0">선택</option>
			 </select>
			 <select class="form-control" id="dong">
			    <option value="0">선택</option>
			 </select>
			  
      		<button class="btn btn-primary" id="registerArea">관심지역 등록</button>  
     		</td>
	  	</tr>
	  </table>
</div>  



<div class="container-sm">
<div class="row">
<div class="col-sm-3"></div>
<div class="col-sm-6">

<form id="frm2" action="" method="post" >
<input id="frm1input" type="hidden" name="pageNo" value="1"> 
<input id="frm2input" type="hidden" name="dong" value="" />
<table class="table table-hover">
     <tbody id="areaTbody">
     </tbody>
   </table>
</form>

</div>
<div class="col-sm-3"></div>
</div>
</div>



<script type="text/javascript">

$(document).ready(function(){
	interestAreaList();
	
	// 관심지역 등록 버튼 리스너
	$("#registerArea").click(function(){
		registerArea();
	});
	
	// 시도코드 데이터 받아오기
	$.ajax(
		{
	        type : 'get',
	        url : '${pageContext.request.contextPath}/areas/sido',
	        dataType : 'json',
	        data : 
			{
			},
	        success : function(data, status, xhr) { 
	        	$.each(data, function(index, vo) {
					$("#sido").append("<option value='"+vo.citycode+"'>"+vo.city+"</option>");
				});//each
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) 
	        { 
	        	console.log(textStatus);
	        	alertify.notify(
	       			'Opps!! 데이터 조회 과정에 문제가 생겼습니다.', 
	       			'error', //'error','warning','message'
	       			3, //-1
	       			function(){
	       				console.log(jqXHR.responseText); 
	       			}
	       		);
	        }
	});//ajax
});//ready

$(document).ready(function(){
	// 구군코드 데이터 받아오기
	$("#sido").change(function() {
		$.ajax(
				{
			        type : 'get',
			        url : '${pageContext.request.contextPath}/areas/gugun/' + $("#sido").val(),
			        dataType : 'json',
			        success : function(data, status, xhr) { 
			        	$("#gugun").empty();
						$("#gugun").append('<option value="0">선택</option>');
						$.each(data, function(index, vo) {
							$("#gugun").append("<option value='"+vo.gucode+"'>"+vo.gu+"</option>");
						});//each
			        }, 
			        error: function(jqXHR, textStatus, errorThrown) 
			        { 
			        	console.log(textStatus);
			        	alertify.notify(
			       			'Opps!! 데이터 조회 과정에 문제가 생겼습니다.', 
			       			'error', //'error','warning','message'
			       			3, //-1
			       			function(){
			       				console.log(jqXHR.responseText); 
			       			}
			       		);
			        }
			});//ajax
	});//change
	
	// 동코드 데이터 받아오기
	$("#gugun").change(function() {
		$.ajax(
				{
			        type : 'get',
			        url : '${pageContext.request.contextPath}/areas/dong/' + $("#gugun").val(),
			        dataType : 'json',
			        success : function(data, status, xhr) { 
			        	$("#dong").empty();
						$("#dong").append('<option value="0">선택</option>');
						$.each(data, function(index, vo) {
							$("#dong").append("<option value='"+vo.dongcode+"'>"+vo.dong+"</option>");
						});//each
			        }, 
			        error: function(jqXHR, textStatus, errorThrown) 
			        { 
			        	console.log(textStatus);
			        	alertify.notify(
			       			'Opps!! 데이터 조회 과정에 문제가 생겼습니다.', 
			       			'error', //'error','warning','message'
			       			3, //-1
			       			function(){
			       				console.log(jqXHR.responseText); 
			       			}
			       		);
			        }
			});//ajax
	});//change
});//ready

function interestAreaList(){
	$.ajax(
	{
        type : 'get',
        url : '${pageContext.request.contextPath}/areas/interest/${uid}',
        dataType : 'json',
        data : 
		{
		},
        success : function(data, status, xhr) { 
        	makeListHtml(data);
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	console.log(textStatus);
        	
        	alertify.notify(
       			'Opps!! 관심 지역 조회 과정에 문제가 생겼습니다.', 
       			'error', //'error','warning','message'
       			3, //-1
       			function(){
       				console.log(jqXHR.responseText); 
       			}
       		);
        }
    });
}

function makeListHtml(list){

	$("#areaTbody").html("");

	for( var i=0; i<list.length; i++){
	
		var dongName = list[i].dong;
		var gugunName = list[i].gu;
		var sidoName = list[i].city;
		var dongCode = list[i].dongcode;
		
		var listHtml =
			'<tr><td>' + sidoName + ' / ' + gugunName + ' / ' + dongName + '</td><td></td><td></td><td></td><td></td><td></td><td><button data-dong=' + dongCode + ' type="button" class="btn btn-outline-danger btn-sm" style="text-align:right;">삭제</button></td></tr>';

		$("#areaTbody").append(listHtml);
	}
	
	makeListHtmlEventHandler();
}

function makeListHtmlEventHandler(){
	$("#areaTbody button").click(function(){
		var dongCode = $(this).attr("data-dong");
		deleteArea(dongCode)
	});
}

function deleteArea(dongCode){

	var data = { 
			uid: '${uid}',
        	dongcode: dongCode
        	};
	
	$.ajax(
		{
	        type : 'delete',
	        url : '${pageContext.request.contextPath}/areas/interest',
	        contentType: 'application/json',
	        data :JSON.stringify(data),
	        success : function(data, status, xhr) { 
        		alertify.success('관심지역에서 삭제되었습니다.');
        		interestAreaList();
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) 
	        {
	        	alertify.notify(
	       			'Opps!! 삭제 과정에 문제가 생겼습니다.', 
	       			'error', //'error','warning','message'
	       			3, //-1
	       			function(){
	       				console.log(jqXHR.responseText); 
	       			}
	       		);
	        }
	    });
}

function registerArea() {
	
	var data = { 
			uid: '${uid}',
        	dongcode: $("#dong option:selected").val() ,
        	dong: $("#dong option:selected").text()
        	};
	
	$.ajax(
		{
	        type : 'post',
	        url : '${pageContext.request.contextPath}/areas/interest',
	        contentType: 'application/json',
	        data :JSON.stringify(data),
	        success : function(data, status, xhr) { 
        		alertify.success('정상적으로 등록되었습니다.');
        		interestAreaList();
	        }, 
	        error: function(jqXHR, textStatus, errorThrown) 
	        { 
	        	alertify.notify(
	      			'Opps!! 등록 과정에 문제가 생겼습니다.', 'error', 3, 
	      			function(){
	      				console.log(jqXHR.responseText); 
	      			}
	      		);
	        	
	        }
	    });
}
function searchStore(dong){
	document.getElementById("frm2input").value=dong;
	document.getElementById("frm2").action = "etc.do?action=store";
	document.getElementById("frm2").submit();
}


</script>

</body>
</html>