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
	<%@ include file="dbConnection.jsp" %>
  <h1>새 위시리스트 생성</h1>
  <form action="createWishlist.jsp" method="post">
    <label for="wlname">위시리스트 이름:</label>
    <input type="text" id="wlname" name="wlname" required>
    <br>
    <label for="category">카테고리 선택:</label>
    <select id="category" name="selectedCategory" required>
      <option value="" disabled selected>카테고리 선택</option>
      <%
        // 카테고리 데이터를 데이터베이스에서 가져와서 옵션으로 표시
        PreparedStatement pstmt = null;
        ResultSet rs = null;
  
        try {
          String selectCategorySQL = "SELECT categoryid, categoryname FROM category";
          pstmt = conn.prepareStatement(selectCategorySQL);
          rs = pstmt.executeQuery();
  
          while (rs.next()) {
            String categoryid = rs.getString("categoryid");
            String categoryname = rs.getString("categoryname");
      %>
      <option value="<%= categoryid %>"><%= categoryname %></option>
      <%
          }
        } catch (SQLException e) {
          e.printStackTrace();
        } finally {
          if (rs != null) rs.close();
          if (pstmt != null) pstmt.close();
          if (conn != null) conn.close();
        }
      %>
    </select>
    <input type="submit" value="저장">
  </form>
  <%
    String wlname = request.getParameter("wlname");
    String selectedCategory = request.getParameter("selectedCategory");
  
    HttpSession Session = request.getSession();
    String userid = (String) Session.getAttribute("userid");
  
    // 위시리스트 ID와 카테고리 연결 ID 생성 (임의로 또는 UUID 사용)
    String wlid = "W-" + UUID.randomUUID().toString().replace("-", "");
    String wcid = "WC-" + UUID.randomUUID().toString().replace("-", "");
  
    try {
      // 데이터베이스에 위시리스트 정보 저장
      String insertWishlistSQL = "INSERT INTO wishlist (wlid, userid, wlname) VALUES (?, ?, ?)";
      PreparedStatement pst = conn.prepareStatement(insertWishlistSQL);
      pst.setString(1, wlid);
      pst.setString(2, userid);
      pst.setString(3, wlname);
      pst.executeUpdate();
      pst.close();
  
      // 데이터베이스에 카테고리 정보 저장
      String insertCategorySQL = "INSERT INTO wishlist_category (wcid, wlid, categoryid) VALUES (?, ?, ?)";
      pst = conn.prepareStatement(insertCategorySQL);
      pst.setString(1, wcid);
      pst.setString(2, wlid);
      pst.setString(3, selectedCategory);
      pst.executeUpdate();
      pst.close();
  
      // 성공 페이지로 리디렉션 또는 메시지 표시
      response.sendRedirect("success.jsp");
    } catch (SQLException e) {
      e.printStackTrace();
      // 실패 페이지로 리디렉션 또는 오류 메시지 표시
      response.sendRedirect("error.jsp");
    }
  %>
</body>
</html>