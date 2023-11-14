<%@page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlists</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="./dbconn.jsp" %>
    
    <h1>내 위시리스트</h1>
    
    <%
        String userId = (String) session.getAttribute("id");

        try {
            // 현재 로그인한 사용자의 위시리스트 정보를 조회
            String selectWishlistsSQL = "SELECT wishlistId, wishlistname, name " +
                                        "FROM Users NATURAL JOIN wishlist " +
                                        "WHERE userId = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(selectWishlistsSQL)) {
                pstmt.setString(1, userId);
                rs = pstmt.executeQuery();
    %>

    <!-- 부트스트랩 테이블 -->
    <table class="table">
        <thead>
            <tr>
                <th>Wishlist ID</th>
                <th>Wishlist Name</th>
                <th>User Name</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (rs.next()) {
                    String wishlistId = rs.getString("wishlistId");
                    String wishlistName = rs.getString("wishlistname");
                    String name = rs.getString("name");
            %>
            <tr>
                <td><%= wishlistId %></td>
                <td><%= wishlistName %></td>
                <td><%= name %></td>
            </tr>
            <%
                }
            }
        } catch (Exception e) {
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
        </tbody>
    </table>

    <!-- Bootstrap JS 및 Popper.js 및 jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>