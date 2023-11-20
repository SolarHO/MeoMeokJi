<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
</head>
<body>
    <h1>회원정보 수정</h1>
    <form action="updateuser.jsp" method="POST" onsubmit="return validateForm()" accept-charset="UTF-8">
        <label for="newName">새 이름:</label>
        <input type="text" id="newName" name="newName" required><br><br>
        
        <label for="newPassword">새 비밀번호:</label>
        <input type="password" id="newPassword" name="newPassword" required><br><br>
        
        <label for="confirmPassword">새 비밀번호 확인:</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required><br><br>
        
        <input type="submit" value="수정">
        
     
    </form>
      <form method="POST" action="deleteUser.jsp" onsubmit="return confirm('정말로 회원 탈퇴하시겠습니까?');">
        <input type="submit" value="회원 탈퇴">
    </form>
    
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
