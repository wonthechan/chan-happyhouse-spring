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
<script async defer	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB6FYzXV_4wBKef7_bhyZVBHZGvNUV4U9Y"></script>
   
</head>
<body>


<c:if test="${empty userDto}">
   <jsp:include page="../user/login.jsp" />
</c:if>

<c:if test="${not empty userDto}">
   <jsp:include page="../user/loginsuccess.jsp" />
</c:if>


<jsp:include page="../etc/reginterest.jsp" />
 
 <br>

 <div class="container-sm">
<div class="row">
<div class="col-sm-5">
<div class="container" style="height:50px"><p><h3>나의 관심지역 목록 </h3></p></div>
<form id="frm1" action="" method="post" >
<input id="frm1pageMove" type="hidden" name="pageMove" value=""> 
<input id="frm1pageNo" type="hidden" name="pageNo" value="1"> 
<input id="frm1Dong" type="hidden" name="dong" value="${dong}">

<table class="table table-hover">
<c:if test="${empty interestarea}">
<h5>&nbsp;&nbsp;&nbsp;상권정보를 확인해보세요.</h5>
</c:if>
     <tbody id="areaTbody">
     </tbody>
   </table>
</form>

</div>
<div class="col-sm-7">
<div class="container" style="height:50px" id="title"></div>
<div class="container">
<div class="container-sm">
<table class="table table-hover">
     <thead>
       <tr>
         <th>가게이름</th>
         <th>업종정보</th>
         <th>가게위치</th>
       </tr>
     </thead>
     <tbody id="storeTbody">
     </tbody>
   </table>
	<%-- paging --%>
   <div id="paginationWrapper"></div>
</div>
</div>

</div>
</div>
</div>

<!-- modal begin ------------------------------------------------------------------------->
	<!-- Modal detail-->
	<div class="modal fade" id="storeDetailModal">
		<div class="modal-dialog modal-simple">
			<div class="modal-content">
				<!-- Modal Header -->
		      	<div class="modal-header">
		        	<h4 class="modal-title">상점 상세 정보</h4>
		        	<button type="button" class="close" data-dismiss="modal">&times;</button>
		      	</div>
		      	
				<div class="modal-body">
				
				               <div class="example table-responsive">
				                 <table class="table table-hover">
				                   <tbody>
				                   
				                     <tr><td>이름</td><td id="shopNameDetail">#</td></tr>
				                     <tr><td>지점</td><td id="localNameDetail">#</td></tr>
				                     <tr><td>대분류</td><td id="codeName1Detail">#</td></tr>
				                     <tr><td>중분류</td><td id="codeName2Detail">#</td></tr>
				                     <tr><td>소분류</td><td id="codeName3Detail">#</td></tr>
				                     <tr><td>지번 주소</td><td id="jibuAddressDetail">#</td></tr>
				                     <tr><td>도로명 주소</td><td id="addressDetail">#</td></tr>
				                     <tr><td>(구) 우편번호</td><td id="oldPostCodeDetail">#</td></tr>
				                     <tr><td>우편번호</td><td id="postCodeDetail">#</td></tr>
				                     <tr><td>위도</td><td id="lngDetail">#</td></tr>
				                     <tr><td>경도</td><td id="latDetail">#</td></tr>
				                     
				                   </tbody>
				                 </table>
				               </div>
               	<!-- 
					<button id="btnEmpUpdateForm" class="btn btn-sm btn-primary btn-outline" data-dismiss="modal" type="button">사원 정보 수정하기</button>
					<button id="btnEmpDeleteConfirm" class="btn btn-sm btn-warning btn-outline" data-dismiss="modal" type="button">사원 정보 삭제하기</button>
				-->
				<!-- show map here -->
           		 <div id="map" style="width: 100%; height: 500px;"></div>
				</div>
               <div class="modal-footer"> 
               		<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button> 
               </div>
			</div>
		</div>
	</div>
	<!-- End Modal -->

<script type="text/javascript">

var LIST_ROW_COUNT = 10;	//limit
var OFFSET = 0;
var DONGCODE = '0';

$(document).ready(function(){
	interestAreaList();
	
	//모달창 이벤트 등록
	$("#storeDetailModal").on("shown.bs.modal", function() {
		initMap();
	});

	$("#storeDetailModal").on("hidden.bs.modal", function() {
		$("#map").empty();
	});
}); // end ready

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
        	makeAreaListHtml(data);
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

function makeAreaListHtml(list){

	$("#areaTbody").html("");

	for( var i=0; i<list.length; i++){
	
		var dongName = list[i].dong;
		var gugunName = list[i].gu;
		var sidoName = list[i].city;
		var dongCode = list[i].dongcode;
		
		var listHtml = '<tr>';
		listHtml += '<td>' + gugunName + ' / ' + dongName + '</td>';
		listHtml += '<td></td><td></td><td></td><td></td><td></td>';
 		listHtml += '<td>';
 		listHtml += '<button type="button" onclick="searchStore(' + dongCode + ', \'' + dongName + '\')" class="btn btn-outline-warning btn-sm" style="text-align:right;">상권정보</button>';
 		listHtml += '</td>';
		listHtml += '</tr>';

		$("#areaTbody").append(listHtml);
	}
	
	// makeListHtmlEventHandler();
}

function searchStore(dongCode, dongName){
	DONGCODE = dongCode;
	$("#title").html('<p><h3>&nbsp;&nbsp;' + dongName + ' 상권정보</h3></p>');
	storeList();
}

function storeList(){
	$.ajax(
	{
        type : 'get',
        url : '${pageContext.request.contextPath}/stores/' + DONGCODE + '/' + OFFSET + '/' + LIST_ROW_COUNT,
        dataType : 'json',
        success : function(data, status, xhr) { 
        	makeStoreListHtml(data);
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

function makeStoreListHtml(list){

	$("#storeTbody").html("");

	for( var i=0; i<list.length; i++){
		var no = list[i].no;
		var shopName = list[i].shopname;
		var codeName4 = list[i].codename4;
		var jibuaddress = list[i].jibuaddress;
		
		var listHtml = '<tr style="cursor:pointer" data-storeNo=' + no + '>';
		listHtml += '<td class="small">' + shopName + '</td>';
		listHtml += '<td class="small">' + codeName4 + '</td>';
		listHtml += '<td class="small">' + jibuaddress + '</td>';
		listHtml += '</tr>';

		$("#storeTbody").append(listHtml);
	}
	
	makeStoreListHtmlEventHandler();
	storeListTotalCnt();
}

function makeStoreListHtmlEventHandler(){
	$("#storeTbody tr").click(function(){
		var no = $(this).attr("data-storeNo");
		storeDetail(no);
	});
}

//detail
function storeDetail(no){

	$.ajax(
	{
        type : 'get',
        url : '${pageContext.request.contextPath}/stores/' + no,
        dataType : 'json',
        success : function(data, status, xhr) { 
        	makeStoreDetailHtml(data);
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        {
    		alertify.notify(
       			'Opps!! 글 상세 조회 과정에 문제가 생겼습니다.', 
       			'error', //'error','warning','message'
       			3, //-1
       			function(){
       				console.log(jqXHR.responseText); 
       			}
       		);
        }
    });
}

function makeStoreDetailHtml(detail){
	
	var no = detail.no;						// 상점 넘버값
	var shopName = detail.shopname   	;	// 상점 이름
	var localName = detail.localname  	;	// 지점
	var codeName1 = detail.codename1  	;	// 대분류
	var codeName2 = detail.codename2  	;	// 중분류
	var codeName3 = detail.codename3  	;	// 소분류
	var jibuAddress= detail.jibuaddress	;	// 지번 주소
	var address = detail.address    	;	// 도로명 주소
	var oldPostCode = detail.oldpostcode;	// (구) 우편번호
	var postCode = detail.postcode   	;	// 우편번호
	var lng = detail.lng        		;	// 경도
	var lat = detail.lat        		;	// 위도
	
	$("#storeDetailModal").attr("data-storeNo", no);
	
	$("#shopNameDetail").html(shopName);
	$("#localNameDetail").html(localName);
	$("#codeName1Detail").html(codeName1);
	$("#codeName2Detail").html(codeName2);
	$("#codeName3Detail").html(codeName3);
	$("#jibuAddressDetail").html(jibuAddress);
	$("#addressDetail").html(address);
	$("#oldPostCodeDetail").html(oldPostCode);
	$("#postCodeDetail").html(postCode);
	$("#lngDetail").html(lng);
	$("#latDetail").html(lat);
	
	
	$("#storeDetailModal").modal("show");
	
	// init map
	//initMap(parseFloat(lat), parseFloat(lng));
	google.maps.event.trigger(map, 'resize');
}

var PAGE_LINK_COUNT = 10;	// pagination link 갯수
var TOTAL_LIST_ITEM_COUNT = 0;
var CURRENT_PAGE_INDEX = 1;

function storeListTotalCnt(){
	
	$.ajax(
	{
        type : 'get',
        url : '${pageContext.request.contextPath}/stores/count/' + DONGCODE,
        dataType : 'json',
        success : function(data, status, xhr) {
        	TOTAL_LIST_ITEM_COUNT = data;
        	addPagination();
        }, 
        error: function(jqXHR, textStatus, errorThrown) 
        { 
        	alertify.notify(
       			'Opps!! 글 전체 갯수 조회 과정에 문제가 생겼습니다.', 
       			'error', //'error','warning','message'
       			3, //-1
       			function(){
       				console.log(jqXHR.responseText); 
       			}
       		);
        }
    });
}

function addPagination(){
	makePaginationHtml(LIST_ROW_COUNT, PAGE_LINK_COUNT, CURRENT_PAGE_INDEX, TOTAL_LIST_ITEM_COUNT, "paginationWrapper" );
}

function movePage(pageIndex){
	OFFSET = (pageIndex - 1) * LIST_ROW_COUNT;
	CURRENT_PAGE_INDEX = pageIndex;
	storeList();
}

function makePaginationHtml(listRowCount, pageLinkCount, currentPageIndex, totalListItemCount, htmlTargetId){
	
	var targetUI = $("#" + htmlTargetId);
	
	var pageCount = Math.ceil(totalListItemCount/listRowCount);

	var startPageIndex = 0;
	if( (currentPageIndex % pageLinkCount) == 0 ){ //10, 20...맨마지막
		startPageIndex = ((currentPageIndex / pageLinkCount)-1)*pageLinkCount + 1
	}else{
		startPageIndex = Math.floor(currentPageIndex / pageLinkCount)*pageLinkCount + 1
	}
	
	var endPageIndex = 0;
	if( (currentPageIndex % pageLinkCount) == 0 ){ //10, 20...맨마지막
		endPageIndex = ((currentPageIndex / pageLinkCount)-1)*pageLinkCount + pageLinkCount
	}else{
		endPageIndex = Math.floor(currentPageIndex / pageLinkCount)*pageLinkCount + pageLinkCount;
	}

	var prev;
	if( currentPageIndex <= pageLinkCount ){
		prev = false;
	}else{
		prev = true;
	}

	var next;
	if(endPageIndex > pageCount){
		endPageIndex = pageCount
		next = false;
	}else{
		next = true;
	}
	
	var paginationHtml =
		'<ul class="pagination pagination justify-content-center">';
	if(prev){
		paginationHtml += 
			'<li class="page-item">' +
			'<a class="page-link" href="javascript:movePage(' + (startPageIndex - 1) + ')" aria-label="Previous">' +
			'<span aria-hidden="true">&laquo;</span>' +
			'</a>' +
			'</li>';
	}
	
	for(var i=startPageIndex; i<=endPageIndex; i++){
		
		if( i == currentPageIndex ){
			paginationHtml += 
				'<li class="page-item active"><a class="page-link" href="javascript:movePage(' + i + ')">' + i + '</a></li>';			
		}else{
			paginationHtml += 
				'<li class="page-item"><a class="page-link" href="javascript:movePage(' + i + ')">' + i + '</a></li>';			
		}
	}
	
	if(next){
		paginationHtml += 
			'<li class="page-item">' +
			'<a class="page-link" href="javascript:movePage(' + (endPageIndex + 1) + ')" aria-label="Next">' +
			'<span aria-hidden="true">&raquo;</span>' +
			'</a>' +
			'</li>';
	}

	paginationHtml += '</ul>';
	
	targetUI.html("");
	targetUI.append(paginationHtml);
}

function initMap() {
	var storeLat = parseFloat($("#latDetail").text().replace(/"/g,""));
	var storeLng = parseFloat($("#lngDetail").text().replace(/"/g,""));
	var storeName = $("#shopNameDetail").text();
	
	//위도, 경도 
	var center = new google.maps.LatLng(storeLat, storeLng);
	var store = new google.maps.LatLng(storeLat, storeLng);

	//맵 정보
	var mapProp = {
		center : center,
		zoom : 17,
	};
	
	//맵 요청
	var map = new google.maps.Map(document.getElementById("map"), mapProp);
	
	//마커 표시
	var marker = new google.maps.Marker({
		position : store
	});
	marker.setMap(map);
	
	//InfoWindow
	var infowindow = new google.maps.InfoWindow(
	{
		content : '<div style="text-align:center;"><strong>' + storeName + '</strong></div>'
	});
	
	infowindow.open(map, marker);
}

</script>

</body>
</html>
