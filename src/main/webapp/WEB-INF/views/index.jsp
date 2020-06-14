<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }" />	
<!DOCTYPE html>
<html lang="en">
<head>
<title>HappyHouse ^_^*</title>
<style type="text/css">
#map {
	height: 1000px;
	display:none;
}

#apartClass{
	height:600px;
}


</style>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.2/css/bootstrap-select.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.2/js/bootstrap-select.min.js"></script>   
<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>

</head>
<body>

<c:if test="${empty userDto}">
   <jsp:include page="user/login.jsp" />
</c:if>

<c:if test="${not empty userDto}">
   <jsp:include page="user/loginsuccess.jsp" />
</c:if>



<jsp:include page="etc/reginterest.jsp" />
    


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
	  		
	  				  <!-- Basic dropdown -->
			  <button  class="btn btn-outline-light text-dark dropdown-toggle mr-4" type="button" data-toggle="dropdown"
			          aria-haspopup="true" aria-expanded="false">타입</button>
			
			  <div class="dropdown-menu">
			    <a class="dropdown-item">
			      <!-- Default unchecked -->
			      <div class="custom-control custom-checkbox">
			        <input type="checkbox" class="custom-control-input" value="0" id="checkbox1" checked>
			        <label class="custom-control-label" for="checkbox1">아파트 매매</label>
			      </div>
			    </a>
			    <a class="dropdown-item">
			      <div class="custom-control custom-checkbox">
			        <input type="checkbox" class="custom-control-input" value="1" id="checkbox2">
			        <label class="custom-control-label" for="checkbox2">아파트 전월세</label>
			      </div>
			    </a>
			    <a class="dropdown-item">
			      <div class="custom-control custom-checkbox">
			        <input type="checkbox" class="custom-control-input" value="2" id="checkbox3">
			        <label class="custom-control-label" for="checkbox3">다세대 주택 매매</label>
			      </div>
			    </a>
			    <a class="dropdown-item">
			      <div class="custom-control custom-checkbox">
			        <input type="checkbox" class="custom-control-input" value="3" id="checkbox4">
			        <label class="custom-control-label" for="checkbox4">다세대,주택 전월세</label>
			      </div>
			    </a>
			  </div>
			  <!-- Basic dropdown -->
			  
	  		<select id="inputSearchField" class="form-control" name="searchField">
			    <option value="list">전체</option>
  				<option value="dong">동 이름</option>
  				<option value="aptName">아파트 이름</option>
			 </select>
			 
			<input id="frm1input" type="hidden" name="pageNo" value="1"> 
			<input id="inputSearchText" type="text" class="form-control" name="searchText" onfocus="this.value=''">
		
			  
      		<button id ="btnSearchWord" class="btn btn-primary" type="submit">SEARCH</button>  
     		</td>
	  	</tr>
	  </table>
</div>
<br>  
<div class="container">
<div class="container-sm" id="apartClass">
<div id="Tab" style="display:none;">
<ul class="nav nav-tabs">
<li class="nav-item"><button id="listTab" class="nav-link btn btn-outline-primary active"><h6>리스트</h6></button></li>
<li class="nav-item"><button id="mapTab" class="nav-link btn btn btn-outline-light text-dark"><h6>지도</h6></button></li>
</ul>
</div>
<div id="map" style="display:none">
</div>
<table id="apartTable" class="table table-hover table-borderless">
  </table>
   
   
</div>
</div>

<!-- Modal detail-->
<div class="modal fade" id="aptViewModal" style="vertical-align: middle; margin-top:10%;">
	<div class="modal-dialog modal-simple modal-lg">
		<div class="modal-content">
			<!-- Modal Header -->
	      	<div class="modal-header">
	        	<h4 class="modal-title">아파트 상세조회</h4>
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	      	</div>
	      	
			<div class="modal-body">
		
			<div class="row">
			<div class="col-sm-6">
			<table class="table table-borderless table-sm" style="margin:10px;">
			    <tbody>
			       <tr><td>주택명</td><td id="aptNameView">#</td></tr>
			       <tr><td>거래금액</td><td id="dealAmountView">#</td></tr>
			       <tr><td>월세금액</td><td id="rentMoneyView">#</td></tr>
			       <tr><td>건축연도</td><td id="buildYearView">#</td></tr>
			       <tr><td>면적</td><td id="areaView">#</td></tr>
			       <tr><td>거래일</td><td id="regDtView">#</td></tr>
			       <tr><td>법정동</td><td id="dongView">#</td></tr>
			       <tr><td>지번</td><td id="jibunView">#</td></tr>
			       <tr><td>거래종류</td><td id="typeView">#</td></tr>
			    </tbody>
			  </table>
			</div>

			<div class="col-sm-6">
			<img src="" id="imgView" class = "rounded" width = "300" style="float:left; margin:10px;"></img>
			</div>
		
			</div>
			</div>
		</div>
	</div>
</div>
<!-- End Modal -->




<script src="https://unpkg.com/@google/markerclustererplus@4.0.1/dist/markerclustererplus.min.js"></script>
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB6FYzXV_4wBKef7_bhyZVBHZGvNUV4U9Y&callback=initMap"></script>




<div id="paginationWrapper"></div>
<script src="resource/js/paging.js"></script>	
<script>

var searchText="";
var searchField="";
var order="";
var locations=[{
	lat : "37.5793355",
	lng : "126.9684839"
}];

var aptlist="";

var LIST_ROW_COUNT = 10;
var OFFSET = 0;
var PAGE_LINK_COUNT = 10;	// pagination link 갯수
var TOTAL_LIST_ITEM_COUNT = 0;
var CURRENT_PAGE_INDEX = 1;

$(document).ready(function(){
	
	//search data
	$("#btnSearchWord").click(function(){

		var inputValid=true;
		
		var inputSearchField = $("#inputSearchField").val();
		var inputSearchText = $("#inputSearchText").val();
		
		if( inputSearchField != "list" ){
			searchField = inputSearchField;
		}else{
			alert("검색 종류를 선택하세요.");
			inputValid=false;
		}
		
		
		if( inputSearchText != "" ){
			searchText = inputSearchText;
		}else{
			alert("검색명을 입력하세요.");
			inputValid=false;
		}
		
		if(inputValid){
			order="";
			CURRENT_PAGE_INDEX = 1;
			$("#Tab").css("display","block");
			
			if($("#listTab").hasClass("active"))
				aptList();
			else if($("#mapTab").hasClass("active")){
				mapList();
			}
			
		}
	});  
	
	//toggle tab - list
	$("#listTab").click(function(){
		
		$('#listTab').removeClass('btn-outline-light text-dark');
		$('#listTab').addClass('btn-outline-primary active');
		
		$('#mapTab').removeClass('btn-outline-primary active');
		$('#mapTab').addClass('btn-outline-light text-dark');
		
		aptList();
	});
	
	//toggle tab - map
	$("#mapTab").click(function(){
		
		$('#mapTab').removeClass('btn-outline-light text-dark');
		$('#mapTab').addClass('btn-outline-primary active');
		
		$('#listTab').removeClass('btn-outline-primary active');
		$('#listTab').addClass('btn-outline-light text-dark');
		
		mapList();
		
	});
	
});



function mapList(){

	var data = {
			searchField : searchField,
        	searchText : searchText
        	};
	
	$.ajax(
	{
        type : 'post',
        url : '${root}/houses/map',
        contentType: 'application/json',
        data :JSON.stringify(data),
        success : function(data, status, xhr) { 
        	locations=data;
        	makeMapHtml();
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	console.log(textStatus);
        	
        
        }
    });
}

function aptList(){
	
	var data = {
			order : order,
        	pageNo: CURRENT_PAGE_INDEX-1,
        	searchField : searchField,
        	searchText : searchText
        	};
	$.ajax(
	{
        type : 'post',
        url : '${root}/houses/search',
        contentType: 'application/json',
        data :JSON.stringify(data),
        success : function(data, status, xhr) { 
        	aptlist=data
        	$("#map").hide(); 
        	makeListHtml(data);
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	console.log(textStatus);
        	
        }
    });
}


function aptView(no){
	$.ajax(
			{
		        type : 'get',
		        url : '${root}/houses/detail/'+no,
		        dataType : 'json',
		        data : 
				{
		        	
				},
		        success : function(data, status, xhr) { 
		        	makeViewHtml(data);
		        }, 
		        error: function(jqXHR, textStatus, errorThrown) 
		        { 
		        	console.log(textStatus);
		        	
		        	
		        }
		    });
}


function makeViewHtml(aptview){
	
	var aptName = aptview.aptName;
	var dealAmount = aptview.dealAmount;
	var rentMoney = aptview.rentMoney;
	if(rentMoney==null)
		rentMoney="없음";
	var buildYear = aptview.buildYear;
	var area = aptview.area;
	var regDt = aptview.dealYear+"."+aptview.dealMonth+"."+aptview.dealDay;
	var dong = aptview.dong;
	var jibun = aptview.jibun;
	var type = aptview.type;
	var img = "resource/img/"+aptview.img;
	
	$("#aptNameView").html(aptName);
	$("#dealAmountView").html(dealAmount);
	$("#rentMoneyView").html(rentMoney);
	$("#buildYearView").html(buildYear);
	$("#areaView").html(area);
	$("#regDtView").html(regDt);
	$("#dongView").html(dong);
	$("#jibunView").html(jibun);
	$("#typeView").html(type);
	$("#imgView").attr("src",img);
	$("#aptViewModal").modal("show");
}

function mapToList(aptName){
	
	searchField="aptName";
	searchText=aptName;
	CURRENT_PAGE_INDEX=1;
	$("#listTab").click();
}

function initMap(){
		
	 var INFO_WINDOW_HTML = 
	    	'<div class="card" style="width:200px">' +
			'<img class="card-img-top" src="resource/img/^SRC" alt="Card image" width="200px; height="200px;">' +
			'<div class="card-body">' +
			'<h4 class="card-title">^APT_NAME</h4>' +
			'<p class="card-text">^DONG</p>' +
			'<a href="javascript:mapToList(^APT_NAME2);" class="btn btn-primary">자세히 보기</a>' +
			'</div>' +
			'</div>';
			

	
	
	var map = new google.maps.Map(
			document.getElementById('map'), 
			{
        		zoom: 12,
        		center: {
        			lat: parseFloat(locations[0].lat), lng: parseFloat(locations[0].lng)
        		}
      		}
		);
	
	
	
	var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	var markers = locations.map(

		function(location, i) {
    		return new google.maps.Marker(
 				{
   					position: { lat: parseFloat(location.lat), lng: parseFloat(location.lng) },	// should be float, not string
   					label: labels[i % labels.length],
   					aptName: location.aptName,
   					dong: location.dong,
   					img: location.img
 				}
    		);
 		 }
	);

	var markerCluster = new MarkerClusterer(
		map,
		markers,
		{
			imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'
		}
	);
	
	
	markers.map(
		function(marker, i){
			marker.addListener('click', function() {
				var infowindow = new google.maps.InfoWindow({
				    content: INFO_WINDOW_HTML.replace('^APT_NAME', marker.aptName).replace('^DONG', marker.dong).replace('^SRC',marker.img).replace('^APT_NAME2', "'"+marker.aptName+"'")
				});
				infowindow.open(map, marker);
			});
		}
	);
	
}

function makeMapHtml(){
	
	
	
	$("#apartTable").html("");
	$("#map").css("display","block");
	if(locations.length>1)
		initMap();
	else
		alert("검색 결과가 없습니다.");
	
	
}
function makeListHtml(list){
	
	$("#apartTable").html("");
	
	if(list.length==0)
		alert("검색 결과가 없습니다.");
	else{
	var headHtml="<thead><tr><th>동</th><th>아파트 이름</th><th>거래 금액<div class='btn-group btn-group-sm'><button type='button' class='btn btn-light' onclick='orderDealAmount("+'"asc"'+")'>△</button><button type='button' class='btn btn-light' onclick='orderDealAmount("+'"desc"'+")'>▽</button></div></th><th>면적</th></tr></thead><tbody id='aptTbody'></tbody>";
	
	$("#apartTable").append(headHtml);
	}
	for( var i=0; i<list.length; i++){
	
		var no = list[i].no;
		var dong = list[i].dong;
		var aptName = list[i].aptName;
		var dealAmount = list[i].dealAmount;
		var area = list[i].area;	
		
		var listHtml =
			'<tr style="cursor:pointer" data-aptNo=' + no +'><td>' + dong + 
			'</td><td>' + aptName + '</td><td>' + dealAmount + '</td><td>' + area + '</td></tr>';

		$("#aptTbody").append(listHtml);
	}
	
	makeListHtmlEventHandler();
	
	aptListTotalCnt();
}

function makeListHtmlEventHandler(){
	
	$("#aptTbody tr").click(function(){
		aptView($(this).attr("data-aptNo"));
	});
}


function aptListTotalCnt(){
	
	var data = { searchField : searchField,
        	searchText : searchText
        	};
	
	$.ajax(
	{
        type : 'post',
        url : '${root}/houses/count',
        contentType: 'application/json',
        data :JSON.stringify(data),
        success : function(data, status, xhr) {
        	var parsedData = JSON.parse(data);
        	TOTAL_LIST_ITEM_COUNT = parsedData; 
        	addPagination();
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	console.log(jqXHR.responseText); 
        }
    });
}

function addPagination(){

	makePaginationHtml(LIST_ROW_COUNT, PAGE_LINK_COUNT, CURRENT_PAGE_INDEX, TOTAL_LIST_ITEM_COUNT, "paginationWrapper" );
}

function movePage(pageIndex){
	OFFSET = (pageIndex - 1) * LIST_ROW_COUNT;
	CURRENT_PAGE_INDEX = pageIndex;
	aptList();
}

function orderDealAmount(ord){
	order=ord;
	aptList();
}

</script>

</body>
</html>
