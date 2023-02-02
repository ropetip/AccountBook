<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
window.addEventListener("load", (e) => {
	onSearch();
});

function onSearch() {
	ajaxSubmit("/getAccbookList.do", null, callback);	
}

function callback(data, status, error) {
	const dataTable = document.querySelector("#dataTable");
	const row_id = dataTable.querySelector("[row-id=dataRow]");
	row_id.classList.add("d-none");
	
	if(status == "success") {

		for(let i=0; i<data.length; i++) {
			const clone_row_id = row_id.cloneNode(true);
			const col_id = clone_row_id.querySelectorAll("[col-id]");
			
			clone_row_id.classList.remove("d-none");
			clone_row_id.setAttribute("row-id", "dataRow"+i);
			row_id.parentNode.append(clone_row_id);
			
			let keys = Object.getOwnPropertyNames(data[i]);
			
			for(let j=0; j<keys.length; j++) {
				
				for(let k=0; k<col_id.length; k++) {
					
					if(col_id[k].attributes['col-id'].nodeValue == keys[j].toLowerCase()) {
						
						col_id[k].innerHTML = data[i][keys[j]];
						
					}
				}
			}
			
		}
	} else {
		alert(data.responseJSON.status +" "+ data.responseJSON.error);
	}
	
	$("#dataTable").DataTable();
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
       		<tr row-id="dataRow">
       			<td col-id="board_type"></td>
       			<td col-id="title"></td>
       			<td col-id="contents"></td>
       			<td col-id="reg_date"></td>
       		</tr>
       	</tbody>
	</table>
	
</body>
</html>