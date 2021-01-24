<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 참조: http://postcode.map.daum.net/guide -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

    new daum.Postcode({
    	/*
    	oncomplete : 특정항목 클릭하면 정보를 받아 콜백함수를 정의하는 부분
    				(null값 또는 정의하지 않을 시에 검색은 가능하지만,
    				결과 항목을 클릭하면 아무 일도 일어나지 않습니다.)
    	data : 사용자가 선택한 주소를 담고있는 객체
    	*/
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
//             //value에 ()없음
//             opner.document.registFrm.zip1.value = data.zonecode;
//             opner.document.registFrm.zip2.value = data.address;
//             self.close();
        }
  
        //size는 우편번호 찾기 화면의 크기 데이터 객체이며, 상세 설명은 아래 목록에서 확인하실 수 있습니다.
    	
//     	/*
//     	onclose
//     	우편번호 찾기 화면을 팝업으로 띄운 후, 검색 결과를 선택하거나, 브라우저의 닫기버튼을 통해 닫았을 때 발생하는 콜백 함수를 정의하는 부분입니다. 이 중 검색결과를 선택한 경우에는 onComplete콜백함수가 완료된 후에 실행되게 됩니다.
//     	이 함수를 정의할때 넣는 인자에는 우편번호 찾기 화면이 어떻게 닫혔는지에 대한 상태 변수가 들어가게 됩니다.
//     	(embed() 함수를 이용한 레이어모드에서는 "검색결과를 선택하여 닫힌 경우"에만 실행됩니다.)
//     	*/
//     	onclose: function(state) {
// 	        //state는 우편번호 찾기 화면이 어떻게 닫혔는지에 대한 상태 변수 이며, 상세 설명은 아래 목록에서 확인하실 수 있습니다.
// 	        if(state === 'FORCE_CLOSE'){
// 	            //사용자가 브라우저 닫기 버튼을 통해 팝업창을 닫았을 경우, 실행될 코드를 작성하는 부분입니다.
	
// 	        } else if(state === 'COMPLETE_CLOSE'){
// 	            //사용자가 검색결과를 선택하여 팝업창이 닫혔을 경우, 실행될 코드를 작성하는 부분입니다.
// 	            //oncomplete 콜백 함수가 실행 완료된 후에 실행됩니다.
//         }
    
    }).open(); 
    
</script>