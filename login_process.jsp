
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
 	String id = request.getParameter("userid");
 	String passwd = request.getParameter("password");
 	
	String sql = "select * from Users where userId = ? and password = ?";
	PreparedStatement pstmt = null;
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, passwd);

	String msg = "index.jsp";
	rs = pstmt.executeQuery();
	if(rs.next()) {
		//session
		session.setAttribute("id", rs.getString("userId"));
		session.setAttribute("name", rs.getString("name"));
		
		// 로그인 이후의 페이지 \
		msg = "mmjSearch.jsp";
	}
	
	response.sendRedirect(msg);




%>