/**
 * 
 */
window.addEventListener("load", () => {
	setComma();
});

/** input[data-type=currency]이라면 자동으로 콤마 세팅
 */   
function setComma() {
	document.querySelectorAll("[data-type='currency']").forEach(function(element) {
		element.addEventListener("keyup", function() {
			let currency = document.querySelectorAll("[data-type='currency']");
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

/** 날짜 형식으로 변환 
	dateStr: 입력 값
	type: 날짜 구분 값 
*/
function formatDate(dateStr, type) {
	return `${dateStr.slice(0, 4)}`+type+`${dateStr.slice(4, 6)}`+type+`${dateStr.slice(6, 8)}`;
}

function showModal(modal_id) {
	$("#"+modal_id).modal("show");
}

function hideModal(modal_id) {
	$("#"+modal_id).modal("hide");
}

let CO = {
	// 객체가 비어있는지 확인하는 함수
	isEmpty: function(obj) {
	    // null, undefined 체크
	    if (obj === null || obj === undefined) return true;
	    
	    // 객체가 배열, 문자열일 경우 length 체크
	    if (typeof obj === 'string' || Array.isArray(obj)) {
	        return obj.length === 0;
	    }

	    // 객체가 일반 객체일 경우 key 체크
	    if (typeof obj === 'object') {
	        return Object.keys(obj).length === 0;
	    }

	    return false; // 나머지 경우는 비어있지 않다고 가정
	},

	// 객체가 비어있지 않은지 확인하는 함수
	isNotEmpty: function(obj) {
	    return !isEmpty(obj);
	},
	
	//카멜케이스로 변환할 함수
	toCamelCase: function(str) {
	    return str.toLowerCase().replace(/_([a-z])/g, (g) => g[1].toUpperCase());
	},
	
	// confirm창
	confirm: function(message, callback) {
		if (confirm(message)) {
	    	callback();
		}
	},
	
	// ajax 전송
	ajaxSubmit: function(url, data, onSucess, onError) {
		$.ajax({
			url: url
			, type: "post"
			, data: data
			, dataType: "json"
			, processData: false // FormData를 사용할 때는 false로 설정
		    , contentType: false // FormData를 사용할 때는 false로 설정
			, success: onSucess
			, error: onError
		});
	},
	
	// dataTable 그리기
	ajaxSubmit_dataTable: function(url, data) {
		table.clear().draw();

		$.ajax({
			url: url
			, type: "get"
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
				const code = data[i].CODE;
				const codeNm = data[i].CODE_NM;
				
				const select = document.querySelectorAll("select");
					
				select.forEach(function(item) {
					  
			        // "선택" 옵션 추가
			        if (!item.querySelector('option[value=""]')) {
						const option = document.createElement("option");
						option.value = "";
						option.text = "선택";
						item.appendChild(option);
			        }
					// 데이터 옵션 추가
					const setData = item.getAttribute("set-data");
					if(code === setData) {
						const option = document.createElement("option");
						option.value = codeNm;
						option.text = codeNm;
						item.appendChild(option);
					}
					
				});
			}
		} else {
			alert(data.responseJSON.status + " " + data.responseJSON.error);
		}
	},
	
	// 테이블 그리기
	ajaxSubmit_table: function(url, data) {
		$.ajax({
			url: url
			, type: "get"
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
	
	submitForm: function(url, data, formId) {
		if(CO.isEmpty(formId)) formId = "fm";
		
	    const form = document.getElementById(formId);
	    
	    // 유효성 검사
	    if (!CO.isValidate(form)) {
	        return;
	    }

		// FormData를 이용해 form 데이터 가져오기
		let formData = new FormData(form);

		// data가 있을 경우, FormData에 추가
		if (data && typeof data === "object") {
		    for (const key in data) {
		        if (data.hasOwnProperty(key)) {
		            formData.append(key, data[key]);
		        }
		    }
		}

		// FormData를 URLSearchParams로 변환하여 쿼리 문자열로 변환
		const queryString = new URLSearchParams(formData).toString();

		// 폼 action 설정 및 method를 POST로 설정
		form.action = url;
		form.method = 'POST';

		// 쿼리 문자열을 hidden 필드로 추가
		const hiddenField = document.createElement('input');
		hiddenField.type = 'hidden';
		hiddenField.name = 'data';
		hiddenField.value = queryString;
		form.appendChild(hiddenField);

		// 폼 제출
		form.submit();
	},

	//삭제
	doDelete: function(url, formId) {
		if(CO.isEmpty(formId)) formId = "fm";
		
		const fm = document.getElementById(formId);
		let data = new FormData(fm);
		
		CO.confirm("삭제하시겠습니까?", function() {
		  	CO.ajaxSubmit(url, data, (result) => {
		  		// 성공 콜백 함수
		    	alert(result.result_msg);
		    	doSearch();
		  	}, (xhr, status, error) => {
		  		// 실패 콜백 함수
		  	    alert("서버와의 통신이 실패하였습니다. (" + error + ")");
		  	});
		});
	},
	
	// 저장
	doSave: function(url, formId) {
		if(CO.isEmpty(formId)) formId = "fm";
		
		const fm = document.getElementById(formId);
		let data = new FormData(fm);
		
		if(!CO.isValidate(fm)) {
			return;
		}
		
		// 날짜,콤마 제거 및 NULL 처리
	    data = CO.convertFormData(data);
		
	 	CO.confirm("저장하시겠습니까?", function() {
		  	CO.ajaxSubmit(url, data, (result) => {
		  		// 성공 콜백 함수
		    	alert(result.result_msg);
		  	}, (xhr, status, error) => {
		  		// 실패 콜백 함수
		  	    alert("서버와의 통신이 실패하였습니다. (" + error + ")");
		  	});
		});
	},

	// 유효성 검사
	isValidate: function(fm){
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
	},
	
	// 폼 데이터 변환 
	convertFormData: function(formData) {
	    const date = document.querySelectorAll("[type=date]");
	    const currency = document.querySelectorAll("[data-type=currency]");
	    
	    // 날짜 제거
	    date.forEach((elem) => {
	        if (elem.value) {
	            const newValue = elem.value.replace(/-/g, ""); // - 제거
	            formData.set(elem.name, newValue); // 수정된 값으로 set
	        }
	    });

	    // 콤마 제거
	    currency.forEach((elem) => {
	        if (elem.value) {
	            const newValue = elem.value.replace(/,/g, ""); // , 제거
	            formData.set(elem.name, newValue); // 수정된 값으로 set
	        }
	    });
		
		// 빈 문자열을 NULL로 변환
	  	/*const transformedData = new FormData();
	  	for (const [key, value] of formData.entries()) {
	      	transformedData.append(key, value === '' ? null : value);
	  	}*/
	
	  	return formData;
	},

};