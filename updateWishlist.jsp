<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.Arrays" %>

<%@ include file="./dbconn.jsp" %>

<%
request.setCharacterEncoding("UTF-8");

String wishlistId = request.getParameter("wishlistId");
String wishlistname = request.getParameter("wlname");
String[] selectedCategoriesArr = request.getParameterValues("selectedCategories");

try {
    // 데이터베이스에서 기존 카테고리 정보 삭제
    String deleteCategoriesSQL = "DELETE FROM wishlist_category WHERE wishlistId=?";
    PreparedStatement deleteCategoriesPstmt = conn.prepareStatement(deleteCategoriesSQL);
    deleteCategoriesPstmt.setString(1, wishlistId);
    deleteCategoriesPstmt.executeUpdate();
    deleteCategoriesPstmt.close();

    // 새로운 카테고리 정보 저장
    String insertCategorySQL = "INSERT INTO wishlist_category (WC_Id, wishlistId, C_Id) VALUES (?, ?, ?)";
    PreparedStatement insertCategoryPstmt = conn.prepareStatement(insertCategorySQL);
    if (selectedCategoriesArr != null) {
        for (String selectedCategory : selectedCategoriesArr) {
            String WC_Id = "WC-" + UUID.randomUUID().toString().replace("-", "").substring(0, 8);
            insertCategoryPstmt.setString(1, WC_Id);
            insertCategoryPstmt.setString(2, wishlistId);
            insertCategoryPstmt.setString(3, selectedCategory);
            insertCategoryPstmt.executeUpdate();
        }
    }
    insertCategoryPstmt.close();

    // 위시리스트 정보 업데이트
    String updateWishlistSQL = "UPDATE wishlist SET wishlistname=? WHERE wishlistId=?";
    PreparedStatement updateWishlistPstmt = conn.prepareStatement(updateWishlistSQL);
    updateWishlistPstmt.setString(1, wishlistname);
    updateWishlistPstmt.setString(2, wishlistId);
    updateWishlistPstmt.executeUpdate();
    updateWishlistPstmt.close();

    response.sendRedirect("createWishlist.jsp"); // 수정 후 이동할 페이지
} catch (SQLException e) {
    e.printStackTrace();
}
%>