<%@page import="multi.BbsDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="multi.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../common/bootstrap4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"></script>
<!-- 회원가입 수정할거 이빠이~ -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ include file="../include/global_head.jsp" %>
<!-- 참조: http://postcode.map.daum.net/guide -->

<link href="../bootstrap3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="../bootstrap3.3.7/jquery/jquery-3.2.1.min.js"></script>            
<script src="../bootstrap3.3.7/js/bootstrap.min.js"></script>

<!-- 다음 우편번호찾기 API -->
<!--autoload=false 파라미터를 이용하여 자동으로 로딩되는 것을 막습니다.-->
<!-- !!중요. - autoload=false 를 반드시 붙혀주셔야 합니다.-->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- jstl -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
// String agree = request.getParameter("agree");
// JavascriptUtil.jsAlertBack("경고창!");
// System.out.println(agree);

// if(agree == "T"){
%>

<script>
//주소(우편번호) 검색 - DAUM API
function zipFind() {
	 new daum.Postcode({
    	/*
    	oncomplete : 특정항목 클릭하면 정보를 받아 콜백함수를 정의하는 부분
    	data : 사용자가 선택한 주소를 담고있는 객체
    	*/
        oncomplete: function(data) {
        	//form 가져오기
        	var a = document.registFrm;
			a.zip1.value = data.zonecode;
			a.addr1.value = data.address;
			f.addr2.focus();
        }  
    }).open();
}

//폼값 검증
function checkRegist(fm) {
	if(!fm.name.value){
		alert('이름을 입력하세요');
		fm.name.focus();
		return false;
	}
	//아이디입력하면 그냥 넘어가버림.....
	if(fm.id.value==""||fm.id.value==null){
		alert('아이디를 입력하세요');
		fm.id.focus();
		return false;
	}
    if(fm.pass.value.length<4 || fm.pass.value.length>12){
    	fm.pass.value.focus();
    	alert('비밀번호는 4자리 이상, 12자리 이하로 입력하세요');
    	return false;
    }
    //false값을 리턴했는데 왜 액션이 진행되지 ?
    if(fm.pass.value != fm.pass2.value){
    	alert('비밀번호가 일치하지 않습니다.');
    	fm.pass2.value='';
    	fm.pass.focue();
    	return false;
    }
    if(!fm.mobile1.value ||!fm.mobile2.value || !fm.mobile3.value){
    	alert('휴대폰번호를 입력하세요');
    	fm.mobile1.focus();
    	return false;
    }
    if(!fm.email_1.value || !fm.email_2.value){
    	alert('이메일을 입력하세요');
    	fm.email_1.focus();
    	return false;
    }
    else{
    	alert("회원가입진행");
    }
}
//아이디 중복확인
function idCheck(){
    var frm = document.getElementsByName("id")[0].value;

    if(frm.length<4||frm.length>12){
        alert("아이디는 4~12자 사이로 해야 합니다.")
        document.getElementsByName("id")[0].focus();
        return;
    }

    if(frm.charCodeAt(0)>=48&&frm.charCodeAt(0)<=57){
        alert("아이디는 숫자로 시작할 수 없습니다.")
        document.getElementsByName("id")[0].focus();
        return;
    }

    for(var i=1; i<frm.length; i++){
        if(!(frm.charCodeAt(i)>=48&&frm.charCodeAt(i)<=57
            ||frm.toUpperCase().charCodeAt(i)>=65&&frm.toUpperCase().charCodeAt(i)<=90)){
                alert(frm.toUpperCase()[i]);
            alert("아이디에는 특수문자를 사용할 수 없습니다.");
            document.getElementsByName("id")[0].focus();
            return;
        }
    }
    if(frm==""){
        alert("아이디를 입력해주세요");
        document.getElementsByName("id")[0].focus();
    }
    else{
        frm.readOnly = true;
 		window.open("popupJoin.jsp?id="+frm, "idCheck", "width=400, height=300, left=100, top=50");
	}
}

	//이메일 선택시 자동입력_[참조]제이쿼리 JQ15From2
	$(function() {
		$('#last_email_check2').change(function(){
			//option태그의 text와 value 얻어오기
			var text = $('#last_email_check2 option:selected').text();
			var value = $('#last_email_check2 option:selected').val();
			
			if(value==''){//선택하세요
				$('#email_2').attr('readonly', true);
				$('#email_2').val('');
			}
			else if(value=='1'){//직접입력
				$('#email_2').attr('readonly', false);
				$('#email_2').val("");
				$('#email_2').focus();
			}
			else{
				$('#email_2').attr('readonly', true);
				$('#email_2').val(value);
			}
		});
	});
	
</script>

	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				
		<form action="../main/join.jsp" method="post" name="registFrm" onsubmit="return checkRegist(this);">
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" name="id"  value="" class="join_input" />&nbsp;
							<a onclick="idCheck();" style="cursor:pointer;" name="idCheckButton"><img src="../images/btn_idcheck.gif" alt="중복확인"/></a>&nbsp;&nbsp;
							<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" value="" class="join_input" /></td>
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
 
	<input type="text" id="email_1" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
	<input type="text" id="email_2" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
	<select name="last_email_check2" onChange="email_input(this);" class="pass" id="last_email_check2" >
		<option selected="" value="">선택해주세요</option>
		<option value="1" >직접입력</option>
		<option value="dreamwiz.com" >dreamwiz.com</option>
		<option value="empal.com" >empal.com</option>
		<option value="empas.com" >empas.com</option>
		<option value="freechal.com" >freechal.com</option>
		<option value="hanafos.com" >hanafos.com</option>
		<option value="hanmail.net" >hanmail.net</option>
		<option value="hotmail.com" >hotmail.com</option>
		<option value="intizen.com" >intizen.com</option>
		<option value="korea.com" >korea.com</option>
		<option value="kornet.net" >kornet.net</option>
		<option value="msn.co.kr" >msn.co.kr</option>
		<option value="nate.com" >nate.com</option>
		<option value="naver.com" >naver.com</option>
		<option value="netian.com" >netian.com</option>
		<option value="orgio.co.kr" >orgio.co.kr</option>
		<option value="paran.com" >paran.com</option>
		<option value="sayclub.com" >sayclub.com</option>
		<option value="yahoo.co.kr" >yahoo.co.kr</option>
		<option value="yahoo.com" >yahoo.com</option>
	</select>
	 
		<input type="checkbox" name="open_email" value="1">
		<span>이메일 수신동의</span></td>
	</tr>
	<tr>
		<th><img src="../images/join_tit09.gif" /></th>
		<td>
		<input type="text" name="zip1" value=""  class="join_input" style="width:100px;" />&nbsp;&nbsp;
<!-- 		<input type="text" name="zip2" value=""  class="join_input" style="width:50px;" /> -->
		<!--[참조]JS - J18FormObject04.html -->
<%-- 		<a href="javascript:window.open('adressAPI.jsp','daumAPI','width=0, height=0')" title="새 창으로 열림" onclick="zipFind('zipFind', '<?=$_Common[bbs_path]?>member_zipcode_find.php', 590, 500, 0);" onkeypress="">[우편번호검색]</a> --%>
		<!-- 매개변수를 this.form으로 폼 넘겨주기 -->
		<a href="javascript:zipFind();" title="새 창으로 열림" onkeypress="">[우편번호검색]</a>
		<br/>
		
		<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
		<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
		
		</td>
	</tr>
	</table>
				<p style="text-align:center; margin-bottom:20px">
				&nbsp;&nbsp;<input type="image" src="../images/btn01.gif"/>	
				<a href="javascript:alert('회원가입 취소'); history.go(-2);"><img src="../images/btn02.gif" /></a>
<!-- 				<a href="#"><img src="../images/btn01.gif" /></a>&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif" /></a> -->
				</p>
		</form>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
 
</html>
<%
// }
// else{
// 	JavascriptUtil.jsAlertLocation("회원가입 약관에 동의해주세요.", "join01.jsp");
// }
 %>
