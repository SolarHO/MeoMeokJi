<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.UUID" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>위시리스트 저장</title>
</head>
<body>
    <%@ include file="./dbconn.jsp" %>
    <% request.setCharacterEncoding("utf-8"); %>
    <%
        String wishlistname = request.getParameter("wlname");
        String[] selectedCategoriesArr = request.getParameterValues("selectedCategories");

        session = request.getSession();
        String userId = (String) session.getAttribute("id");

        // 위시리스트 ID 생성 (임의로 또는 UUID 사용)
        String wishlistId = "W-" + UUID.randomUUID().toString().replace("-", "").substring(0, 7);
        request.setAttribute("wishlistId", wishlistId);

        try {
            conn.setAutoCommit(false); // 트랜잭션 시작

            // 데이터베이스에 위시리스트 정보 저장
            String insertWishlistSQL = "INSERT INTO wishlist (wishlistId, userId, wishlistname) VALUES (?, ?, ?)";
            try (PreparedStatement pst = conn.prepareStatement(insertWishlistSQL)) {
                pst.setString(1, wishlistId);
                pst.setString(2, userId);
                pst.setString(3, wishlistname);
                pst.executeUpdate();
            }

            // 데이터베이스에 카테고리 정보 저장
            String insertCategorySQL = "INSERT INTO wishlist_category (WC_Id, wishlistId, C_Id) VALUES (?, ?, ?)";
            try (PreparedStatement pst = conn.prepareStatement(insertCategorySQL)) {
                if (selectedCategoriesArr != null && selectedCategoriesArr.length > 0) {
                    for (String selectedCategory : selectedCategoriesArr) {
                        String WC_Id = "WC-" + UUID.randomUUID().toString().replace("-", "").substring(0, 8);
                        pst.setString(1, WC_Id);
                        pst.setString(2, wishlistId);
                        pst.setString(3, selectedCategory);
                        pst.executeUpdate();
                    }
                }
            }

            conn.commit(); // 모든 쿼리가 성공하면 커밋
        } catch (SQLException e) {
            conn.rollback(); // 실패하면 롤백
            e.printStackTrace();
        } finally {
            conn.setAutoCommit(true); // 트랜잭션 종료
        }
        response.sendRedirect("mmjWishlist.jsp");
    %>
</body>
</html>