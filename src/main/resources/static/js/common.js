/**
 * 공통 JS
 */

function ajaxSubmit(url, data, callback) {
	$.ajax({
		url: url
		, type: "post"
		, data: data
		, dataType: "json"
		, contentType: "application/x-www-form-urlencoded; charset=UTF-8"
		, success: function(data, status, xhr) {
			if(callback != undefined) return callback(data, status, xhr);
		},
		error: function(xhr, status, error) {
			if(callback != undefined) return callback(xhr, status, error);
		}
	});
}
