<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.editable { 
	border-radius:5px;
	margin:5px; 
}
</style>
<script>
window.addEventListener("load", (e) => {
	load();
	
	let result = CO.ajaxSubmit_code("/getCommonCode.do");
	console.log(result);
	
	/* let data = {
		CLASS_NM : [
			{"key": "10", "val": "수입"},
			{"key": "20", "val": "지출"}
		],
	}; */
	
	let select = document.querySelectorAll("select");
	select.forEach(function(item){
	    let setData = item.getAttribute("set-data");
	    if(setData.length > 0){
	    	/* let obj = JSON.parse(setData);
	    	console.log(obj); */
	    }
	});
	
});

/* dom 기능
	l: DataTable의 길이 변경(페이지 크기 변경) 컨트롤을 표시합니다.
	f: DataTable의 검색 필드를 표시합니다.
	t: DataTable의 데이터 테이블을 표시합니다.
	i: DataTable의 정보(현재 페이지, 전체 페이지 수, 전체 항목 수 등)를 나타내는 문자열을 표시합니다.
	p: DataTable의 페이지 번호 컨트롤을 표시합니다.
	r: DataTable의 처리 중 메시지(예: "데이터를 로드하는 중...")를 표시합니다.
	B: DataTable의 버튼을 표시합니다.
	C: DataTable의 캡션(표 제목)을 표시합니다.
	S: DataTable의 스크롤바를 표시합니다.
*/
var table; 
function load() {
	table = $('#dataTable').DataTable( {
		dom: 'BRlfrti',
		ajax: {
		      "url": "/getAccbookList.do",
		      "dataSrc": ""
	    },
	    columns: [
	        { "data": "CLASS_NM" },
	        { "data": "ITEM_NM" },
	        { "data": "ACC_YMD" },
	        { "data": "ASSET_NM" },
	        { "data": "ACC_AMT" },
	        { "data": "NOTE" },
      	],
      	columnDefs: [
   			{
     			targets: [-1], defaultContent: "",
      			createdCell: function (td, cellData, rowData, row, col) {
					$(td).attr('contenteditable', "false");
      		    }
   			},
      		{
     			targets: "_all", className: "editable", defaultContent: "",
      			createdCell: function (td, cellData, rowData, row, col) {
					$(td).attr('contenteditable', "false");
      		    }
   			},
   		],
		scrollY: 500,
		scrollCollapse: true,
		editable: true, // 편집 가능 설정
		responsive: false,  //반응형 설정
        autoWidth: false,
        destroy: true,
        processing: true,
        serverSide: false,
        searching: true,    //검색란 표시 설정
        ordering: true,      //글 순서 설정
        paging: false,        //페이징 표시 설정
        pageLength: 10,     //페이지 당 글 개수 설정
        initComplete: function () {
        },
       	buttons: [
			{ 
				text: "추가",
              	action: function ( e, dt, node, config ) { 
            	  	doAdd(); 
           	  	}
            },
            { 
				text: "조회",
              	action: function ( e, dt, node, config ) { 
              		 doSearch();
				}
			},
        ],
		language: {
		    emptyTable: "데이터가 없습니다.",
		    lengthMenu: "페이지당 _MENU_ 개씩 보기",
		    info: "현재 _START_ - _END_ / _TOTAL_건",
		    infoEmpty: "데이터 없음",
		    infoFiltered: "( _MAX_건의 데이터에서 필터링됨 )",
		    //search: "",
		    zeroRecords: "일치하는 데이터가 없습니다.",
		    loadingRecords: "로딩중...",
		    processing: "잠시만 기다려 주세요.",
		    paginate: {
		      next: "다음",
		      previous: "이전",
		    },
		 },
    } );
	
	$("#dataTable tbody").on("click", "tr", function() {	
		const isEmptyTable = this.querySelector(".dataTables_empty") !== null ? true : false;
		if(!isEmptyTable) {
			let data = table.row(this).data(); // 클릭된 행의 데이터 가져오기
			showDetails(data); // 상세 정보 보여주는 함수 호출	
		}
	});
	
}

function doAdd() {
	/* let fm = document.querySelector("#fm");
	fm.setAttribute("method", "post");
	fm.setAttribute("action", "accbookDetail.do");
	fm.submit(); */
	
	showDetails();
	
	/* 행 추가 
	var table = $('#dataTable').DataTable();
	table.row.add( [
	    'New Data 1',
	    'New Data 2',
	    'New Data 2',
	    'New Data 3'
	] ).draw(); */
}
// 조회
function doSearch() {
	/* table.clear().draw();
	$.ajax({
		url: "/getAccbookList.do",
		success: function(data) {
		  	table.rows.add(data).draw();
		},
		error: function() {
			alert("데이터를 가져오는데 실패하였습니다.");
		}
	}); */
	CO.ajaxSubmit("/getAccbookList.do");	
}

function showDetails(data) {
	if(CO.isObject(data)) {
		const modalBody = document.querySelector(".modal-body");
		let input = modalBody.querySelectorAll("input");
		input.forEach( (elem) => {
			let col_id = elem.getAttribute("col-id");
			let data_idx = Object.getOwnPropertyNames(data).indexOf(col_id);
			if( data_idx > -1 ) {
				elem.value = data[Object.getOwnPropertyNames(data)[data_idx]]; 
			}	
		});
	}
    $("#dataModal").modal("show");
    // 모달 창 닫기 버튼 클릭 이벤트 처리
    $("#dataModal [data-dismiss='modal']").on("click", function() {
        $("#dataModal").modal("hide");
    });
}

//조회 완료 후
function onCompleteList() {
	/* const $this = this;
	let dataRow0 = $this.dataTable.querySelector("[row-id='dataRow0']");
	console.log(dataRow0); */
}
</script>
</head>
<body>
	<form id="fm">
		<table id="dataTable" class="table table-striped table-bordered" style="width:100%">
			<thead>
				<tr>
					<th>분류</th>
					<th>항목</th>
					<th>일자</th>
					<th>금액</th>
					<th>자산</th>
					<th>내용</th>
				</tr>	
	       	</thead>
	       	<tbody>
	       		<!-- <tr row-id="dataRow">
	       			<td col-id="board_type"></td>
	       			<td col-id="title"></td>
	       			<td col-id="contents"></td>
	       			<td col-id="reg_date"></td>
	       		</tr> -->
	       	</tbody>
		</table>
	</form>
	
	<!-- Modal -->
	<div class="modal fade" id="dataModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">가계부 상세</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label">분류</label>
						<div class="col-sm-10">
							<select set-data="data.CLASS_NM" class="form-select" aria-label="Default select example"></select>
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label">항목</label>
						<div class="col-sm-10">
							<input col-id="ITEM_NM" class="form-control">
						</div>
					</div>
					<div class="row mb-3">
						<label for="inputDate" class="col-sm-2 col-form-label">일자</label>
						<div class="col-sm-10">
							<input type="date" class="form-control">
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label">금액</label>
						<div class="col-sm-10">
							<input type="currency" col-id="ACC_AMT" class="form-control">
						</div>
					</div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label">내용</label>
						<div class="col-sm-10">
							<input col-id="NOTE" class="form-control">
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>