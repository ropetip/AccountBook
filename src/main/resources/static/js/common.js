/**
 * 
 */
window.addEventListener("load", (e) => {
	setComma();
});

// input[type=currency]이라면 자동으로 콤마 세팅  
function setComma() {
	document.querySelectorAll("[type='currency']").forEach(function(element) {
		element.addEventListener("keyup", function() {
			let currency = document.querySelectorAll("[type='currency']");
			currency.forEach(function(obj, idx) {
				obj.value = comma(uncomma(obj.value));
			});
		});
	});
}

function comma(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
	str = String(str);
	return str.replace(/[^\d]+/g, '');
}

let CO = {
	// 객체 유무 체크
	isObject: function(obj) {
		return typeof obj === "object" && obj !== null;
	},
	// dataTable 그리기
	ajaxSubmit: function(url, data) {
		table.clear().draw();

		$.ajax({
			url: url
			, type: "post"
			, data: data
			, dataType: "json"
			, contentType: "application/x-www-form-urlencoded; charset=UTF-8"
			, success: function(data, status, xhr) {
				table.rows.add(data).draw();
			},
			error: function(xhr, status, error) {
				alert("데이터를 가져오는데 실패하였습니다.");
			}
		});
	},
	
	// 코드매핑
	ajaxSubmit_code: function(url, data) {
		$.ajax({
			url: url
			, type: "post"
			, data: data
			, dataType: "json"
			, contentType: "application/x-www-form-urlencoded; charset=UTF-8"
			, success: function(data, status, xhr) {
				CO.callback_code(data, status, xhr);
			},
			error: function(xhr, status, error) {
				CO.callback_code(xhr, status, error);
			}
		});
	},
	
	callback_code: function(data, status, error) {
		if (status == "success") {
			for (let i = 0; i < data.length; i++) {
				//let keys = Object.getOwnPropertyNames(data[i]);
				console.log(data[i]);
			}
		} else {
			alert(data.responseJSON.status + " " + data.responseJSON.error);
		}
	},
	
	// 테이블 그리기
	ajaxSubmit_table: function(url, data) {
		$.ajax({
			url: url
			, type: "post"
			, data: data
			, dataType: "json"
			, contentType: "application/x-www-form-urlencoded; charset=UTF-8"
			, success: function(data, status, xhr) {
				CO.callback(data, status, xhr);
			},
			error: function(xhr, status, error) {
				CO.callback(xhr, status, error);
			}
		});
	},

	callback: function(data, status, error) {
		const dataTable = document.querySelector("#dataTable");
		const row_id = dataTable.querySelector("[row-id=dataRow]");

		if (status == "success") {

			row_id.classList.add("d-none");

			for (let i = 0; i < data.length; i++) {
				const clone_row_id = row_id.cloneNode(true);
				const col_id = clone_row_id.querySelectorAll("[col-id]");

				clone_row_id.classList.remove("d-none");
				clone_row_id.setAttribute("row-id", "dataRow" + i);
				row_id.parentNode.append(clone_row_id);

				let keys = Object.getOwnPropertyNames(data[i]);

				for (let j = 0; j < keys.length; j++) {

					for (let k = 0; k < col_id.length; k++) {

						if (col_id[k].attributes['col-id'].nodeValue == keys[j].toLowerCase()) {

							col_id[k].innerHTML = data[i][keys[j]];

						}
					}
				}

			}
		} else {
			alert(data.responseJSON.status + " " + data.responseJSON.error);
		}

		if (typeof onCompleteList === "function") {
			onCompleteList();
		}
	},
};