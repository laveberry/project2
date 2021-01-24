<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <div id="wrapper">
    <!-- Sidebar -->
    <ul class="sidebar navbar-nav">
      <li class="nav-item">
<!--         <a class="nav-link" href="../space/list_ctrl?&menu=admin&flag=1"> -->
        <a class="nav-link" href="peopleCtrl.jsp">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>관리자리스트</span>
        </a>
      </li>
      <li class="nav-item dropdown">
<!--         <a class="nav-link dropdown-toggle" href="boardCtrl.jsp" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
<!--         <a href="boardCtrl.jsp" id="pagesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
        <a class="nav-link" href="boardCtrl.jsp">
          <i class="fas fa-fw fa-folder"></i>
          <span>게시판 관리</span>
        </a>
        <div class="dropdown-menu" aria-labelledby="pagesDropdown">
          <h6 class="dropdown-header">Login Screens:</h6>
          <a class="dropdown-item" href="login.html">Login</a>
          <a class="dropdown-item" href="register.html">Register</a>
          <a class="dropdown-item" href="forgot-password.html">Forgot Password</a>
          <div class="dropdown-divider"></div>
          <h6 class="dropdown-header">Other Pages:</h6>
          <a class="dropdown-item" href="404.html">404 Page</a>
          <a class="dropdown-item active" href="blank.html">Blank Page</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="timeCtrl.jsp">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>일정 관리</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="etcCtrl.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>기타</span></a>
      </li>
    </ul>
    
    