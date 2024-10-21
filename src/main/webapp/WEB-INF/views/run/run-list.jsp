<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
</style>
<script>
window.addEventListener("load", (e) => {
	load();
	/* 
	const CLASS_CD = {codeTypeId: 'CLASS_CD'};
	CO.ajaxSubmit_code("/getCommonCode.do", CLASS_CD); 
	
	const ASSET_CD = {codeTypeId: 'ASSET_CD'};
	CO.ajaxSubmit_code("/getCommonCode.do", ASSET_CD);
	 */
});

var table; 
	
function load() {
	table = $('#dataTable').DataTable( {
		dom: 'BRlfrti',
		ajax: {
		      "url": "/getRunList.do",
		      "dataSrc": ""
	    },
	    columns: [
	        { "data": "RUN_ID" },
	        { "data": "USR_ID" },
	        { "data": "RUN_YMD"
        	 ,"render": function (data, type, row) {
		            if (data) {
		                // 날짜 문자열의 형식을 YYYYMMDD에서 YYYY-MM-DD로 변환
		                return data.substring(0, 4) + '-' + data.substring(4, 6) + '-' + data.substring(6, 8);
		            }
	                return data;
            	}
        	},
        	{ "data": "START_DT",
        		"render": function (data, type, row) {
		            if (data) {
		                return data.substring(0, 5);
		            }
	                return data;
            	}
        	},
	        { "data": "END_DT",
        		"render": function (data, type, row) {
		            if (data) {
            	 		return data.substring(0, 5);
		            }
	                return data;
            	}
        	},
	        { "data": "DISTANCE" },
	        { "data": "DURATION" },
	        { "data": "PACE" },
	        { "data": "CALORIES_BURNED" },
	        { "data": "ROUTE" },
      	],
      	// 컬럼 설정
      	columnDefs: [
      		{ targets: [0], width: "0", className: "text-center", visible: false, searchable: false},
      		{ targets: [1], width: "12%", className: "text-center"},
      		{ targets: [2], width: "12%", className: "text-center"},
      		{ targets: [3], width: "12%", className: "text-center"},
      		{ targets: [4], width: "12%", className: "text-center"},
      		{ targets: [5], width: "12%", className: "text-center"},
      		{ targets: [6], width: "12%", className: "text-center"},
      		{ targets: [6], width: "12%", className: "text-center"},
      		{ targets: [7], width: "12%", className: "text-center"},
      		{ targets: [8], width: "*", className: "text-left"},
      		{
     			targets: "_all", className: "cursor-pointer", defaultContent: "",
      			createdCell: function (td, cellData, rowData, row, col) {
					$(td).attr('contenteditable', "false");
      		    },
   			},
   		],
		scrollY: 500,
		scrollCollapse: true,
		editable: false, // 편집 가능 설정
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
		rowCallback: function(row, data, index) {
			$(row).hover(
				function() {
					$(this).addClass('highlight');
				},
				function() {
					$(this).removeClass('highlight');
				}
	    	);
		},
       	buttons: [
       		{ 
				text: "이미지",
				className: "btn-primary",
              	action: function ( e, dt, node, config ) {
              		html2canvas(document.querySelector('.dataTables_scroll')).then(function(canvas) {
              		    // 캡처된 이미지를 파일로 저장합니다.
              		    var link = document.createElement('a');
              		    link.download = 'dataTable.png';
              		    link.href = canvas.toDataURL();
              		    link.click();
              		});
				}
			},
			{ 
				text: "추가",
				className: "btn-primary",
              	action: function ( e, dt, node, config ) { 
            	  	doAdd(); 
           	  	}
            },
            { 
				text: "조회",
				className: "btn-primary",
              	action: function ( e, dt, node, config ) { 
              		 doSearch();
				}
			},
			{
				extend: "copy",
				className: "btn-primary",
			},
			{
				extend: 'excel',
				text: 'Excel',
				className: "btn-primary",
				exportOptions: {
					columns: ':visible:not(:first-child)' // 첫 번째 컬럼을 제외한 모든 보이는 컬럼 선택
				}
			},
			{
				extend: 'pdf',
				text: 'Pdf',
				className: "btn-primary",
				exportOptions: {
					columns: ':visible:not(:first-child)' // 첫 번째 컬럼을 제외한 모든 보이는 컬럼 선택
				}
			},
			{
				extend: "print",
				className: "btn-primary",
			},
        ],
		language: {
		    emptyTable: "데이터가 없습니다.",
		    lengthMenu: "페이지당 _MENU_ 개씩 보기",
		    info: "현재 _START_ - _END_ / _TOTAL_건",
		    //infoEmpty: "데이터 없음",
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
		//this.style.cursor = "pointer";
		const isEmptyTable = this.querySelector(".dataTables_empty") !== null ? true : false;
		if(!isEmptyTable) {
			let data = table.row(this).data(); // 클릭된 행의 데이터 가져오기
			showDetails(data); // 상세 정보 보여주는 함수 호출	
		}
	});
	
}

function doAdd() {
	showDetails();
}
// 조회
function doSearch() {
	CO.ajaxSubmit_dataTable("/getRunList.do");	
}

function showDetails(data) {
	let obj = {};
	
	if(CO.isNotEmpty(data)) {
		obj.runId = data.RUN_ID;	
	} else {
		obj.isNew = true;
	}
	
 	CO.submitForm("/runDetail.do", obj);
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
<div id="run-list-content">
	<form id="fm">
		<table id="dataTable" class="table table-striped table-bordered" style="width:100%">
			<thead>
				<tr>
					<th>ID</th>
					<th>사용자</th>
					<th>날짜</th>
					<th>시작 시간</th>
					<th>종료 시간</th>
					<th>거리(km)</th>
					<th>소요 시간</th>
					<th>페이스(min/km)</th>
					<th>칼로리 소모</th>					
					<th>지도보기</th>
				</tr>	
	       	</thead>
	       	<tbody>
	       	</tbody>
		</table>
	</form>
</div>
</body>
</html>