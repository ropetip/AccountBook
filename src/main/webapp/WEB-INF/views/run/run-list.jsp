<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>러닝 기록</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">
    <style>
        /* 추가 스타일링 */
        .card {
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 16px;
        }
    </style>
</head>
<body>
    <div class="container mx-auto p-4">
        <!-- 검색 필터 -->
        <div class="mb-4">
            <h2 class="text-lg font-semibold mb-2">검색 필터</h2>
            <form action="yourActionURL" method="GET" class="space-y-4">
                <div class="flex space-x-4">
                    <div class="flex-1">
                        <label for="startDate" class="block text-sm font-medium text-gray-700">시작일</label>
                        <input type="date" id="startDate" name="startDate" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                    </div>
                    <div class="flex-1">
                        <label for="endDate" class="block text-sm font-medium text-gray-700">종료일</label>
                        <input type="date" id="endDate" name="endDate" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                    </div>
                </div>
                <div class="flex space-x-4">
                    <div class="flex-1">
                        <label for="distance" class="block text-sm font-medium text-gray-700">거리 (km)</label>
                        <input type="number" id="distance" name="distance" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                    </div>
                    <div class="flex-1">
                        <label for="pace" class="block text-sm font-medium text-gray-700">페이스 (min/km)</label>
                        <input type="number" id="pace" name="pace" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
                    </div>
                </div>
                <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded-md">검색</button>
            </form>
        </div>

        <!-- 러닝 기록 리스트 -->
        <div>
            <h2 class="text-lg font-semibold mb-2">러닝 기록 리스트</h2>
            <div class="card">
                <h3 class="text-xl font-semibold mb-2"></h3>
                <p>거리: km</p>
                <p>페이스:  min/km</p>
                <p>시간:  %></p>
                <p>칼로리:  kcal</p>
                <div class="mt-2">
                    <a href="mapViewURL?recordId" class="text-blue-500">지도 보기</a>
                </div>
                <button onclick="openDetailsPopup()" class="mt-2 bg-green-500 text-white px-4 py-2 rounded-md">상세보기</button>
            </div>
            <p>러닝 기록이 없습니다.</p>
        </div>
    </div>

    <!-- 상세보기 팝업 (모달) -->
    <div id="detailsPopup" class="fixed inset-0 bg-gray-500 bg-opacity-50 flex items-center justify-center hidden">
        <div class="bg-white p-6 rounded-lg shadow-lg max-w-lg w-full">
            <h3 class="text-xl font-semibold mb-4">상세정보</h3>
            <div id="popupContent"></div>
            <button onclick="closeDetailsPopup()" class="mt-4 bg-red-500 text-white px-4 py-2 rounded-md">닫기</button>
        </div>
    </div>

    <script>
        function openDetailsPopup(recordId) {
            // AJAX 요청을 통해 상세정보를 가져와서 팝업에 표시
            fetch(`/details?recordId=${recordId}`)
                .then(response => response.text())
                .then(data => {
                    document.getElementById('popupContent').innerHTML = data;
                    document.getElementById('detailsPopup').classList.remove('hidden');
                });
        }

        function closeDetailsPopup() {
            document.getElementById('detailsPopup').classList.add('hidden');
        }
    </script>
</body>
</html>
