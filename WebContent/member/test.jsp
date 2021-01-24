<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function zipcodFind(){
    new daum.Postcode({
        oncomplete: function(data) {
            //Daum 우편번호 API가 전달해주는 값을 콘솔에 출력
            console.log(data.zonecode)
            console.log(data.address)
            console.log(data.sido)
            console.log(data.sigungu)
            //가입폼에 적용하기
            var f = document.registFrm;
            f.zipcode.value = data.zonecode;
            f.addr1.value = data.address;
            f.addr2.focus();
        }
    }).open();
}

function numFocus(obj, mLenght, next_obj){
    var strLength = obj.value.length;

    if(strLength>=mLenght){
         document.getElementsByName(next_obj)[0].focus();
    }
}

function email_input(domain){
    var str = domain.value;
    if(str=="self"){
     document.getElementsByName("email_2")[0].value = "";
     $("#email_2").attr("readonly", false); 
    }
    else{
     $("#email_2").attr("readonly", true); 
     document.getElementsByName("email_2")[0].value = str; 
    }
}

function velidateForm(frm){
    // 아이디체크
    var idStr = frm.id.value;
    if(idStr.length<4||idStr.length>12){
        alert("아이디는 4~12자 사이로 해야 합니다.")
        return false;
    }

    if(idStr.charCodeAt(0)>=48&&idStr.charCodeAt(0)<=57){
        alert("아이디는 숫자로 시작할 수 없습니다.")
        return false;
    }

    for(var i=1; i<idStr.length; i++){
        if(!(idStr.charCodeAt(i)>=48&&idStr.charCodeAt(i)<=57
            ||idStr.toUpperCase().charCodeAt(i)>=65&&idStr.toUpperCase().charCodeAt(i)<=90)){
                alert(idStr.toUpperCase()[i]);
            alert("아이디에는 특수문자를 사용할 수 없습니다.");
            return false;
        }
    }
    // 패스워드체크
    var pwStr = frm.pass.value;
    var specialCheck = false;
    var specialStr = ["!", "@", "#", "$", "%", "^", "&", "*"];
    for(var i=0; i<pwStr.length; i++){
        for(var j=0; j<specialStr.length; j++){
            if(pwStr[i]==specialStr[j]){
                specialCheck = true;
            }
        }
    }
    var numberCheck = false;
    for(var i=0; i<pwStr.length; i++){
        if(pwStr[i].charCodeAt(0)>=48&&pwStr[i].charCodeAt(0)<=57){
            numberCheck = true;
        }
    }

    if(!(specialCheck==true&&numberCheck==true)){
        alert("비밀번호는 숫자와 특수기호가 포함되어야 합니다.")
        frm.pass.focus();
        return false;
    }
    if(frm.pass.value != frm.pass2.value){
        alert("입력한 패스워드가 일치하지 않습니다.")
        frm.pass.value="";
        frm.pass2.value="";
        frm.pass.focus();
        return false;
    }
    if(frm.mobile2.value==""||frm.mobile3.value==""){
     alert("휴대폰 번호는 필수입니다.");
     frm.mobile2.focus();
     return false;
    }
    if(frm.email_1.value==""||frm.email_2.value==""){
     alert("이메일을 입력해주세요");
     frm.email_1.focus();
     return false;
    }
    if(frm.zipcode.value==""||frm.addr1.value==""){
     alert("주소를 입력해주세요");
     frm.addr1.focus();
     return false;
    }
    
}

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
        window.open("../member/id_overapping.jsp?id="+frm,
            "idover", "width=300, height=300");
    } 
    
}

</script>
 <body>
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
    <form name="registFrm" action="../member/join.do" method="post" onsubmit="return velidateForm(this);">
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
      <td><input type="text" name="id"  value="" class="join_input" />&nbsp;<a onclick="idCheck();" style="cursor:pointer;"><img src="../images/btn_idcheck.gif" alt="중복확인"/></a>&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
     </tr>
     <tr>
      <th><img src="../images/join_tit003.gif" /></th>
      <td><input type="password" name="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
     </tr>
     <tr>
      <th><img src="../images/join_tit04.gif" /></th>
      <td><input type="password" name="pass2" value="" class="join_input" /></td>
     </tr>
     <!-- <tr>
      <th><img src="../images/join_tit06.gif" /></th>
      <td>
       <input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" onkeyup="numFocus(this, 3, 'tel2');"/>&nbsp;-&nbsp;
       <input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, 'tel3');"/>&nbsp;-&nbsp;
       <input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, null);"/>
      </td>
     </tr> -->
     <tr>
      <th><img src="../images/join_tit07.gif" /></th>
      <td>
      <select name="mobile1" class="join_input" style="width:50px; padding:0" onchange="numFocus(this, 3, 'mobile2');">
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                        <option value="019">019</option>
                    </select>&nbsp;-&nbsp;
                    <input type="text" name="mobile2" size="4" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, 'mobile3');">&nbsp;-&nbsp;
                    <input type="text" name="mobile3" size="4" class="join_input" style="width:50px;" onkeyup="numFocus(this, 4, 'email_1');">
       <!-- <input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
       <input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
       <input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td> -->
     </tr>
     <tr>
      <th><img src="../images/join_tit08.gif" /></th>
      <td>
 
 <input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
 <input type="text" id="email_2" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
 <select name="last_email_check2" onChange="email_input(this);" class="pass" id="last_email_check2" >
  <option selected="" value="">선택해주세요</option>
  <option value="self" >직접입력</option>
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
      <input type="text" name="zipcode" value=""  class="join_input" style="width:100px;" />
      <input type="button" value="[우편번호검색]" onclick="zipcodFind();"/>
       <%-- "zipFind('zipFind', '<?=$_Common[bbs_path]?>member_zipcode_find.php', 590, 500, 0);" --%>
      <br/>
      
      <input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
      <input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
      </td>
     </tr>
    </table>
    <p style="text-align:center; margin-bottom:20px">
    <!-- <a href="join02.jsp"> -->
    <input type="image" src="../images/btn01.gif" alt="" /><!-- <img src="../images/btn01.gif" /> -->
    <!-- </a> -->&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif" /></a></p>
    </form>
   </