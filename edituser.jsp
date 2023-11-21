<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
     <meta charset="utf-8" />
  <link rel="icon" href="/favicon.ico" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="theme-color" content="#000000" />
  <title>Registration</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Poppins%3A400%2C600%2C700%2C900"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro%3A400%2C600%2C700%2C900"/>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Titan+One%3A400"/>
<style>
* {
  margin: 0 auto;
  padding: 0;
}

.wrap {
  width: 100%;
  height: 100%;
  position: absolute;
}

button {
  border-style: none;
}


.background {
  width: 100%;
  height: 100%;
  background-image: url(./img/backgroundimage-bg.png);
  background-repeat: no-repeat;
  opacity: 0.3;
  top: 0;
  left: 0;
  position: absolute;
  z-index: -1;
  background-size: cover;
}

.login_window {
  width: 630px;
  height: 930px;
  background-color: white;
  text-align: center;
  margin-top: 100px;
}

/* .login_window>welcome-to-meomeokji {
  width: 50%;
  float: left;
  text-align: right;
  margin-top: 100px;
} */

.login_window>form {}

.login_window .submit_div {
  margin-top: 100px;
  text-align: right;
  position: relative;
  right: 100px;
  bottom: 100px;
}
.submit_div>button {
  width: 15%;
  height: 50px;
  border-radius: 10px;
  background-color: #6358DC;
  color: white;
  font-size: 18px;
}
.submit_div2>button {
  width: 15%;
  height: 50px;
  border-radius: 10px;
  background-color: #6358DC;
  color: white;
  font-size: 18px;
}

.login_footer {
  margin-top: 100px;
  font-family: Poppins, 'Source Sans Pro'
}

.wrap .id {
  width: 428px;
  height: 72px;
  top: 313px;
  left: 541px;
}

.wrap .overlap-group {
  position: relative;
  width: 424px;
  height: 72px;
  background-color: #ebebeb;
  border-radius: 8px;
}

.wrap .img {
  position: absolute;
  width: 30px;
  height: 30px;
  top: 21px;
  left: 15px;
}

.wrap .text-wrapper {
  top: 10px;
  left: 97px;
  font-family: "Poppins-Regular", Helvetica;
  font-weight: 400;
  color: var(--black);
  font-size: 16px;
  line-height: 21.7px;
  position: absolute;
  letter-spacing: 0;
  white-space: nowrap;
}

.wrap .div {
  position: absolute;
  top: 36px;
  left: 97px;
  font-family: "Poppins-Bold", Helvetica;
  font-weight: 700;
  color: black;
  font-size: 20px;
  letter-spacing: 0;
  line-height: 27.1px;
  white-space: nowrap;
  background-color: #ECECEC;
  border: none;
  
}

.wrap .password {
  width: 428px;
  height: 72px;
  top: 444px;
  left: 541px;
}

.wrap .logo-register {
  position: top;
  width: 396px;
  height: 130px;
  top: 146px;
  left: 571px;
}

.wrap .overlap-2 {
  position: relative;
  width: 394px;
  height: 130px;
  left: 15px;
}

.wrap .welcome-to-meomeokji {
  position: absolute;
  width: 251px;
  top: 0;
  left: 0;
  font-family: "Poppins-Regular", Helvetica;
  font-weight: 400;
  color: transparent;
  font-size: 40px;
  letter-spacing: 0.2px;
  line-height: 40px;
}

.wrap .text-wrapper-2 {
  color: #6257db;
  line-height: 28px;
}

.wrap .welcome-to {
  color: #2e2e2e;
  line-height: 28px;
  font-family: Poppins, 'Source Sans Pro';
}

.wrap .MeoMeoKji {
  font-family: Titan One, 'Source Sans Pro';
  color: #2e2e2e;
}

.wrap .logo-meo {
  position: absolute;
  width: 149px;
  height: 130px;
  top: 15px;
  left: 245px;
  object-fit: cover;
}

</style>
</head>
<body>
   
     <div class="wrap">
        <div class="background">
        </div>
        
        <div class="login_window">
            <br><br> 
            <div class="logo-register">
                <div class="overlap-2">
                  <p class="welcome-to-meomeokji">
                    <span class="text-wrapper-2"><br /></span>
                    <span class="welcome-to">Welcome to<br /></span>
                    <span class="MeoMeoKji">MeoMeoKji<br /></span>
                  </p>
                  <img class="logo-meo" src="img/logomeo.png" />
                </div>
              </div>
              <br><br><br>
            <form action="updateuser.jsp" method="post"  onsubmit="return validateForm()" accept-charset="UTF-8">
                <!-- form action = "#" <로그인 처리페이지로 이동 -->
                <div class="name">
                    <div class="overlap-group">
                      <img class="img" src="img/userid.png" />
                      <div class="text-wrapper">새 이름</div>
                      <input class="div" type="text" id="newName" name="newName" >
                    </div>
                </div><br><br>
               
               
                <div class="password">
                    <div class="overlap-group">
                      <div class="text-wrapper">새 비밀번호</div>
                      <input input  class="div"  id="newPassword" type="password" name="newPassword" >
                      <img class="img" src="img/logokey-4ob.png" />
                    </div>
                </div><br><br>
                <div class="password">
                    <div class="overlap-group">
                      <div class="text-wrapper">새 비밀번호 확인</div>
                      <input  id="confirmPassword"  class="div" type="password" name="confirmPassword" >
                      <img class="img" src="img/logokey-4ob.png" />
                    </div>
                </div><br><br>
                <div class="submit_div">
                    <button>수정하기</button>
                </div>
                  
            </form>
            <form method="POST" action="deleteUser.jsp" onsubmit="return confirm('정말로 회원 탈퇴하시겠습니까?');">
            <div class="submit_div2">
                    <button>탈퇴하기</button>
                </div>
        
    </form>
        </div>
    </div>
    
    
    <script>
    function validateForm() {
        var password = document.getElementById("newPassword").value;
        var passwordcheck = document.getElementById("confirmPassword").value;

        if (password !== passwordcheck) {
            alert("비밀번호가 일치하지 않습니다.");
            return false; // 폼 제출을 막음
          }

          // Check if password meets the criteria (8 characters, at least one letter, and one number)
          var passwordRegex = /^(?=.*[A-Za-z])(?=.*\d).{8,}$/;
          if (!passwordRegex.test(password)) {
            alert("비밀번호는 8글자 이상이어야 하며, 영문과 숫자가 섞여야 합니다.");
            return false; // 폼 제출을 막음
          }

          return true; // 폼 제출을 허용
        }
    
  
    </script>
</body>
</html>
