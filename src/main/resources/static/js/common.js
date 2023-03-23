/**
 * 공통 JS
 */

function ajaxSubmit(url, data) {
	$.ajax({
		url: url
		, type: "post"
		, data: data
		, dataType: "json"
		, contentType: "application/x-www-form-urlencoded; charset=UTF-8"
		, success: function(data, status, xhr) {
			callback(data, status, xhr);
		},
		error: function(xhr, status, error) {
			callback(xhr, status, error);
		}
	});
}

function callback(data, status, error) {
	const dataTable = document.querySelector("#dataTable");
	const row_id = dataTable.querySelector("[row-id=dataRow]");
	
	if(status == "success") {
	
		row_id.classList.add("d-none");
	
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
	
	if(typeof onCompleteList === "function") {
	    onCompleteList();
	}
	
}