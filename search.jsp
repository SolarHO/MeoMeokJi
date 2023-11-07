<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String sessionId = (String)session.getAttribute("id");
		if(sessionId == null ){
			%>
				<jsp:forward page="index.jsp"></jsp:forward>
			<%
			
		}
		
		%>
	<a href = "logout.jsp">로그아웃</a>
	
	<%=session.getAttribute("name") %>
</body>
</html>