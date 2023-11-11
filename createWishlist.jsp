<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Insert title here</title>
</head>
<body>
    <%@ include file="./dbconn.jsp" %>
    <h1>새 위시리스트 생성</h1>
    <form action="createWishlist.jsp" method="post">
        <label for="wlname">위시리스트 이름:</label>
        <input type="text" id="wlname" name="wlname" required>
        <br>
        <label for="category">카테고리 선택:</label><br>
        <a href="DeleteWishlist.jsp">dddd</a><br>
        
        <%
            request.setCharacterEncoding("UTF-8");
            List<String> selectedCategories = new ArrayList<>(); // 선택한 카테고리 값을 저장할 리스트

            try {
                String selectCategorySQL = "SELECT C_Id, C_name FROM category";
                PreparedStatement pstmt = conn.prepareStatement(selectCategorySQL);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    String C_Id = rs.getString("C_Id"); // 카테고리 id
                    String C_name = rs.getString("C_name"); // 카테고리 이름
        %>
        <input type="checkbox" name="selectedCategories" value="<%= C_Id %>"><%= C_name %><br>
        <%
                }
                rs.close();
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
        </select>
        <input type="submit" value="저장">
    </form>
    <%
        String wishlistname = request.getParameter("wlname");
        String[] selectedCategoriesArr = request.getParameterValues("selectedCategories");

        session = request.getSession();
        String userId = (String) session.getAttribute("id");

        // 위시리스트 ID 생성 (임의로 또는 UUID 사용)
        String wishlistId = "W-" + UUID.randomUUID().toString().replace("-", "").substring(0, 7);
        request.setAttribute("wishlistId", wishlistId);

        try {
            // 데이터베이스에 위시리스트 정보 저장
            String insertWishlistSQL = "INSERT INTO wishlist (wishlistId, userId, wishlistname) VALUES (?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(insertWishlistSQL);
            pst.setString(1, wishlistId);
            pst.setString(2, userId);
            pst.setString(3, wishlistname);
            pst.executeUpdate();
            pst.close();

            // 데이터베이스에 카테고리 정보 저장
            String insertCategorySQL = "INSERT INTO wishlist_category (WC_Id, wishlistId, C_Id) VALUES (?, ?, ?)";
            pst = conn.prepareStatement(insertCategorySQL);
            if (selectedCategoriesArr != null) {
                for (String selectedCategory : selectedCategoriesArr) {
                    String WC_Id = "WC-" + UUID.randomUUID().toString().replace("-", "").substring(0, 8);
                    pst.setString(1, WC_Id);
                    pst.setString(2, wishlistId);
                    pst.setString(3, selectedCategory);
                    pst.executeUpdate();
                }
            }
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
     <a href="javascript:void(0);" onclick="editWishlist('<%= wishlistId %>')">위시리스트 수정</a>
    <script>
        function editWishlist(wishlistId) {
            // wishlistId를 이용하여 editWishlist.jsp로 이동
            window.location.href = 'editWishlist.jsp?wishlistId=' + wishlistId;
        }
    </script>
</body>
</html>