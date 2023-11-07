<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html>
<head>
  <meta charset="utf-8" />
  <link rel="icon" href="/favicon.ico" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="#000000" />
  <title>Login</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins%3A400%2C600%2C700"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C600%2C700"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Titan+One%3A400"/>
  <link rel="stylesheet" href="./styles/login.css"/>
</head>
<body>
<div class="login-PL5">
  <div class="backgroundwhite-Jhw">
  </div>
  <form  action="login_process.jsp" method="POST">
  <div class="email-Nxh">
    <img class="logoemail-56R" src="./assets/logoemail.png"/>
    <div class="auto-group-n9td-zjB">
      <p class="item--xAD">이메일</p>
      <input class="examplenavercom-TMs" type="text" name="userid" placeholder="example@naver.com" required>
    </div>
  </div>
  <div class="password-yb7">
    <img class="logokey-prd" src="./assets/logokey.png"/>
    <div class="auto-group-tpjt-Y1w">
      <p class="item--Vhs">비밀번호</p>
      <input class="item--2Su" type="password" name="password" placeholder="***********" required>
    </div>
  </div>
  	<input class="buttonlogin-v2V" type="submit" value="로그인">
  	<input type="submit" value="로그인">
   </form>
  <div class="remember-me-knD">
    <label>
      <input class="check-fPP" type="checkbox">
    </label>
    <p class="item--mSR">로그인 상태 유지</p>
  </div>
  <p class="item--t1F">
    <span class="item--t1F-sub-0">가입하신 계정이 없으신가요</span>
    <span class="item--t1F-sub-1">?</span>
      <a href="register.jsp"> <!-- URL of your registration page-->
        <span class="item--t1F-sub-2">가입하기</span>
      </a>
  </p>

  <div class="logoregister-oJZ">
    <p class="welcome-to-meomeokji-XkM">
      <span class="welcome-to-meomeokji-XkM-sub-0">
      <br/>
      </span>
      <span class="welcome-to-meomeokji-XkM-sub-1">
      Welcome to
      <br/>
      </span>
      <span class="welcome-to-meomeokji-XkM-sub-2">
      MeoMeoKji
      <br/>
      </span>
    </p>
    <img class="logomeo-ftV" src="./assets/logomeo.png"/>
  </div>
</div>



<style>

.examplenavercom-TMs{
background-color: #ECECEC;

}

.item--2Su{
background-color: #ECECEC;

}


</style>
</body>