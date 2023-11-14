<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.UUID" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Wishlist</title>
    <!-- Bootstrap CSS 추가 -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="./dbconn.jsp" %>
    <h1>새 위시리스트 생성</h1>
    <form action="saveWishlist.jsp" method="post">
        <label for="wlname">위시리스트 이름:</label>
        <input type="text" id="wlname" name="wlname" class="form-control" required>
        <br>
        <label for="category">카테고리 선택:</label><br>
        
        <%
            request.setCharacterEncoding("UTF-8");
            List<String> selectedCategories = new ArrayList<>(); // 선택한 카테고리 값을 저장할 리스트

            try {
                String selectCategorySQL = "SELECT C_Id, C_name FROM category";
                PreparedStatement pstmt = conn.prepareStatement(selectCategorySQL);
                rs = pstmt.executeQuery();
        %>
        <!-- 부트스트랩 토글 버튼 체크박스로 변경 -->
        <div class="btn-group-toggle" data-toggle="buttons">
        <%
                while (rs.next()) {
                    String C_Id = rs.getString("C_Id"); // 카테고리 id
                    String C_name = rs.getString("C_name"); // 카테고리 이름
        %>
            <label class="btn btn-light">
                <input type="checkbox" name="selectedCategories" value="<%= C_Id %>" autocomplete="off">
                <%= C_name %>
            </label>
        <%
                }
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
        </div>
        <br>
        <input type="submit" value="저장" class="btn btn-primary">
    </form>

    <!-- Bootstrap JS 및 Popper.js 및 jQuery 추가 -->
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

	<script>
	$(document).ready(function () {
        $('.btn-group-toggle .btn').on('click', function () {
            $(this).toggleClass('active');
        });
    });
	</script>
</body>
</html>