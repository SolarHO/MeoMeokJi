<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
</head>
<body>
<h1>회원가입이 완료되었습니다.</h1><br>
<h3> 로그인 페이지로 돌아가십시오</h3><br>
<% response.setContentType("text/html;charset=UTF-8");
   response.getWriter().println("<script>alert('회원가입에 성공하였습니다. 다시 로그인하십시오 '); setTimeout(function(){ window.location.href='logout.jsp'; }, 500);</script>");
%></body>
</html>