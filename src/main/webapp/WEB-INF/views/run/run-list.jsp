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
	
	const CLASS_CD = {codeTypeId: 'CLASS_CD'};
	CO.ajaxSubmit_code("/getCommonCode.do", CLASS_CD); 
	
	const ASSET_CD = {codeTypeId: 'ASSET_CD'};
	CO.ajaxSubmit_code("/getCommonCode.do", ASSET_CD);
	
});

var table; 
	
function load() {
	table = $('#dataTable').DataTable( {
		dom: 'BRlfrti',
		ajax: {
		      "url": "/getAccbookList.do",
		      "dataSrc": ""
	    },
	    columns: [
	        { "data": "RUN_ID" },
	        { "data": "USR_ID" },,
	        { "data": "RUN_YMD" },
	        { "data": "DISTANCE" },
	        { "data": "DURATION" },
	        { "data": "PACE" },
	        { "data": "CALORIES_BURNED" },
	        { "data": "ROUTE" },
      	],
      	// 컬럼 설정
      	columnDefs: [
      		{ targets: [0], width: "0", className: "text-center", visible: false, searchable: false},
      		{ targets: [1], width: "14%", className: "text-center"},
      		{ targets: [2], width: "12%", className: "text-center"},
      		{ targets: [3], width: "12%", className: "text-center"},
      		{ targets: [4], width: "12%", className: "text-right"},
      		{ targets: [5], width: "12%", className: "text-center"},
      		{ targets: [6], width: "12%", className: "text-center"},
      		{ targets: [7], width: "*", className: "text-left"},
      		{
     			targets: "_all", className: "cursor-pointer", defaultContent: "",
      			createdCell: function (td, cellData, rowData, row, col) {
					$(td).attr('contenteditable', "false");
      		    },
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
	CO.ajaxSubmit_dataTable("/getAccbookList.do");	
}

function showDetails(data) {
 	submitForm("/runDetail.do", data);
}

function submitForm(url, gridData, formId) {
	if(CO.isEmpty(formId)) formId = "fm";
	
    const form = document.getElementById(formId);
    
    // 유효성 검사
    if (!isValidate(form)) {
        return;
    }

    // FormData를 이용해 form 데이터 가져오기
    const formData = new FormData(form);

 	// gridData가 있을 경우, FormData에 추가
    if (gridData && typeof gridData === "object") {
        for (const key in gridData) {
            if (gridData.hasOwnProperty(key)) {
                formData.append(key, gridData[key]);
            }
        }
    }

    // form 데이터 확인 (옵션)
    for (let [key, value] of formData.entries()) {
        console.log(key, value);
    }

    // 폼 action 설정
    form.action = url;

    // 폼 제출
    form.submit();
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
	for(let [key, value] of data.entries()) {
	    console.log(key, value);
	}
	
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
					<th>runId</th>
					<th>사용자</th>
					<th>날짜</th>
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
	
</body>
</html>