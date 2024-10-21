<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>러닝 기록</title>
<style>
    /* 추가 스타일링 */
    .card {
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        padding: 16px;
        margin-bottom: 16px;
    }
</style>
    
<script>
window.addEventListener("load", (e) => {
	load();
});

function getData(data){
	CO.ajaxSetForm("/getRunDetail.do", data);
}

function load() {

	let jsonString = "${param}";

	//JSON 문자열을 JavaScript 객체로 변환
	let param = CO.convertToJSON(jsonString);
	
	if(!param.isNew) {
		getData(param);	
	}
}

function getConvertedData(data) {
	for (const [key, value] of Object.entries(data)) {
		if(CO.toCamelCase(key) == "duration") {
			let duration = value.split(":");
			document.querySelector("#hours").value = duration[0];
			document.querySelector("#minutes").value = duration[1];
			document.querySelector("#seconds").value = duration[2];
		}
	}
}

function setConvertedData(formData) {
	let hours = document.querySelector("#hours").value;
	let minutes = document.querySelector("#minutes").value;
	let seconds = document.querySelector("#seconds").value;
	
	let duration = CO.zeroToFill(hours, 1)+":"+CO.zeroToFill(minutes, 1)+":"+CO.zeroToFill(seconds, 1);
	console.log("duration=>"+duration);
	// 새로운 input 요소 생성
    var hiddenInput = document.createElement("input");
    hiddenInput.type = "hidden";
    hiddenInput.name = "duration";
    hiddenInput.value = duration;
    
    // 폼에 hidden input 추가
    document.querySelector("#fm").appendChild(hiddenInput);
    
    formData.set(hiddenInput.name, hiddenInput.value);
    return formData;
}
//저장
function doSave() {
	CO.doSave("/saveRun.do");
}

//삭제
function doDelete() {
	CO.doDelete("/deleteRun.do");
}

function goList() {
	go("runList.do");
}
</script>

</head>
<body>
    <div class="container">
        <div class="d-flex justify-content-end mb-3">
            <input type="button" class="btn btn-success me-2" onclick="doSave();" value="저장">
            <input type="button" class="btn btn-danger me-2" onclick="doDelete();" value="삭제">
            <input type="button" class="btn btn-primary" onclick="goList();" value="목록">
        </div>

		<div class="card">
		    <div class="card-body">
		        <h5 class="card-title">러닝 기록 입력 폼</h5>
		
		        <!-- 러닝 기록 입력 폼 -->
				<form id="fm">
					<div class="d-none row mb-3">
			            <label for="runId" class="col-sm-2 col-form-label">러닝 ID</label>
			            <div class="col-sm-10">
			                <input type="text" class="form-control" id="runId" name="runId">
			            </div>
			        </div>
			        <div class="d-none row mb-3">
			            <label for="usrId" class="col-sm-2 col-form-label">사용자 ID</label>
			            <div class="col-sm-10">
			                <input type="text" class="form-control" id="usrId" name="usrId">
			            </div>
			        </div>
			        <div class="row mb-3">
			            <label for="runYmd" class="col-sm-2 col-form-label">러닝 날짜</label>
						<div class="col-sm-10">
				    		<input type="date" class="form-control" id="runYmd" name="runYmd" required>
						</div>
			        </div>
			        <div class="row mb-3">
			            <label for="startDt" class="col-sm-2 col-form-label">러닝 시작 시간</label>
			            <div class="col-sm-10">
			                <input type="time" class="form-control" id="startDt" name="startDt" required>
			            </div>
			        </div>
			        <div class="row mb-3">
			            <label for="endDt" class="col-sm-2 col-form-label">러닝 종료 시간</label>
			            <div class="col-sm-10">
			                <input type="time" class="form-control" id="endDt" name="endDt">
			            </div>
			        </div>
			        <div class="row mb-3">
			            <label for="distance" class="col-sm-2 col-form-label">러닝 거리 (km)</label>
			            <div class="col-sm-10">
			                <input type="number" step="0.01" class="form-control" id="distance" name="distance" max-length="6">
			            </div>
			        </div>
			        <div class="row mb-3">
						<label for="duration" class="col-sm-2 col-form-label">러닝 소요 시간</label>
						<div class="col-sm-3">
					  		<div class="time-input">
						        <input type="number" class="form-control" id="hours" min="0" max="23" placeholder="HH">
						        <input type="number" class="form-control" id="minutes" min="0" max="59" placeholder="MM">
						        <input type="number" class="form-control" id="seconds" min="0" max="59" placeholder="SS">
					    	</div>
				    	</div>
					</div>
					<div class="row mb-3">
					    <label for="pace" class="col-sm-2 col-form-label">러닝 페이스 (1km 기준)</label>
					    <div class="col-sm-10">
					        <input type="time" class="form-control" id="pace" name="pace">
					    </div>
					</div>
					<div class="row mb-3">
					    <label for="caloriesBurned" class="col-sm-2 col-form-label">소모된 칼로리</label>
					    <div class="col-sm-10">
					        <input type="number" step="0.01" class="form-control" id="caloriesBurned" name="caloriesBurned">
					    </div>
					</div>
					<div class="row mb-3">
					    <label for="route" class="col-sm-2 col-form-label">러닝 경로 정보</label>
					    <div class="col-sm-10">
					        <textarea class="form-control" id="route" name="route" style="height: 100px"></textarea>
					    </div>
					</div>
					<div class="row mb-3">
					    <label for="note" class="col-sm-2 col-form-label">메모 / 코멘트</label>
					    <div class="col-sm-10">
					        <textarea class="form-control" id="note" name="note" style="height: 100px"></textarea>
					    </div>
					</div>
					<div class="row mb-3">
					    <label for="weather" class="col-sm-2 col-form-label">날씨 조건</label>
					    <div class="col-sm-10">
					        <input type="text" class="form-control" id="weather" name="weather">
					    </div>
					</div>
					<div class="row mb-3">
					    <label for="gear" class="col-sm-2 col-form-label">사용 장비 / 신발</label>
					    <div class="col-sm-10">
					        <input type="text" class="form-control" id="gear" name="gear">
					    </div>
					</div>
					<div class="row mb-3">
					    <div class="col-sm-10 offset-sm-2 text-end">
					        <button type="submit" class="btn btn-primary">제출</button>
					    </div>
					</div>
		       </form>
		       <!-- End 러닝 기록 입력 폼 -->
	        </div>
	    </div>
	</div>
</body>


</html>
