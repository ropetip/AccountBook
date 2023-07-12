<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bignumber.js/8.0.2/bignumber.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
<script>
$(document).ready(function () {
	$('input[name="rate"]').on('input', function () {
		var totalAmt = parseFloat($('#std_amt').val());
		var prepaidRate = parseFloat($('input[name="rate"]').eq(0).val());
		var installmentRate = parseFloat($('input[name="rate"]').eq(1).val());
		
		var prepaidAmt = (prepaidRate * totalAmt) / 100;
		var installmentAmt = (installmentRate * totalAmt) / 100;
		var balanceAmt = totalAmt - prepaidAmt - installmentAmt;
		var balanceRate = (balanceAmt / totalAmt) * 100;
		
		$('input[name="amt"]').eq(0).val(prepaidAmt.toFixed(0));
		$('input[name="amt"]').eq(1).val(installmentAmt.toFixed(0));
		$('input[name="amt"]').eq(2).val(balanceAmt.toFixed(0));
		$('input[name="rate"]').eq(2).val(balanceRate.toFixed(2));
		
		updateTotal(); // 합계 업데이트
	});

	// 선급금, 중도금의 지급액 입력 시 계산
	$('input[name="amt"]').on('input', function () {
		var totalAmt = parseFloat($('#std_amt').val());
		var prepaidAmt = parseFloat($('input[name="amt"]').eq(0).val());
		var installmentAmt = parseFloat($('input[name="amt"]').eq(1).val());
		
		var prepaidRate = (prepaidAmt / totalAmt) * 100;
		var installmentRate = (installmentAmt / totalAmt) * 100;
		var balanceAmt = totalAmt - prepaidAmt - installmentAmt;
		var balanceRate = (balanceAmt / totalAmt) * 100;
		
		$('input[name="rate"]').eq(0).val(prepaidRate.toFixed(2));
		$('input[name="rate"]').eq(1).val(installmentRate.toFixed(2));
		$('input[name="amt"]').eq(2).val(balanceAmt.toFixed(0));
		$('input[name="rate"]').eq(2).val(balanceRate.toFixed(2));
		
		updateTotal(); // 합계 업데이트
	});

	// 합계 업데이트 함수
	function updateTotal() {
		var sumRate = 0;
		var sumAmt = 0;
	
		$('input[name="rate"]').each(function () {
	  	var rate = parseFloat($(this).val());
	 		 if (!isNaN(rate)) {
	   			sumRate += rate;
	  		}
		});
	
		$('input[name="amt"]').each(function () {
		  	var amt = parseFloat($(this).val());
		  	if (!isNaN(amt)) {
		    	sumAmt += amt;
		  	}
		});
	
		$('input[name="sum_rate"]').val(sumRate.toFixed(2));
		$('input[name="sum_amt"]').val(sumAmt.toFixed(0));
	}
});
</script>

</head>

<body>
	<div>
		<span>총 금액:</span>
		<input id="std_amt" type="number" value="10000"> 
	</div>
	<div  class="col-lg-4">
		<table class="table">
			<thead>
				<tr>
					<th>구분</th>
					<th>지급율</th>
					<th>지급액</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>선급금</th>
					<td><input name="rate" step="0.01" min="0" max="100"></td>
					<td><input name="amt"></td>
				</tr>
				<tr>
					<th>중도금</th>
					<td><input name="rate" step="0.01" min="0" max="100"></td>
					<td><input name="amt"></td>
				</tr>
				<tr>
					<th>잔금</th>
					<td><input name="rate" readonly style="background-color:lightgrey"></td>
					<td><input name="amt" readonly style="background-color:lightgrey"></td>
				</tr>
				<tr>
					<th>합계</th>
					<td><input name="sum_rate" readonly style="background-color:lightgrey"></td>
					<td><input name="sum_amt" readonly style="background-color:lightgrey"></td>
				</tr>
			</tbody>
		</table>
	</div>
</body>

</html>
