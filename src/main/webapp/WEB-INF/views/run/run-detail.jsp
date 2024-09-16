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


function load() {
	// param 문자열을 파싱하여 객체로 변환
    const paramString = "${param}";
    const params = new URLSearchParams(paramString.replace("{data=", ""));

 	// params 객체를 순회하면서 폼 필드에 값 매핑
    params.forEach((value, key) => {
        // 카멜케이스로 변환된 key로 폼 필드 검색
        const camelCaseKey = CO.toCamelCase(key);

        // 커스텀 속성으로 검색
        if (camelCaseKey) {
	        const elementByCustomAttr = document.querySelector("[name="+camelCaseKey+"]");
	        if (elementByCustomAttr) {
                // Determine input type
               switch (elementByCustomAttr.type) {
                    case 'date':
                        // Convert to yyyy-MM-dd format
                        const date = new Date(value);
                        if (!isNaN(date.getTime())) { // Check if date is valid
                            elementByCustomAttr.value = date.toISOString().split('T')[0];
                        }
                        break;
                    case 'datetime-local':
                        // Convert to yyyy-MM-ddThh:mm format
                        const datetime = new Date(value);
                        if (!isNaN(datetime.getTime())) { // Check if datetime is valid
                            elementByCustomAttr.value = datetime.toISOString().slice(0, 16);
                        }
                        break;
                    case 'number':
                        // Ensure value is a number
                        elementByCustomAttr.value = isNaN(value) ? '' : Number(value);
                        break;
                    case 'time':
                        // Convert to hh:mm format
                        const time = new Date(value);
                        if (!isNaN(time.getTime())) { // Check if time is valid
                            elementByCustomAttr.value = time.toTimeString().slice(0, 5);
                        }
                        break;
                    default:
                        // For other input types, just decode and set the value
                        elementByCustomAttr.value = decodeURIComponent(value);
                        break;
                }
                return;
            }
        }
    });
}
//저장
function doSave() {
	CO.doSave("/saveRun.do", "fm");
}

//삭제
function doDelete() {
	CO.doDelete("/deleteRun.do", "fm");
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
		                   <input type="datetime-local" class="form-control" id="startDt" name="startDt" required>
		               </div>
		           </div>
		           <div class="row mb-3">
		               <label for="endDt" class="col-sm-2 col-form-label">러닝 종료 시간</label>
		               <div class="col-sm-10">
		                   <input type="datetime-local" class="form-control" id="endDt" name="endDt">
		               </div>
		           </div>
		           <div class="row mb-3">
		               <label for="distance" class="col-sm-2 col-form-label">러닝 거리 (km)</label>
		               <div class="col-sm-10">
		                   <input type="number" step="0.01" class="form-control" id="distance" name="distance">
		               </div>
		           </div>
		           <div class="row mb-3">
		               <label for="duration" class="col-sm-2 col-form-label">러닝 소요 시간</label>
		               <div class="col-sm-10">
		                   <input type="time" class="form-control" id="duration" name="duration">
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
