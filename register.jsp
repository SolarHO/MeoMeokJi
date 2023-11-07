<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <link rel="icon" href="/favicon.ico" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="#000000" />
  <title>Registration</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins%3A400%2C600%2C700%2C900"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C600%2C700%2C900"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Titan+One%3A400"/>
  <link rel="stylesheet" href="./styles/registration.css"/>
</head>
<body>
  <form action="RegisterServlet1" method="post" onsubmit="return validateForm()" accept-charset="UTF-8">
    <div class="registration-xru">
      <img class="backgroundimg-hZb" src="./assets/backgroundimg.png"/>
      <div class="backgroundwhite-qQu">
      </div>
      <div class="registerbutton-YaD">
        <input class="item--pGq" type="submit" value="가입하기">
        <img class="dart-Xww" src="REPLACE_IMAGE:109:112"/>
      </div>
     
      <div class="checkpassword-h7f">
        <img class="logokey-NDo" src="./assets/logokey-GU9.png"/>
        <div class="auto-group-3gv5-hG5">
          <p class="item--eh7">비밀번호 확인</p>
          <input class="item--xSu" type="password" name="passwordcheck" id="passwordcheck" required>
        </div>
      </div>
      <div class="password-URF">
        <img class="logokey-PYD" src="./assets/logokey-4ob.png"/>
        <div class="auto-group-ymwx-tzm">
          <p class="item--4PT">비밀번호</p>
          <input class="item--Bys" type="password" name="password" id="password" required>
        </div>
      </div>
      <div class="email-KaH">
        <img class="emaillogo-RtD" src="./assets/emaillogo.png"/>
        <div class="auto-group-7ub3-jtu">
          <p class="item--W8y">이메일</p>
          <input class="examplenavercom-qS9" type="email" name="email" required>
        </div>
      </div>
      <div class="id-Zd3">
        <img class="userid-5LV" src="./assets/userid.png"/>
        <div class="auto-group-racy-c5X">
          <p class="item--YUy">아이디</p>
          <input class="kdhong-t33" type="text" name="id" required>
        </div>
      </div>
      <div class="name-ND7">
        <img class="username-r8H" src="./assets/username.png"/>
        <div class="auto-group-2sgh-BAZ">
          <p class="item--8rV">이름</p>
          <input class="item--TNy" type="text" name="name" required>
        </div>
      </div>
      </form>
      <div class="logoregister-aTb"> 
        <p class="welcome-to-meomeokji-Rz1">
          <span class="welcome-to-meomeokji-Rz1-sub-0">
          <br/>
          </span>
          <span class="welcome-to-meomeokji-Rz1-sub-1">
          Welcome to
          <br/>
          </span>
          <span class="welcome-to-meomeokji-Rz1-sub-2">
          MeoMeoKji
          <br/>
          </span>
        </p>
        <img class="logomeo-VaZ" src="./assets/logomeo-YEd.png"/>
      </div>
      
  </form>
  <style>
  .item--pGq {
    /* 배경색을 파란색으로 설정 */
    background-color: #6358DC;
    /* 다른 스타일 속성도 여기에 추가할 수 있습니다. */
   
}
.kdhong-t33{
background-color: #ECECEC;

}
.item--Bys{
background-color: #ECECEC;

}

.item--TNy{
background-color: #ECECEC;

}

.examplenavercom-qS9{
background-color: #ECECEC;

}

.item--xSu{
background-color: #ECECEC;

}


</style>
  
  <p id="passwordMismatch" style="color: red; display: none;">비밀번호가 일치하지 않습니다.</p>
  <script>
    function validateForm() {
        var password = document.getElementById("password").value;
        var passwordcheck = document.getElementById("passwordcheck").value;

        if (password !== passwordcheck) {
            document.getElementById("passwordMismatch").style.display = "block";
            return false; // 폼 제출을 막음
        } else {
            document.getElementById("passwordMismatch").style.display = "none";
            return true; // 폼 제출을 허용
        }
    }
    </script>
</body>
