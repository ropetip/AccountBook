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
	
	CO.ajaxSubmit_code("/getCommonCode.do");
	
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
	        { "data": "ACC_ID" },
	        { "data": "CLASS_NM" },
	        { "data": "ITEM_NM" },
	        { "data": "ACC_YMD" },
	        { "data": "ACC_AMT" },
	        { "data": "ASSET_NM" },
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
   			{
     			targets: [0],
     			visible: false,
   		      	searchable: false
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
        font: "Arial Unicode MS",
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
			"copy",
            "excel",
            "pdf",
            "print"
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
		this.style.cursor = "pointer";
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
	CO.ajaxSubmit_dataTable("/getAccbookList.do");	
}

function showDetails(data) {
	const dataModal = document.querySelector("#dataModal");
	
	// 데이터 있는 경우
	if(CO.isObject(data)) {
		const element = dataModal.querySelectorAll("input, select");
		element.forEach( (elem) => {
			const col_id = elem.getAttribute("col-id");
			const data_idx = Object.getOwnPropertyNames(data).indexOf(col_id);
			if( data_idx > -1 ) {
				let value = data[Object.getOwnPropertyNames(data)[data_idx]];
				elem.value = value;  
			}	
		});
	}	
	// 데이터 없는 경우
	else {	
		const elements = document.querySelectorAll("#dataModal select, #dataModal input");
		elements.forEach((elem) => {
			elem.value = "";
		});
	} 
	
    showModal("dataModal");
    // 모달 창 닫기 버튼 클릭 이벤트 처리
    $("#dataModal [data-dismiss='modal']").on("click", function() {
        hideModal("dataModal");
    });
	
}

//조회 완료 후
function onCompleteList() {
	/* const $this = this;
	let dataRow0 = $this.dataTable.querySelector("[row-id='dataRow0']");
	console.log(dataRow0); */
}

// 삭제
function doDelete() {
	const data = new FormData(document.querySelector("#fm"));
	
	CO.confirm("삭제하시겠습니까?", function() {
	  	CO.ajaxSubmit("/deleteAccbook.do", data, (result) => {
	  		// 성공 콜백 함수
	    	alert(result.result_msg);
	    	hideModal("dataModal");
	    	doSearch();
	  	}, (xhr, status, error) => {
	  		// 실패 콜백 함수
	  	    alert("서버와의 통신이 실패하였습니다. (" + error + ")");
	  	});
	});
}

// 유효성 검사
function isValidate(fm){
	const data = new FormData(fm);
	
	for(const [key, value] of data.entries()) {
		if(value == "") {
			const el = document.querySelector("[name='"+key+"']");
			const label = el.parentNode.parentNode.querySelector("label").innerText;
			
			// 필수 값 체크
			if(!el.required) {
				continue;
			}
			
			el.focus(); // 해당 요소에 포커스를 줌
			
			if (el.tagName === "INPUT") {
				const inputType = el.type === "checkbox" ? "체크박스" : "입력 필드";
			  	alert(label + " " + inputType + "에 값을 입력해주세요.");
			  	return;
			} else if (el.tagName === "SELECT") {
			  	alert(label + " 을/를 선택해 주세요.");
			  	return;
			}
		}
	}
	
	return true;
}

// 저장
function doSave() {
	const fm = document.querySelector("#fm");
	const data = new FormData(fm);
	const date = document.querySelectorAll("[type=date]");
	const currency = document.querySelectorAll("[data-type=currency]");
	
	if(!isValidate(fm)) {
		return;
	}
	
	// 날짜 제거
	date.forEach((elem) => {
		if (elem.value) {
		  const newValue = elem.value.replace(/-/g, ""); // - 제거
		  data.set(elem.name, newValue); // 수정된 값으로 set
		}
	});
	
	// 콤마 제거
	currency.forEach((elem) => {
		if (elem.value) {
		  const newValue = elem.value.replace(/,/g, ""); // , 제거
		  data.set(elem.name, newValue); // 수정된 값으로 set
		}
	});
	
	// 키 값 구하기
	/* for(let [key, value] of data.entries()) {
	    console.log(key, value);
	} */
	
	CO.confirm("저장하시겠습니까?", function() {
	  	CO.ajaxSubmit("/saveAccbook.do", data, (result) => {
	  		// 성공 콜백 함수
	    	alert(result.result_msg);
	    	hideModal("dataModal");
	    	doSearch();
	  	}, (xhr, status, error) => {
	  		// 실패 콜백 함수
	  	    alert("서버와의 통신이 실패하였습니다. (" + error + ")");
	  	});
	});
}

</script>
</head>
<body>
	<form id="fm">
		<table id="dataTable" class="table table-striped table-bordered" style="width:100%">
			<thead>
				<tr>
					<th>번호</th>
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
		
		<div class="modal fade" id="dataModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<input type="hidden" id="accId" name="accId" col-id="ACC_ID">
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
								<select col-id="CLASS_NM" set-data="CLASS_CD" name="classNm" 
											class="form-select" aria-label="Default select example" required></select>
							</div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">항목</label>
							<div class="col-sm-10">
								<input col-id="ITEM_NM" name="itemNm" class="form-control" required>
							</div>
						</div>
						<div class="row mb-3">
							<label for="inputDate" class="col-sm-2 col-form-label">일자</label>
							<div class="col-sm-10">
								<input type="date" col-id="ACC_YMD" name="accYmd" class="form-control" required>
							</div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">금액</label>
							<div class="col-sm-10">
								<input data-type="currency" col-id="ACC_AMT" name="accAmt" class="form-control" required>
							</div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">내용</label>
							<div class="col-sm-10">
								<input col-id="NOTE" name="note" class="form-control">
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-danger" name="delBtn" onClick="doDelete();">삭제</button>
						<button type="button" class="btn btn-primary" onClick="doSave();">저장</button>
					</div>
				</div>
			</div>
		</div> <!-- Modal -->
		
	</form>
	
</body>
</html>