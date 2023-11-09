<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
    request.setCharacterEncoding("UTF-8");
    <h1>새 위시리스트 생성</h1>
    <form action="createWishlist.jsp" method="post">
    <label for="wlname">위시리스트 이름:</label>
    <input type="text" id="wlname" name="wname" required>
    <br>
    <label for="category">카테고리 선택:</label>
    <select id="category" name="selectedCategory" required>
      <option value="" disabled selected>카테고리 선택</option>
      <%
        try {
          String selectCategorySQL = "SELECT C_Id, C_name FROM category";
          PreparedStatement pstmt = conn.prepareStatement(selectCategorySQL);
          rs = pstmt.executeQuery();

          while (rs.next()) {
            String C_Id = rs.getString("C_Id"); //카테고리 id
            String C_name = rs.getString("C_name"); //카테고리 이름
      %>
      <option value="<%= C_Id %>"><%= C_name %></option>
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
    String wishlistname = request.getParameter("wname");
    String selectedCategory = request.getParameter("selectedCategory");
  
    session = request.getSession();
    String userId = (String) session.getAttribute("id");
  
    // 위시리스트 ID와 카테고리 연결 ID 생성 (임의로 또는 UUID 사용)
    String wishlistId = "W-" + UUID.randomUUID().toString().replace("-", "");
    String WC_Id = "WC-" + UUID.randomUUID().toString().replace("-", "");
  
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
      pst.setString(1, WC_Id);
      pst.setString(2, wishlistId);
      pst.setString(3, selectedCategory);
      pst.executeUpdate();
      pst.close();
    } catch (SQLException e) {
      e.printStackTrace();
      
    }
  %>
</body>
</html>