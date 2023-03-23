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
	//onSearch();
	load();
	doEdit();
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
function load() {
	var table = $('#dataTable').DataTable( {
		dom: 'BRlfrti',
		ajax: {
		      "url": "/getAccbookList.do",
		      "dataSrc": ""
	    },
	    columns: [
	        { "data": "BOARD_TYPE" },
	        { "data": "TITLE" },
	        { "data": "CONTENTS" },
	        { "data": "REG_DATE" },
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
					$(td).attr('contenteditable', "true");
      		    }
   			},
   		],
   		createdCell: function (td, cellData, rowData, row, col) {
   	        td.attr('contenteditable', "true");
   	 	},
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
            $("div.toolbar").html('<div class="btn-group">'+$(".dt-buttons").html()+'</div>');
            $(".dataTables_length").appendTo("div.toolbar");
        },
       	buttons: [
			{ 
			  text: "추가",
              action: function ( e, dt, node, config ) { 
            	  doAdd(); 
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
}
	
function doEdit() {
	/* $(document).on("click", ".editable", function() {
		var value=$(this).text();
		var input="<input type='text' class='input-data' value='"+value+"' class='form-control'>";
        $(this).html(input);
        $(this).removeClass("editable");
    });
    $(document).on("blur", ".input-data", function() {
        var value=$(this).val();
        var td=$(this).parent("td");
        $(this).remove();
        td.html(value);
        td.addClass("editable")
        });
    $(document).on("keypress", ".input-data", function(e) {
        var key=e.which;
        if(key==13) {
            var value=$(this).val();
            var td=$(this).parent("td");
            $(this).remove();
            td.html(value);
            td.addClass("editable");
        }
    }); */
}

function doAdd() {
	var table = $('#dataTable').DataTable();
	table.row.add( [
	    'New Data 1',
	    'New Data 2',
	    'New Data 2',
	    'New Data 3'
	] ).draw();
}
// 조회
function onSearch() {
	ajaxSubmit("/getAccbookList.do");	
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
	<table id="dataTable" class="table table-striped table-bordered" style="width:100%">
		<thead>
			<tr>
				<th>유형</th>
				<th>제목</th>
				<th>내용</th>
				<th>등록날짜</th>
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
</body>
</html>