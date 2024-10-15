/**
 * 
 */
window.addEventListener("load", () => {
	setComma(); // 콤마 세팅
	validateNumberInput(); // number 소수점 제한
});

/**
 *  input[data-type=currency]이라면 자동으로 콤마 세팅
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
/**
 * input[type='number']인 경우 소수점 2자리까지 제어
 */
function checkMaxValue(input) {
	const maxLength = parseInt(input.getAttribute("max-length"), 10);
    const value = input.value;
	
	// 정규 표현식을 사용하여 소수점 2자리까지 입력 제한
	const regex = /^\d*\.?\d{0,2}$/;

    // 입력 값이 정규 표현식과 일치하지 않으면 잘라내기
    if(!regex.test(value)) {
      input.value = value.slice(0, -1); // 마지막 입력 제거
    }
	
	// 입력 길이 검사
	if (maxLength && value.length > maxLength) {
	    input.value = value.slice(0, maxLength); // 최대 길이로 잘라내기
	}
	// min과 max 속성 가져오기
    const min = parseFloat(input.getAttribute("min")) || 0; // 기본값 설정
    const max = parseFloat(input.getAttribute("max")) || 100; // 기본값 설정
	
    // 추가적으로 유효한 숫자인지 검사
    const numericValue = parseFloat(value);
    if (!isNaN(numericValue)) {
        if (numericValue < min) {
            input.value = min; // 최소값으로 설정
        } else if (numericValue > max) {
            input.value = max; // 최대값으로 설정
        }
    }
}

function validateNumberInput() {
	// 입력 요소를 선택
	const inputNumbers = document.querySelectorAll("input[type='number']");

	// 입력 이벤트에 대한 처리
	inputNumbers.forEach(input => {
		input.addEventListener("keyup", function() {
			checkMaxValue(input);
	  	});
		input.addEventListener("change", function() {
			checkMaxValue(input);
	    });
	});
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
	    return !CO.isEmpty(obj);
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
			alert(status + " " + error);
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
				CO.callback_table(data, status, xhr);
			},
			error: function(xhr, status, error) {
				CO.callback_table(xhr, status, error);
			}
		});
	},

	callback_table: function(data, status, error) {
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
			alert(status + " " + error);
		}

		if (typeof onCompleteList === "function") {
			onCompleteList();
		}
	},
	
	// 폼 전송 (페이지 이동)
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
		
		// FormData의 각 항목을 name, value로 input 필드로 변환하여 추가
		for (let [key, value] of formData.entries()) {
		    const inputField = document.createElement('input');
		    inputField.type = 'hidden';
		    inputField.name = key;   // name 설정
		    inputField.value = value; // value 설정
		    form.appendChild(inputField); // form에 추가
		}
		
		// 폼 action 설정 및 method를 POST로 설정
		form.action = url;
		form.method = 'POST';
		
		// 폼 제출
		form.submit();
	},

	// 폼 형식 데이터 세팅
	ajaxSetForm: function(url, data) {
		$.ajax({
			url: url
			, type: "post"
			, data: data
			, dataType: "json"
			, contentType: "application/x-www-form-urlencoded; charset=UTF-8"
			, success: function(data, status, xhr) {
				CO.callback_form(data, status, xhr);
			},
			error: function(xhr, status, error) {
				CO.callback_form(xhr, status, error);
			}
		});
	},
	
	// 폼 형식 콜백
	callback_form: function(data, status, error) {
		if (status == "success") {
			// 폼 필드에 동적으로 값을 설정합니다.
		    for (const [key, value] of Object.entries(data)) {
		        const elementByName = document.querySelector("[name='"+CO.toCamelCase(key)+"']");
		
		        if (elementByName) {
		            // 입력 타입에 따라 값을 설정합니다.
		            switch (elementByName.type) {
		                case 'date':
							const formattedDate = `${value.substring(0, 4)}-${value.substring(4, 6)}-${value.substring(6, 8)}`;
                           	elementByName.value = formattedDate;
		                    break;
		                case 'datetime-local':
		                    // 날짜 및 시간 형식으로 변환
		                    const datetime = new Date(value);
		                    if (!isNaN(datetime.getTime())) { // 유효한 날짜 및 시간인지 확인
		                        elementByName.value = datetime.toISOString().slice(0, 16);
		                    }
		                    break;
		                case 'number':
		                    // 숫자 형식으로 변환
		                    elementByName.value = isNaN(value) ? '' : Number(value);
		                    break;
		                case 'time':
		                    // 시간 형식으로 변환
		                    const time = new Date(`1970-01-01T${value}`);
		                    if (!isNaN(time.getTime())) { // 유효한 시간인지 확인
		                        elementByName.value = time.toTimeString().slice(0, 5);
		                    }
		                    break;
		                default:
		                    // 기타 입력 타입의 경우, 값 디코딩 후 설정
		                    elementByName.value = decodeURIComponent(value);
		                    break;
		            }
		        }
			}
		} else {
			alert(status + " " + error);
		}
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
				goList();
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
	
	// key=value를 key:value JSON 형태로 변환
	convertToJSON: function(str) {
		// 문자열의 앞뒤 중괄호 제거
	    str = str.trim().slice(1, -1).trim();

	    // '='를 ':'로 교체
	    str = str.replace(/=/g, ':');

		// JSON 문자열로 변환하기 위해 키를 카멜케이스로 변환
	   	/*str = str.replace(/(\w+):/g, (match, key) => {
       		return '"' + CO.toCamelCase(key) + '":';
	   	});*/
		
	    // 키와 값을 쌍따옴표로 감싸기
	    str = str.replace(/(\w+):/g, '"$1":');

	    // 값이 문자열인 경우, 쌍따옴표 추가
	    // 여기서는 값에 포함된 특수 문자를 적절히 처리하도록 수정합니다.
	    str = str.replace(/:(\w[\w-]*)/g, ':"$1"');

        // JSON 문자열을 검증 후 파싱
        const jsonString = '{' + str + '}';
        console.log('JSON String:', jsonString); // 디버깅용 출력
        return JSON.parse(jsonString);
	}

};