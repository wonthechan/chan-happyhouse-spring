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
			'<button class="btn btn-light" onclick="movePage(' + (startPageIndex - 1) + ')">＜</button>'+
			'</li>';
	}
	
	
	
	
	for(var i=startPageIndex; i<=endPageIndex; i++){
	
		if( i == currentPageIndex ){
			paginationHtml += 
				'<li class="page-item active"><button class="btn btn-primary" onclick="movePage(' + i + ')">'+ i +'</button></li>';			
		}else{
			paginationHtml += 
				'<li class="page-item"><button class="btn btn-light" onclick="movePage(' + i + ')">'+ i +'</button></li>';			
		}
	}
	
	if(next){
		paginationHtml += 
			'<li class="page-item">' +
			'<button class="btn btn-light" onclick="movePage(' + (endPageIndex + 1) + ')">＞</button>'+
			'</li>';
	}

	paginationHtml += '</ul>';
	
	targetUI.html("");
	targetUI.append(paginationHtml);
	
}














