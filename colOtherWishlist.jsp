<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="./dbconn.jsp" %>

<%
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");

request.setCharacterEncoding("UTF-8");
String userId = (String)session.getAttribute("id");
String searchOption = request.getParameter("searchOption");
String searchInput = request.getParameter("searchInput");

try {
    // Prepare the SQL statement based on the search criteria
    String selectWishlistsSQL = "SELECT wishlistId, wishlistname, name " +
            "FROM Users NATURAL JOIN wishlist " +
            "WHERE " + searchOption + " LIKE ? " +
            "ORDER BY wishlistId";

    try (PreparedStatement pstmt = conn.prepareStatement(selectWishlistsSQL)) {
        pstmt.setString(1, "%" + searchInput + "%");
        rs = pstmt.executeQuery();

        // Create a list to store wishlist data
        List<Map<String, String>> wishlistDataList = new ArrayList<>();

        while (rs.next()) {
            Map<String, String> wishlistData = new HashMap<>();
            wishlistData.put("wishlistId", rs.getString("wishlistId"));
            wishlistData.put("wishlistName", rs.getString("wishlistname"));
            wishlistData.put("userName", rs.getString("name"));
            wishlistDataList.add(wishlistData);
        }

        // Convert the list to JSON and write it to the response
        Gson gson = new Gson();
        String jsonData = gson.toJson(wishlistDataList);
        response.getWriter().write(jsonData);
    }
} catch (SQLException e) {
    e.printStackTrace();
    
} finally {
    // ResultSet 자원 해제
    if (rs != null) {
        try {
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
%>