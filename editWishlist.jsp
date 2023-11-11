<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.UUID" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>위시리스트</title>
</head>
<body>
    <%@ include file="./dbconn.jsp" %>

    <h1>위시리스트</h1>

    <form action="deletepage.jsp" method="post">
        <table>
            <a href="createWishlist.jsp">위시리스트 생성</a>
            <tr>
                <th>위시리스트 ID</th>
                <th>위시리스트 이름</th>
                <th>선택</th>
                <th>수정</th>
            </tr>
            <%   
            String userId = (String) session.getAttribute("id");

            try {
                String selectWishlistSQL = "SELECT wishlistId, wishlistname FROM wishlist WHERE userId = ?";
                PreparedStatement pstmt = conn.prepareStatement(selectWishlistSQL);
                pstmt.setString(1, userId);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    String wishlistId = rs.getString("wishlistId");
                    String wishlistname = rs.getString("wishlistname");
            %>
            <tr>
                <td><%= wishlistId %></td>
                <td><%= wishlistname %></td>
                <td><input type="checkbox" name="selectedWishlists" value="<%= wishlistId %>"></td>
                <td><a href="editWishlist.jsp?wishlistId=<%= wishlistId %>">수정</a></td>
            </tr>
            <%
                }
                rs.close();
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            %>
        </table>
        <input type="submit" value="삭제">
    </form>

    <!-- 위시리스트 수정 폼 -->
    <h1>위시리스트 수정</h1>
    
    <%
        // 기존 위시리스트 정보 가져오기
        String wishlistIdToEdit = request.getParameter("wishlistId");
        if (wishlistIdToEdit != null) {
            // 위시리스트 수정 폼 표시
            String selectWishlistSQL = "SELECT * FROM wishlist WHERE wishlistId=?";
            try {
                PreparedStatement selectWishlistPstmt = conn.prepareStatement(selectWishlistSQL);
                selectWishlistPstmt.setString(1, wishlistIdToEdit);
                ResultSet rsWishlist = selectWishlistPstmt.executeQuery();

                if (rsWishlist.next()) {
                    String existingWishlistname = rsWishlist.getString("wishlistname");
    %>
    
    <form action="updateWishlist.jsp" method="post">
        <label for="wlname">새로운 위시리스트 이름:</label>
        <input type="text" id="wlname" name="wlname" required value="<%= existingWishlistname %>">
        <br>
        <label for="category">카테고리 선택:</label><br>
        <%
            // 기존 카테고리 정보 가져오기
            String selectCategoriesSQL = "SELECT C_Id, C_name FROM category";
            PreparedStatement pstmt = conn.prepareStatement(selectCategoriesSQL);
            ResultSet rsCategories = pstmt.executeQuery();

            List<String> selectedCategories = new ArrayList<>();
            String selectWishlistCategoriesSQL = "SELECT C_Id FROM wishlist_category WHERE wishlistId=?";
            PreparedStatement pstmtWishlistCategories = conn.prepareStatement(selectWishlistCategoriesSQL);
            pstmtWishlistCategories.setString(1, wishlistIdToEdit);
            ResultSet rsWishlistCategories = pstmtWishlistCategories.executeQuery();

            // 기존에 선택된 카테고리 확인
            while (rsWishlistCategories.next()) {
                selectedCategories.add(rsWishlistCategories.getString("C_Id"));
            }

            while (rsCategories.next()) {
                String C_Id = rsCategories.getString("C_Id");
                String C_name = rsCategories.getString("C_name");
        %>
        <input type="checkbox" name="selectedCategories" value="<%= C_Id %>" <%= selectedCategories.contains(C_Id) ? "checked" : "" %>><%= C_name %><br>
        <%
            }
            rsCategories.close();
            pstmt.close();
            rsWishlistCategories.close();
            pstmtWishlistCategories.close();
        %>
        <input type="hidden" name="wishlistId" value="<%= wishlistIdToEdit %>">
        <input type="submit" value="수정">
    </form>
    <%
                }
                rsWishlist.close();
                selectWishlistPstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>