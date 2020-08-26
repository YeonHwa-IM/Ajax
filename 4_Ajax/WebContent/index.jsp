<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.4.1.min.js"></script>
<style>
	body{background: beige;}
	.test{width: 300px; min-height: 50px; border: 1px solid red;}
</style>
</head>
<body>
	<h1>jQuery를 통한 Ajax 구현</h1>
		
	<h3>1. 버튼 선택 시 전송 값 서버에 출력</h3>
	이름 : <input type ="text" id="myName">
	<button id="nameBtn">이름전송</button>
	<script>
		$('#nameBtn').click(function(){
			var name = $('#myName').val();
			//console.log(name); 확인
			
			$.ajax({
				url: 'jQueryTest1.do',
				data : {name:name}, 
				//앞의 네임을 바뀌어도 되는애
				type:'post',
				success: function(data){
					console.log('서버 성공시 호출되는 함수');
				},
				error: function(data){
					console.log('서버전송 실패 시 호출되는 함수');
				},
				complete : function(data){
					console.log('성공여부에 상관없이 무조건 호출되는 함수');
				}
				
			});
		});
	
	</script>
	
	<br>
	
	<h3>2. 버튼 선택 시 서버에서 보낸 값 사용자가 수신</h3>
	<button id="getServerTextBtn">서버에서 보낸 값 확인</button>
	<p class="test" id="p1"></p>
	<script>
		$('#getServerTextBtn').click(function(){
			$.ajax({
				url: "jQueryTest2.do",
				success: function(data){
					console.log(data);
					$('#p1').text(data);
				}
			});
		});
	
	</script>
	
	<br>
	
	<h3>3. 서버로 기본형 전송 값이 있고 결과로 문자열을 받아 처리</h3>
	<h4>두개의 값을 더한 결과를 받아 옴</h4>
	첫번째 숫자 : <input type="text" id="firstNum"><br>
	두번째 숫자 : <input type="text" id="secondNum"><br>
	<button id="plusBtn">더하기</button>
	<p class="test" id="p2"></p>
	<script>
		
		//jQueryTest3.do에 위 두개의 값 전송
		
		$('#plusBtn').click(function(){
			var firstNum = $('#firstNum').val();
			var secondNum = $('#secondNum').val();
			
			$.ajax({
				url: "jQueryTest3.do",
				data: {firstNum : firstNum, secondNum : secondNum},
				success: function(data){
					$('#p2').text(data);
				}
			});
		});
		
	</script>	
	<h3> 4. Object형태의 데이터를 서버에 전송, 서버에서 처리 후 서버 console로 출력</h3>
	학생 1: <input type="text" id="student1"><br>
	학생 2: <input type="text" id="student2"><br>
	학생 3: <input type="text" id="student3"><br>
	<button id="studentTest">결과확인</button>	
	<script>
		$('#studentTest').click(function(){
			var student1 =$('#student1').val();
			var student2 =$('#student2').val();
			var student3 =$('#student3').val();
			
			var students = {student1:student1, student2:student2,student3:student3};
			
			$.ajax({
				url: "jQueryTest4.do",
				data: students
			});
		});
	</script>
	
	<br>
	
	<h3>5. 서버로 기본형 데이터 전송, 서버에서 객체 반환</h3>
	<h4> 유저 번호 보내서 해당 유저 정보 가져오기</h4>
	유저번호 : <input type="text" id="userNo"><br>
	<button id="getUserInfoBtn">정보 가져오기</button>
	<p class="test" id="p3"></p>
	<textarea class="text" id="textarea3" cols=40 rows=5></textarea>
	<script>
		$('#getUserInfoBtn').click(function(){
			var userNo = $('#userNo').val();
		
			
			$.ajax({
				url:'jQueryTest5.do',
				data: {userNo:userNo},
				success: function(data){
					console.log(data);
					
					var resultStr = "";
					
					if(data != null){
						resultStr = data.userNo + ", " + data.userName + " , " + data.userNation;
					}else{
						resultStr = "해당회원이 없습니다.";
					}
					
					$('#p3').text(resultStr);
					$('#textarea3').val(resultStr);
				}
			});
		});
	</script>
	<!-- json.org / json-simple -깃코드- 홈페이지 - 다운로드 -json-simple-1.1.1.jar -라이브러리에 넣기 -->
	<h3>6. 서버로 기본 값 전송, 서버에서 리스트 객체 반환</h3>
	<h4>유저 번호 요청 --> 해당 유저가 있는 경우 유저 정보, 없는 경우 전체 가져오기</h4>
	유저 번호 : <input type="text" id="userNo2"><br>
	<button id="getUserInfoBtn2">정보 가져오기</button>
	<p class="test" id="p4"></p>
	<script>
	$('#getUserInfoBtn2').click(function(){
		var userNo = $('#userNo2').val();
	
		
		$.ajax({
			url:'jQueryTest6.do',
			data: {userNo:userNo},
			success: function(data){
				console.log(data);
				
				var resultStr = "";
				for(var i in data){ // var i가 배열일때는 키를 가리킴
					var user = data[i];
					console.log(user);
					
					//resultStr += user.userNo + ", "+user.userName+", "+ user.userNation + "\n"; 개행문자가 textarea에서는 된다
					resultStr += user.userNo + ", "+user.userName+", "+ user.userNation + "<br>"; //br은 스트링이라서 안됨.
				}
				$('#p4').text(resultStr);
			}
		});
	});
	</script>
	<br>
	
	<h3>7. 서버에서 데이터 여러 개 전송, 서버에서 리스트 객체 반환</h3>
	<h4> 유저 번호 전송--> 현재있는 유저 정보만 모아서 출력</h4>
	<h4> 10이상의 숫자는 ','로 쓸 수 없다고 가정</h4>
	유저 정보(번호, 번호, 번호) : <input type="text" id="userNo3"><br>
	<button id="getUserInfoBtn3">정보 가져오기</button><br>
	<textarea class='test' id="textarea5" cols=40 rows=5></textarea>
	<script>
		$('#getUserInfoBtn3').click(function(){
			
			$.ajax({
				url:'jQueryTest7.do',
				data: {userNo:$('#userNo3').val()},
				success: function(data){
					console.log(data);
					
					var resultStr = "";
					for(var i in data){ // var i가 배열일때는 키를 가리킴
						var user = data[i];
						console.log(user);
						
						resultStr += user.userNo + ", "+user.userName+", "+ user.userNation + "\n"; //개행문자가 textarea에서는 된다
						//resultStr += user.userNo + ", "+user.userName+", "+ user.userNation + "<br>"; //br은 스트링이라서 안됨.
					}
					$('#textarea5').val(resultStr);
				}
			});
		});
	</script>
	
	<br>
	
	<h3>8. 서버로 데이터 여러 개 전송, 서버에서 맵 형태의 객체 반환</h3>
	<h4>유저 이름 전송 --> 현재 있는 유저 정보만 모아서 출력</h4>
	유저 정보(이름, 이름, 이름 ) : <input type="text" id="userName"><br>
	<button id="getUserInfoBtn4">정보 가져오기</button><br>
	<textarea id="textarea6" class="test" cols=40 rows=5></textarea>
	<script>
		$('#getUserInfoBtn4').click(function(){
			
			$.ajax({
				url:'jQueryTest8.do',
				data:{userName:$('#userName').val()}, //보낼값은 변수넣어서 보내도되지만 바로 넣어줘도 됌.
				success: function(data){
					console.log(data);// 서블릿에서 돌아와서 데이터 받아올때 콘솔에 먼저 찍어보기.
					
					var resultStr = "";
					for(var key in data){ //객체로 만들었으니까 i가 아닌 key
						console.log(key);
						var user = data[key];
						
						resultStr += user.userNo + ", "	+ user.userName + ", "+ user.userNation + "\n";
						
					}
					$('#textarea6').val(resultStr);
				}
			});
			
		});
	
	</script>
	
	<h3>9. 서버 유저 정보로 표 구성하기</h3>
	<button id="userInfoBtn">유저 정보 불러오기</button>
	<table id="userInfoTable" border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>국적</th>
			</tr>
		</thead>
		<tbody>
		
		
		</tbody>
	</table>
	<script>
	$('#userInfoBtn').click(function(){
		$.ajax({
			url:'jQueryTest9.do',
			success: function(data){ // 보내줄 값없이 받아오기만 할것.
				console.log(data);
				
			$tableBody = $('#userInfoTable tbody');
			$tableBody.html("");
			//변수명 앞에 $를 쓴건 식별하기 위해서.
			//안에 들어간게 제이쿼리인지, 자바스크립트인지 알수가없기때문임.
			
			for(var i in data){
				var $tr = $("<tr>");
				
				var $noTd = $("<td>").text(data[i].userNo);
				var $nameTd =$("<td>").text(data[i].userName);
				var $nationTd =$("<td>").text(data[i].userNation);
				
				$tr.append($noTd);
				$tr.append($nameTd);
				$tr.append($nationTd);
				
				$tableBody.append($tr);
				
				}
			
			}
		});
	});
	</script>
	
	<h3>10. 서버에서 List객체 반환 받아 select태그를 이용해서 보여줌</h3>
	유저 이름 : <input type="text" id="selectUserName">
	<button id="selectListBtn">예제</button><br>
	<select id="selectListTest"></select>
	<script>
		$('#selectListBtn').click(function(){
			$.ajax({
				url:'jQueryTest10.do',
				success: function(data){
					console.log(data);
					
					$select = $("#selectListTest");//변수생성
					$select.find('option').remove(); //  선택 초기화 시키기
					
					for(var i =0; i < data.length; i++){
						var name = data[i].userName;
						
						var selected = (name == $('#selectUserName').val()) ? 'selected' : '';
						
						$select.append('<option value="' + data[i].userNo + '"' + selected + ">" + name + "</option>");
						//<option value="1" selected>박신우</option>
					}
				}
			});
		});
	
	</script>
	
	<h3>11. Gson을 이용한 List반환</h3>
	<button id="gsonList">list 가져오기</button>
	<select id="gsonListSelect"></select>
	<script>
		$('#gsonList').click(function(){
			$.ajax({
				url:'jQueryTest11.do',
				success: function(data){
					console.log(data);
					
					$select = $('#gsonListSelect');
					$select.find('option').remove();
					
					for(var i in data){
						var $option = $('<option>');
						
						$option.val(data[i].userNo);
						$option.text(data[i].userName);
						
						$select.append($option);
						
					}
				}
			});
		});		
	
	</script>
	
	<h3>12. Gson을 이용한 Map반환</h3>
	<button id="gsonMapBtn">Map 가져오기</button>
	<select id="gsonMapSelect"></select>
	<script>
		$('#gsonMapBtn').click(function(){
			$.ajax({
				url:'jQueryTest12.do',
				success:function(data){
					
					$select = $('#gsonMapSelect');
					$select.find('option').remove();
					
					for(var i in data){
						var $option = $('<option>');
						
						$option.val(data[i].userNo);
						$option.text(data[i].userName);
						
						$select.append($option);
						//맵이라서 순서 안지켜짐
						
					}	
				}
			});
		});
	</script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
	

</body>
</html>