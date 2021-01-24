<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Login</title>

  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">
</head>
<%
System.out.println("로그인페이지 시작");

request.setCharacterEncoding("utf-8");

//쿠키 불러오기
String saveId = "";
Cookie[] cookies = request.getCookies();

if(cookies!=null){
	for(Cookie c : cookies){
		if(c.getName().equals("SAVE_ID")){
			saveId = c.getValue();
			//저장쿠키 확인
		    System.out.println("saveId="+saveId);
		    //쿠키값 req에 저장하기
		    request.setAttribute("cookieID", saveId);
		}
	}
} 
%>
<script type="text/javascript">
function loginValidate(fn) {
	if(fn.user_id.value==""){
		alert("아이디를 입력하세요");
		fn.user_id.focus();
		return false;
	}
	if(!fn.user_pw.value){
		alert("패스워드를 입력하세요");
		fn.user_pw.focus();
		return false;
	}
}
</script>
<body class="bg-dark">

  <div class="container">
    <div class="card card-login mx-auto mt-5">
      <div class="card-header">Login</div>
      <div class="card-body">
      <!-- 전송을위한 form 생성 -->
<%--         <form action="<%=request.getContextPath() %>/admin" onsubmit="return loginValidate(this);" method="post"> --%>
        <form action="./LoginProcessMap.jsp" onsubmit="return loginValidate(this);" method="post">
        
        	<input type="hid-den" name="returnURL" value="${param.returnURL }" size="50" border="2" />
        
          <div class="form-group">
            <div class="form-label-group">
              <input type="text" id="user_id" name="user_id" class="form-control">
              <label for="user_id">id</label>
            </div>
          </div>
          <div class="form-group">
            <div class="form-label-group">
              <input type="password" id="user_pw" name="user_pw" class="form-control">
              <label for="user_pw">Password</label>
            </div>
          </div>
          <div class="form-group">
            <div class="checkbox">
              <label>
                <input type="checkbox" value="remember-me" name="save_id">
                Remember Id
              </label>
            </div>
          </div>
          <button type="submit" class="btn btn-primary btn-block">로그인</button>
<!--           <input type="button" value="Login" class="btn btn-primary btn-block"/> -->
<!--           <button class="btn btn-primary btn-block">Login</button> -->
<!--           <a class="btn btn-primary btn-block" href="/admin">Login</a> -->
        </form>
        <div class="text-center">
          <a class="d-block small mt-3" href="register.html">Register an Account</a>
          <a class="d-block small" href="forgot-password.html">Forgot Password?</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

</body>

</html>
